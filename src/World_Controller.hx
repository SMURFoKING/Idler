import Gui_Contraptions.calculateContraptionBoxPositions;
import h2d.Scene;


final class World_Controller {
	static var background:Background;
	static var block_spawner:Block_Spawner;

	static var diggable_width:UInt = 5;

	static var dirt_width:UInt = 16;
	static var dirt_scale:UInt = 2;
	
	static var block_width:UInt = 32;
	static var block_scale:UInt = 1;

    static var bg_start_height:UInt = 4;
    static var block_start_height:UInt = bg_start_height + 2;

	static public function init(scene:Scene, size:UInt = 32) {
		background = new Background(scene, dirt_width, dirt_scale, diggable_width, bg_start_height);
		block_spawner = new Block_Spawner(scene, block_width, block_scale, diggable_width, block_start_height);

        Gui_Contraptions.calculateContraptionBoxPositions(scene.width, size, diggable_width, block_start_height);
	}

	static public function update(scene:Scene){
		block_spawner.update(scene);
	}

	static public function onResize() {}
}
