import Background;
import GameState.BackgroundState;
import h2d.Scene;

var bg_state:BackgroundState;

final class World_Controller {
	static var block_spawner:Block_Spawner;

	static var diggable_width:UInt = 5;

	static var dirt_width:UInt = 16;
	static var dirt_scale:UInt = 2;
	
	static var block_width:UInt = 32;
	static var block_scale:UInt = 1;

    static var bg_start_height:UInt = 4;
    static var block_start_height:UInt = bg_start_height + 2;

	static public function init(scene:Scene, size:UInt = 32) {
		bg_state = initBGState(dirt_width, dirt_scale, bg_start_height);
		bg_state.sides_tilegroup = setSidesTileGroupSettingsForBG(bg_state.sides_tilegroup);
		bg_state.middle_tilegroup = setMiddleTileGroupSettingsForBG(bg_state.middle_tilegroup);

		createBG(scene.width, diggable_width);
		scene.add(bg_state.sides_tilegroup);
		scene.add(bg_state.middle_tilegroup);

		block_spawner = new Block_Spawner(scene, block_width, block_scale, diggable_width, block_start_height);

        Gui_Contraptions.calculateContraptionBoxPositions(scene.width, size, diggable_width, block_start_height);
	}

	static public function update(scene:Scene){
		block_spawner.update(scene);
	}

	static public function onResize() {}
}
