import hxd.res.Image;
import h2d.Scene;
import h2d.TileGroup;
import h3d.Vector4;

class Background {  
    public var background_controller:h2d.Object;
    
    var bg_side_tilegroup = new TileGroup();
    var bg_middle_tilegroup = new TileGroup();

    var bg_image_dirt:Image;
    var bg_image_grass:Image;

    var diggable_width:UInt;
    var bg_start_height = 4;

    public function new(scene:Scene, dirt_width:UInt, dirt_scale:UInt, diggable_width:UInt){
        bg_image_dirt = hxd.Res.background.dirt;
        bg_image_grass = hxd.Res.background.grass_block_side;

        bg_side_tilegroup= new h2d.TileGroup(scene);
        bg_middle_tilegroup= new h2d.TileGroup(scene);
        this.diggable_width = diggable_width;

        createDirtBackground(scene, dirt_width, dirt_scale);
    }

    function createDirtBackground(scene:Scene, dirt_width:UInt, dirt_scale:UInt){
        bg_side_tilegroup.setScale(dirt_scale);
        bg_middle_tilegroup.setScale(dirt_scale);
        bg_middle_tilegroup.color = new Vector4(0.6, 0.6, 0.65, 1);

        var dirt_tile = bg_image_dirt.toTile();
        var grass_tile = bg_image_grass.toTile();
        var size = dirt_width * dirt_scale;

        var adjusted_scene_middle = scene.width / 2 / size;
        var adjusted_end = Std.int(scene.width / size);

        var flag = 0;
        for (x in 0...adjusted_end){
            for (y in bg_start_height...size){
                if(x < adjusted_scene_middle - diggable_width
                     || x >= adjusted_scene_middle + diggable_width ){
                    if(y == bg_start_height)
                        bg_side_tilegroup.add(x * grass_tile.width, y*grass_tile.height, grass_tile);
                    else 
                        bg_side_tilegroup.add(x * dirt_tile.width, y * dirt_tile.height, dirt_tile);
                   }
                else{
                    if(y == bg_start_height)
                        bg_middle_tilegroup.add(x * grass_tile.width, y*grass_tile.height, grass_tile);
                    else
                        bg_middle_tilegroup.add(x * dirt_tile.width, y*grass_tile.height, dirt_tile);
                    // if(flag < 5) {
                    //     trace(x * dirt_tile.width + ", " + y * dirt_tile.height);
                    //     flag++;
                    // }
                }
            }
        }
    }

    public function init(){
    }

    function update(){
    }
}
