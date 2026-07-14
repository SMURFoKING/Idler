import hxd.res.Image;
import h2d.TileGroup;
import h2d.Tile;

typedef GameState = {}
typedef WorldState = {}

typedef BackgroundState = {
    public var width:UInt;
    public var scale:UInt;
    public var start_height:UInt;
    public var size:UInt;

	public var dirt_tile:Tile;
	public var grass_tile:Tile;
    public var dirt_image:Image;
    public var grass_image:Image;

	public var sides_tilegroup:TileGroup;
	var middle_tilegroup:TileGroup;
}

typedef MineableBlockState = {}
