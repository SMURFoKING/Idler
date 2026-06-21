import hxd.res.DefaultFont;
import hxd.App;
import h2d.Object;

class Main extends hxd.App {
    
    
    var bmp : h2d.Bitmap;
    override function init(){
        var tf = new h2d.Text(DefaultFont.get(), s2d);
        tf.text = "Hello :)";

        var tile = h2d.Tile.fromColor(0xFF0000, 100, 100);
        bmp = new h2d.Bitmap(tile, s2d);

        bmp.x = s2d.width * 0.5;
        bmp.y = s2d.height * 0.5;
    }

    override function update(dt:Float){
        bmp.rotation += 0.1;
    }

    static function main() {
        new Main();
    }
}