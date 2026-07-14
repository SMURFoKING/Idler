import Block_Spawner.createBlocks;
import Block_Spawner.loadOreImages;
import Block_Spawner.initBlockState;
import GameState.WorldState;
import GameState.BlockState;
import Background;
import GameState.BackgroundState;
import h2d.Scene;

var worldState:WorldState;
var bgState:BackgroundState;
var blockState:BlockState;

final class World_Controller {
	static var diggable_width:UInt = 5;

	static var dirt_width:UInt = 16;
	static var dirt_scale:UInt = 2;
	
	static var block_width:UInt = 32;
	static var block_scale:UInt = 1;

    static var bg_start_height:UInt = 4;
    static var block_start_height:UInt = bg_start_height + 2;

	static public function init(scene:Scene, size:UInt = 32) {
		worldState = {
			diggable_width: diggable_width
		}		

		bgState = initBGState(dirt_width, dirt_scale, bg_start_height);
		bgState.sides_tilegroup = setSidesTileGroupSettingsForBG(bgState.sides_tilegroup);
		bgState.middle_tilegroup = setMiddleTileGroupSettingsForBG(bgState.middle_tilegroup);

		createBG(scene.width, diggable_width);
		scene.add(bgState.sides_tilegroup);
		scene.add(bgState.middle_tilegroup);

		blockState = initBlockState(block_width, block_scale, bg_start_height + 2, scene.width / 2, diggable_width);
		blockState.blockTiles = loadOreImages();
		blockState.stoneTile = blockState.blockTiles.getByIndex(0);
		blockState.activeBlocks = createBlocks(scene, diggable_width);
		
        Gui_Contraptions.calculateContraptionBoxPositions(scene.width, size, diggable_width, block_start_height);
	}

	static public function onResize() {}
}
