import h2d.Bitmap;
import h3d.mat.Texture;
import h2d.Tile;

class Contraption_Controller {
	static public var contraptionHolder:Array<ContraptionBaseType>;

	static public function init() {
		contraptionHolder = new Array<ContraptionBaseType>();
	}

	static public function zapper_hit() {}
}

class ZapperType extends ContraptionBaseType {
	static var cost:UInt = null;

	static public function init() {
		ContraptionBaseType.name = "Zapper";
		ContraptionBaseType.baseCost = 10;
		ContraptionBaseType.baseDamage = 10;

		ContraptionBaseType.tile = hxd.Res.contraptions.kinetic_generator_vent_1.toTile();
		ContraptionBaseType.texture = hxd.Res.contraptions.kinetic_generator_vent_1.toTexture();
	}

	static public function getName() {
		
	}

	static public function getCost() {
		if (cost == null)
			return ContraptionBaseType.baseCost;
		else
			return cost;
	}
}

class BurnerType extends ContraptionBaseType {
	public function new() {
		ContraptionBaseType.name = "Burner";
		ContraptionBaseType.baseCost = 100;
		ContraptionBaseType.baseDamage = 5;

		ContraptionBaseType.tile = hxd.Res.contraptions.heart_fire.toTile();
		ContraptionBaseType.texture = hxd.Res.contraptions.heart_fire.toTexture();
	}
}

class ContraptionBaseType {
	static public var name = "Contraption";
	static public var baseCost:UInt = 0;
	static public var baseDamage:UInt = 0;

	static var tile:Tile = null;
	static var texture:Texture = null;
	static var bitmap:Bitmap = null;

	public static var active:Array<ContraptionBaseType>;

	static public function getName():String {
		return name;
	}

	static public function getCost():UInt {
		return baseCost;
	}
}
