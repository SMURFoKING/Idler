import h2d.TileGroup;
import h2d.Scene;

class Main extends hxd.App {

    var background:Background; 
    override function init(){
        hxd.Res.initEmbed();

        background = new Background(s2d);
        background.init();
    }

    override function update(dt:Float){
    }

    static function main() {
        new Main();
    }
}

class Background {  
    public var background_controller:h2d.Object;
    var bg_obj_dirt:h2d.Object;

    public function new(scene:Scene){
        var bg_image_dirt = hxd.Res.background.dirt;
        
        var bg_dirt = new h2d.TileGroup();
        
    }

    function createDirtBackground(){
        var bg_dirt = new TileGroup();

        var size = 32;
        for (x in 0...size){
            for (y in 0...size){
                bg_dirt.addChildAt()
            }
        }
    }

    public function init(){
    }

    function update(){

    }
}


