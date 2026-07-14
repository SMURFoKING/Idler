import World_Controller.bgState;
import GameState.BackgroundState;
import h2d.TileGroup;
import h3d.Vector4;


function initBGState(block_width:UInt, block_scale:UInt, start_height:UInt):BackgroundState {
	var state:BackgroundState = {
		width: block_width,
		scale: block_scale,
		start_height: start_height,
		size: block_width * block_scale,

		dirt_image: hxd.Res.background.dirt,
		dirt_tile: hxd.Res.background.dirt.toTile(),
		grass_image: hxd.Res.background.grass_block_side,
		grass_tile: hxd.Res.background.grass_block_side.toTile(),
		sides_tilegroup: new TileGroup(),
		middle_tilegroup: new TileGroup()
	};

	return state;
}

function setSidesTileGroupSettingsForBG(tileGroup:TileGroup):TileGroup {
	tileGroup.setScale(bgState.scale);
	return tileGroup;
}

function setMiddleTileGroupSettingsForBG(tileGroup:TileGroup):TileGroup {
	tileGroup.setScale(bgState.scale);
	tileGroup.color = new Vector4(0.6, 0.6, 0.65, 1);
	return tileGroup;
}

// still wrong, has hidden side effects: changes state from inside the function of both bg tilegroups.
// requires splitting function into multiple to fix. Will do additional changes to allow more flexibility so im holding off.
function createBG(scene_width:UInt, diggable_width:UInt) {
	var adjusted_scene_middle = scene_width / 2 / bgState.size;
	var adjusted_end = Std.int(scene_width / bgState.size);

	for (x in 0...adjusted_end) {
		for (y in bgState.start_height...bgState.size) {
			if (x < adjusted_scene_middle - diggable_width || x >= adjusted_scene_middle + diggable_width) {
				if (y == bgState.start_height)
					bgState.sides_tilegroup.add(x * bgState.grass_tile.width, y * bgState.grass_tile.height, bgState.grass_tile);
				else
					bgState.sides_tilegroup.add(x * bgState.dirt_tile.width, y * bgState.dirt_tile.height, bgState.dirt_tile);
			} else {
				if (y == bgState.start_height)
					bgState.middle_tilegroup.add(x * bgState.grass_tile.width, y * bgState.grass_tile.height, bgState.grass_tile);
				else
					bgState.middle_tilegroup.add(x * bgState.dirt_tile.width, y * bgState.grass_tile.height, bgState.dirt_tile);
			}
		}
	}
}
