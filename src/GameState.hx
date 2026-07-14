import Block_Spawner.BlockTiles;
import hxd.Rand;
import hxd.res.Image;
import h2d.TileGroup;
import h2d.Tile;
import Block_Spawner.Block;

typedef GameState = {}

typedef WorldState = {
	diggable_width:UInt
}

typedef BackgroundState = {
	width:UInt,
	scale:UInt,
	start_height:UInt,
	size:UInt,

	dirt_tile:Tile,
	grass_tile:Tile,
	dirt_image:Image,
	grass_image:Image,

	sides_tilegroup:TileGroup,
	middle_tilegroup:TileGroup
}

typedef BlockState = {
    blockTiles:BlockTiles,
	activeBlocks:Array<Array<Block>>,
	activeBlockCountInRow:Array<UInt>,

	stoneTile:Tile,
    width:UInt,
	scale:UInt,
    size: UInt,
	startHeight:UInt,
    sceneMiddle:Float,
    adjustedStartX:Float,
    adjustedStartY:Float,

    previousBlockHeight:UInt,

    rand:Rand
}

typedef MineableBlockState = {}
