import hxd.res.Image;
import h2d.Object;
import imgui.ImGui;
import imgui.ImGuiDrawable;
import h2d.TileGroup;
import h2d.Scene;

class Main extends hxd.App {

    var background:Background; 
    var gui:Gui;
    

    override function init(){
        hxd.Res.initEmbed();

        background = new Background(s2d);
        background.init();

        gui = new Gui(s2d);
    }

    override function update(dt:Float){
        gui.update(s2d.getScene(), dt);
    }
    
    override function onResize() {
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
    var bg_obj_dirt:h2d.Object;
    var bg_image_dirt:Image;

    public function new(scene:Scene){
        bg_image_dirt = hxd.Res.background.dirt;
        scene.addChild(bg_image_dirt);

        var bg_dirt = new h2d.TileGroup();
        
    }

    function createDirtBackground(){
        var bg_dirt = new TileGroup();

        var size = 32;
        for (x in 0...size){
            for (y in 0...size){
                // bg_dirt.addChildAt();
            }
        }
    }

    public function init(){
    }

    function update(){

    }
}


