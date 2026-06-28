import h2d.Interactive;
import haxe.io.Float32Array;
import h2d.Bitmap;
import hxd.Rand;
import h2d.Scene;
import h2d.Tile;
import Gui;

class Block_Spawner {
	var block_tiles:Blocks;
	var stone_tile:Tile = null;
	var active_blocks:Array<Array<Bitmap>>;

	var diggable_width:UInt;
	var start_height = 6;

	var block_size:UInt;
	var block_width:UInt;
	var block_scale:UInt;
	var scene_middle:Float;
	var adjusted_start_x:Float;
	var adjusted_start_y:Float;

	var rand:Rand;

	public function new(scene:Scene, block_width:UInt, block_scale:UInt, diggable_width:UInt) {
		active_blocks = new Array<Array<Bitmap>>();
		rand = new Rand(Std.int(Date.now().getSeconds()));
		loadOreImages();

		this.diggable_width = diggable_width;
		this.block_size = block_width * block_scale;
		this.block_width = block_width;
		this.block_scale = block_scale;

		this.scene_middle = scene.width / 2;
		this.adjusted_start_x = scene_middle - (diggable_width * block_size);
		this.adjusted_start_y = start_height * block_size;

		this.stone_tile = block_tiles.getByIndex(0);

		createBlocks(scene);
	}

	function createBlocks(scene:Scene) {

		for (x in 0...diggable_width * 2) {
			active_blocks.push(new Array<Bitmap>());

			for (y in 0...diggable_width * 2) {
				if (active_blocks[x] == null)
					active_blocks[x] = new Array<Bitmap>();

				addBlock(scene, x, y);
			}
		}
	}

	
	public function addNewBlockRow(scene:Scene){
		for(x in 0...diggable_width * 2){
			active_blocks.push(new Array<Bitmap>());

		}

	}

	function addBlock(scene:Scene, x:Int, y:Int){
		var random_block_index = rand.random((Reflect.fields(block_tiles).length - 1)) + 1; // - 1, then + 1 to skip first loaded tile, background
		var block_tile = block_tiles.getByIndex(random_block_index);

		var block = new h2d.Bitmap(block_tile);
		if (block.scale != null || block.x != 0)
			block.setScale(block_scale);
		else {
			block.width = block_size;
			block.height = block_size;
		}

		var stone_background = new Bitmap(stone_tile);
		stone_background.setPosition(adjusted_start_x + x * block_size, adjusted_start_y + y * block_size);
		stone_background.setScale(block_scale);
		scene.addChild(stone_background);

		block.setPosition(adjusted_start_x + x * block_size, adjusted_start_y + y * block_size);
		scene.addChild(block);
		active_blocks[x][y] = block;

		var interaction = new h2d.Interactive(block_width, block_width, block);

		block.addChild(interaction);
		interaction.backgroundColor = 5;
		interaction.onOver = function(event) {
			if (Gui.debugObject) {
				Gui_Debug.hoveredPosition = block.getAbsPos();
				Gui_Debug.hoveredTile = block_tiles.getNameByIndex(random_block_index);
				Gui_Debug.renderDebugOverlay(scene, block);
			}
		}
		interaction.onClick = function(event) {
			removeBlock(block, x, y, interaction, stone_background);
		}
	}

	function removeBlock(block:Bitmap, x:Int, y:Int, interaction:Interactive, background:Bitmap) {
		interaction.remove();
		interaction.onOver = null;
		interaction.onClick = null;
		block.remove();
		active_blocks[x][y];

		background.remove();
	}

	function loadOreImages() {
		block_tiles = new Blocks();

		block_tiles.background = hxd.Res.ores.ore_background.toTile();
		block_tiles.apatite = hxd.Res.ores.apatite.toTile();
		block_tiles.aquamarine = hxd.Res.ores.aquamarine.toTile();
		block_tiles.bauxite = hxd.Res.ores.bauxite_ore.toTile();
		block_tiles.boron = hxd.Res.ores.boron.toTile();
		block_tiles.cinnabar = hxd.Res.ores.cinnabar_ore.toTile();
		block_tiles.coal = hxd.Res.ores.coal.toTile();
		block_tiles.copper = hxd.Res.ores.copper.toTile();
		block_tiles.diamond = hxd.Res.ores.diamond.toTile();
		block_tiles.emerald = hxd.Res.ores.emerald.toTile();
		block_tiles.friscion = hxd.Res.ores.friscion.toTile();
		block_tiles.galena = hxd.Res.ores.galena_ore.toTile();
		block_tiles.garfax = hxd.Res.ores.garfax.toTile();
		block_tiles.gold = hxd.Res.ores.gold.toTile();
		block_tiles.iridium = hxd.Res.ores.iridium_ore.toTile();
		block_tiles.iron = hxd.Res.ores.iron.toTile();
		block_tiles.kelline = hxd.Res.ores.kelline.toTile();
		block_tiles.lapis = hxd.Res.ores.lapis.toTile();
		block_tiles.lead = hxd.Res.ores.lead_ore.toTile();
		block_tiles.lithium = hxd.Res.ores.lithium.toTile();
		block_tiles.magnesium = hxd.Res.ores.magnesium.toTile();
		block_tiles.mithril = hxd.Res.ores.mithril.toTile();
		block_tiles.morganine = hxd.Res.ores.morganine.toTile();
		block_tiles.nickel = hxd.Res.ores.ore_nickel.toTile();
		block_tiles.platinum = hxd.Res.ores.platinum.toTile();
		block_tiles.silver = hxd.Res.ores.silver.toTile();
		block_tiles.thorium = hxd.Res.ores.thorium.toTile();
		block_tiles.tin = hxd.Res.ores.tin.toTile();
		block_tiles.peridot = hxd.Res.ores.peridot_ore.toTile();
		block_tiles.peridot_stone = hxd.Res.ores.peridot_ore_stone.toTile();
		block_tiles.pyrite = hxd.Res.ores.pyrite_ore.toTile();
		block_tiles.quartz_certus = hxd.Res.ores.quartz_certus.toTile();
		block_tiles.quartz_certus_charged = hxd.Res.ores.quartz_certus_charged.toTile();
		block_tiles.racheline = hxd.Res.ores.racheline.toTile();
		block_tiles.redstone = hxd.Res.ores.redstone.toTile();
		block_tiles.ruby = hxd.Res.ores.ruby.toTile();
		block_tiles.sapphire = hxd.Res.ores.sapphire.toTile();
		block_tiles.sheldonite = hxd.Res.ores.sheldonite_ore.toTile();
		block_tiles.sheldonite_stone = hxd.Res.ores.sheldonite_ore_stone.toTile();
		block_tiles.sodalite = hxd.Res.ores.sodalite_ore.toTile();
		block_tiles.sodalite_stone = hxd.Res.ores.sodalite_ore_stone.toTile();
		block_tiles.sphalerite = hxd.Res.ores.sphalerite_ore.toTile();
		block_tiles.tungsten = hxd.Res.ores.tungsten_ore.toTile();
		block_tiles.tungsten_stone = hxd.Res.ores.tungsten_ore_stone.toTile();
	}

	function update(scene:Scene) {}
}

@:structInit
class Blocks {
	public function new() {}

	@:arrayAccess
	public inline function getByIndex(index:Int):Tile {
		return switch (index) {
			case 0: this.background;
			case 1: this.apatite;
			case 2: this.aquamarine;
			case 3: this.bauxite;
			case 4: this.boron;
			case 5: this.cinnabar;
			case 6: this.coal;
			case 7: this.copper;
			case 8: this.diamond;
			case 9: this.emerald;
			case 10: this.friscion;
			case 11: this.galena;
			case 12: this.garfax;
			case 13: this.gold;
			case 14: this.iridium;
			case 15: this.iron;
			case 16: this.kelline;
			case 17: this.lapis;
			case 18: this.lead;
			case 19: this.lithium;
			case 20: this.magnesium;
			case 21: this.mithril;
			case 22: this.morganine;
			case 23: this.nickel;
			case 24: this.platinum;
			case 25: this.silver;
			case 26: this.thorium;
			case 27: this.tin;
			case 28: this.peridot;
			case 29: this.peridot_stone;
			case 30: this.pyrite;
			case 31: this.quartz_certus;
			case 32: this.quartz_certus_charged;
			case 33: this.racheline;
			case 34: this.redstone;
			case 35: this.ruby;
			case 36: this.sapphire;
			case 37: this.sheldonite;
			case 38: this.sheldonite_stone;
			case 39: this.sodalite;
			case 40: this.sodalite_stone;
			case 41: this.sphalerite;
			case 42: this.tungsten;
			case 43: this.tungsten_stone;
			default: throw "index out of bounds";
		}
	}

	@:arrayAccess
	public inline function getNameByIndex(index:Int):String {
		return switch (index) {
			case 0: "background";
			case 1: "apatite";
			case 2: "aquamarine";
			case 3: "bauxite";
			case 4: "boron";
			case 5: "cinnabar";
			case 6: "coal";
			case 7: "copper";
			case 8: "diamond";
			case 9: "emerald";
			case 10: "friscion";
			case 11: "galena";
			case 12: "garfax";
			case 13: "gold";
			case 14: "iridium";
			case 15: "iron";
			case 16: "kelline";
			case 17: "lapis";
			case 18: "lead";
			case 19: "lithium";
			case 20: "magnesium";
			case 21: "mithril";
			case 22: "morganine";
			case 23: "nickel";
			case 24: "platinum";
			case 25: "silver";
			case 26: "thorium";
			case 27: "tin";
			case 28: "peridot";
			case 29: "peridot_stone";
			case 30: "pyrite";
			case 31: "quartz_certus";
			case 32: "quartz_certus_charged";
			case 33: "racheline";
			case 34: "redstone";
			case 35: "ruby";
			case 36: "sapphire";
			case 37: "sheldonite";
			case 38: "sheldonite_stone";
			case 39: "sodalite";
			case 40: "sodalite_stone";
			case 41: "sphalerite";
			case 42: "tungsten";
			case 43: "tungsten_stone";
			default: throw "index out of bounds";
		}
	}

	@:optional public var background:h2d.Tile = null;
	@:optional public var apatite:h2d.Tile = null;
	@:optional public var aquamarine:h2d.Tile = null;
	@:optional public var bauxite:h2d.Tile = null;
	@:optional public var boron:h2d.Tile = null;
	@:optional public var cinnabar:h2d.Tile = null;
	@:optional public var coal:h2d.Tile = null;
	@:optional public var copper:h2d.Tile = null;
	@:optional public var diamond:h2d.Tile = null;
	@:optional public var emerald:h2d.Tile = null;
	@:optional public var friscion:h2d.Tile = null;
	@:optional public var galena:h2d.Tile = null;
	@:optional public var garfax:h2d.Tile = null;
	@:optional public var gold:h2d.Tile = null;
	@:optional public var iridium:h2d.Tile = null;
	@:optional public var iron:h2d.Tile = null;
	@:optional public var kelline:h2d.Tile = null;
	@:optional public var lapis:h2d.Tile = null;
	@:optional public var lead:h2d.Tile = null;
	@:optional public var lithium:h2d.Tile = null;
	@:optional public var magnesium:h2d.Tile = null;
	@:optional public var mithril:h2d.Tile = null;
	@:optional public var morganine:h2d.Tile = null;
	@:optional public var nickel:h2d.Tile = null;
	@:optional public var platinum:h2d.Tile = null;
	@:optional public var silver:h2d.Tile = null;
	@:optional public var thorium:h2d.Tile = null;
	@:optional public var tin:h2d.Tile = null;
	@:optional public var peridot:h2d.Tile = null;
	@:optional public var peridot_stone:h2d.Tile = null;
	@:optional public var pyrite:h2d.Tile = null;
	@:optional public var quartz_certus:h2d.Tile = null;
	@:optional public var quartz_certus_charged:h2d.Tile = null;
	@:optional public var racheline:h2d.Tile = null;
	@:optional public var redstone:h2d.Tile = null;
	@:optional public var ruby:h2d.Tile = null;
	@:optional public var sapphire:h2d.Tile = null;
	@:optional public var sheldonite:h2d.Tile = null;
	@:optional public var sheldonite_stone:h2d.Tile = null;
	@:optional public var sodalite:h2d.Tile = null;
	@:optional public var sodalite_stone:h2d.Tile = null;
	@:optional public var sphalerite:h2d.Tile = null;
	@:optional public var tungsten:h2d.Tile = null;
	@:optional public var tungsten_stone:h2d.Tile = null;
}
