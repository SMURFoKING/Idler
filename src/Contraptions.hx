import h3d.mat.Texture;
import h2d.Tile;

class Contraptions {
	static public var zapper:ContraptionType = {
		name: "Zapper",
		cost: 10,
		damage: 2,
		count: 1,
		tile: null,
		texture: null,
		bitmap: null
	};

	static public var burner:ContraptionType = {
		name: "Burner",
		cost: 100,
		damage: 5,
		count: 1,
		tile: null,
		texture: null,
		bitmap: null
	}

	static public function init() {
		zapper.tile = hxd.Res.contraptions.kinetic_generator_vent_1.toTile();
		zapper.texture = hxd.Res.contraptions.kinetic_generator_vent_1.toTexture();

		burner.tile = hxd.Res.contraptions.heart_fire.toTile();
		burner.texture = hxd.Res.contraptions.heart_fire.toTexture();
	}

	static public function zapper_hit() {}
}

typedef ContraptionType = {
	name:String,
	cost:Float,
	damage:Float,
	count:UInt,
	tile:Tile,
	texture:Texture,
	bitmap:h2d.Bitmap
}
