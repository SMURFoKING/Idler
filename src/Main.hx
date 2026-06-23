import hxd.fmt.blend.Data.Block;
import hxd.Window;
import h2d.Scene;
import imgui.ImGui;
import imgui.ImGuiDrawable;

import h2d.TileGroup;
import hxd.res.Image;
import h3d.Vector4;


class Main extends hxd.App {
    var isInitReady = false;

    var gui:Gui;
    var background:Background; 
    var block_spawner:Block_Spawner;

    override function init(){
        var window = Window.getInstance();
        window.title = "idler";
        window.resize(1920, 1080);

        hxd.Res.initLocal();

        background = new Background(s2d);
        block_spawner = new Block_Spawner();

        gui = new Gui(s2d);

        isInitReady = true;
    }

    override function update(dt:Float){
        gui.update(s2d.getScene(), dt);
    }
    
    override function onResize() {
        if (!isInitReady) return;

        ImGui.setDisplaySize(this.s2d.width, this.s2d.height);
    }

    static function main() {
        new Main();
    }
}

class Gui{
    var drawable:ImGuiDrawable;

    public function new(scene:Scene){
        this.drawable = new ImGuiDrawable(scene);

        ImGui.setDisplaySize(scene.width, scene.height);
    }

    public function update(scene:Scene, dt:Float){
        drawable.update(dt);

        ImGui.newFrame();

        ImGui.showDemoWindow();

        ImGui.render();
    }
}

class Background {  
    public var background_controller:h2d.Object;
    
    var bg_side_tilegroup = new TileGroup();
    var bg_middle_tilegroup = new TileGroup();

    var bg_image_dirt:Image;
    var bg_image_grass:Image;

    public function new(scene:Scene){
        bg_image_dirt = hxd.Res.background.dirt;
        bg_image_grass = hxd.Res.background.grass_block_side;

        bg_side_tilegroup= new h2d.TileGroup(scene);
        bg_middle_tilegroup= new h2d.TileGroup(scene);
        createDirtBackground(scene);
    }

    function createDirtBackground(scene:Scene){
        bg_side_tilegroup.setScale(2.2);
        bg_middle_tilegroup.setScale(2.2);
        bg_middle_tilegroup.color = new Vector4(0.6, 0.6, 0.65, 1);

        var size = 32;
        var dirt_tile = bg_image_dirt.toTile();
        var grass_tile = bg_image_grass.toTile();
        
        for (x in -2...size*2){
            for (y in 0...size){
                if(x < size-6 || size+6 < x){
                    if(y == 0)
                        bg_side_tilegroup.add(x * grass_tile.width, y*grass_tile.height, grass_tile);
                    else 
                        bg_side_tilegroup.add(x * dirt_tile.width, y * dirt_tile.height, dirt_tile);
                   }
                else{
                    if(y == 0)
                        bg_middle_tilegroup.add(x * grass_tile.width, y*grass_tile.height, grass_tile);
                    else
                        bg_middle_tilegroup.add(x * dirt_tile.width, y*grass_tile.height, dirt_tile);
                }
            }
        }
    }


    public function init(){
    }

    function update(){

    }
}


