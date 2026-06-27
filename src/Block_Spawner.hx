import format.gif.Data.Block;
import h3d.mat.Texture;
import haxe.io.BytesInput;
import format.png.Reader;
import format.png.Tools;
import sys.FileSystem;
import sys.io.File;
import hxd.Pixels;
import hxd.PixelFormat;
import hxd.res.Image;
import h2d.Bitmap;
import hxd.Rand;
import h2d.Scene;
import h2d.Tile;
import Gui;


class Block_Spawner{
    var block_tiles: Blocks;
    var active_blocks: Array<Array<Bitmap>>;

    var diggable_width:UInt;
    var start_height = 6;

    var rand:Rand;

    public function new(scene:Scene, block_width:UInt, block_scale:UInt, diggable_width:UInt){
        active_blocks = new Array<Array<Bitmap>>();
        rand = new Rand(Std.int(2181));
        loadOreImages();

        this.diggable_width = diggable_width;
        createBlocks(scene, block_width, block_scale);
        }
        
    function createBlocks(scene:Scene, block_width:UInt, block_scale:UInt){
        var size = block_width * block_scale;
        var scene_middle = scene.width / 2;   
        var adjusted_start_x = scene_middle - (diggable_width * size);
        var adjusted_start_y = start_height * size;

        for(x in 0...diggable_width*2){
            active_blocks.push(new Array<Bitmap>());

            for (y in 0...diggable_width*2){
                if (active_blocks[x] == null)
                    active_blocks[x] = new Array<Bitmap>();
                
                var random_block_index = rand.random(Reflect.fields(block_tiles).length);
                var block_tile = block_tiles.getByIndex(random_block_index);
                
                var block = new Bitmap(block_tile);
                if(block.scale != null || block.x != 0)
                    block.setScale(block_scale);
                else {
                    block.width = size;
                    block.height = size;
                }

                block.setPosition(adjusted_start_x + x * size, adjusted_start_y + y * size);
                scene.addChild(block);
                active_blocks[x][y] = block;

                var bounds = block.getBounds();
                var interaction = new h2d.Interactive(bounds.x * block_scale,  bounds.y * block_scale, block);
                interaction.backgroundColor = 5;
                interaction.onOver = function(event){
                    if(Gui.debugObject){
                        Gui_Debug.hoveredPosition = block.getAbsPos();
                        Gui_Debug.hoveredBlock = block;
                        Gui_Debug.hoveredTile = block_tiles.getNameByIndex(random_block_index);
                    }
                }
                trace(bounds);
            }
        }
    }

    function loadOreImages() {
        block_tiles = new Blocks();

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

    function update(scene:Scene){

    }
}

@:structInit
class Blocks {
    public function new(){

    }

    @:arrayAccess
    public inline function getByIndex(index: Int) : Tile {
        return switch(index){
            case 0: this.apatite;
            case 1: this.aquamarine;
            case 2: this.bauxite;
            case 3: this.boron;
            case 4: this.cinnabar;
            case 5: this.coal;
            case 6: this.copper;
            case 7: this.diamond;
            case 8: this.emerald;
            case 9: this.friscion;
            case 10: this.galena;
            case 11: this.garfax;
            case 12: this.gold;
            case 13: this.iridium;
            case 14: this.iron;
            case 15: this.kelline;
            case 16: this.lapis;
            case 17: this.lead;
            case 18: this.lithium;
            case 19: this.magnesium;
            case 20: this.mithril;
            case 21: this.morganine;
            case 22: this.nickel;
            case 23: this.platinum;
            case 24: this.silver;
            case 25: this.thorium;
            case 26: this.tin;
            case 27: this.peridot;
            case 28: this.peridot_stone;
            case 29: this.pyrite;
            case 30: this.quartz_certus;
            case 31: this.quartz_certus_charged;
            case 32: this.racheline;
            case 33: this.redstone;
            case 34: this.ruby;
            case 35: this.sapphire;
            case 36: this.sheldonite;
            case 37: this.sheldonite_stone;
            case 38: this.sodalite;
            case 39: this.sodalite_stone;
            case 40: this.sphalerite;
            case 41: this.tungsten;
            case 42: this.tungsten_stone;
            default: throw "index out of bounds";
        }
    }
    @:arrayAccess
    public inline function setByIndex(index: Int, tile:Tile) {
        switch(index){
            case 0: this.apatite = tile;
            case 1: this.aquamarine = tile;
            case 2: this.bauxite = tile;
            case 3: this.boron = tile;
            case 4: this.cinnabar = tile;
            case 5: this.coal = tile;
            case 6: this.copper = tile;
            case 7: this.diamond = tile;
            case 8: this.emerald = tile;
            case 9: this.friscion = tile;
            case 10: this.galena = tile;
            case 11: this.garfax = tile;
            case 12: this.gold = tile;
            case 13: this.iridium = tile;
            case 14: this.iron = tile;
            case 15: this.kelline = tile;
            case 16: this.lapis = tile;
            case 17: this.lead = tile;
            case 18: this.lithium = tile;
            case 19: this.magnesium = tile;
            case 20: this.mithril = tile;
            case 21: this.morganine = tile;
            case 22: this.nickel = tile;
            case 23: this.platinum = tile;
            case 24: this.silver = tile;
            case 25: this.thorium = tile;
            case 26: this.tin = tile;
            case 27: this.peridot = tile;
            case 28: this.peridot_stone = tile;
            case 29: this.pyrite = tile;
            case 30: this.quartz_certus = tile;
            case 31: this.quartz_certus_charged = tile;
            case 32: this.racheline = tile;
            case 33: this.redstone = tile;
            case 34: this.ruby = tile;
            case 35: this.sapphire = tile;
            case 36: this.sheldonite = tile;
            case 37: this.sheldonite_stone = tile;
            case 38: this.sodalite = tile;
            case 39: this.sodalite_stone = tile;
            case 40: this.sphalerite = tile;
            case 41: this.tungsten = tile;
            case 42: this.tungsten_stone = tile;
            default: throw "index out of bounds";
        }
    }
    @:arrayAccess
    public inline function getNameByIndex(index: Int) : String {
        return switch(index){
            case 0: "apatite";
            case 1: "aquamarine";
            case 2: "bauxite";
            case 3: "boron";
            case 4: "cinnabar";
            case 5: "coal";
            case 6: "copper";
            case 7: "diamond";
            case 8: "emerald";
            case 9: "friscion";
            case 10: "galena";
            case 11: "garfax";
            case 12: "gold";
            case 13: "iridium";
            case 14: "iron";
            case 15: "kelline";
            case 16: "lapis";
            case 17: "lead";
            case 18: "lithium";
            case 19: "magnesium";
            case 20: "mithril";
            case 21: "morganine";
            case 22: "nickel";
            case 23: "platinum";
            case 24: "silver";
            case 25: "thorium";
            case 26: "tin";
            case 27: "peridot";
            case 28: "peridot_stone";
            case 29: "pyrite";
            case 30: "quartz_certus";
            case 31: "quartz_certus_charged";
            case 32: "racheline";
            case 33: "redstone";
            case 34: "ruby";
            case 35: "sapphire";
            case 36: "sheldonite";
            case 37: "sheldonite_stone";
            case 38: "sodalite";
            case 39: "sodalite_stone";
            case 40: "sphalerite";
            case 41: "tungsten";
            case 42: "tungsten_stone";
            default: throw "index out of bounds";
        }
    }

    @:optional public var apatite : h2d.Tile = null;
    @:optional public var aquamarine : h2d.Tile = null;
    @:optional public var bauxite : h2d.Tile = null;
    @:optional public var boron : h2d.Tile = null;
    @:optional public var cinnabar : h2d.Tile = null;
    @:optional public var coal : h2d.Tile = null;
    @:optional public var copper : h2d.Tile = null;
    @:optional public var diamond : h2d.Tile = null;
    @:optional public var emerald : h2d.Tile = null;
    @:optional public var friscion : h2d.Tile = null;
    @:optional public var galena : h2d.Tile = null;
    @:optional public var garfax : h2d.Tile = null;
    @:optional public var gold : h2d.Tile = null;
    @:optional public var iridium : h2d.Tile = null;
    @:optional public var iron : h2d.Tile = null;
    @:optional public var kelline : h2d.Tile = null;
    @:optional public var lapis : h2d.Tile = null;
    @:optional public var lead : h2d.Tile = null;
    @:optional public var lithium : h2d.Tile = null;
    @:optional public var magnesium : h2d.Tile = null;
    @:optional public var mithril : h2d.Tile = null;
    @:optional public var morganine : h2d.Tile = null;
    @:optional public var nickel : h2d.Tile = null;
    @:optional public var platinum : h2d.Tile = null;
    @:optional public var silver : h2d.Tile = null;
    @:optional public var thorium : h2d.Tile = null;
    @:optional public var tin : h2d.Tile = null;
    @:optional public var peridot : h2d.Tile = null;
    @:optional public var peridot_stone : h2d.Tile = null;
    @:optional public var pyrite : h2d.Tile = null;
    @:optional public var quartz_certus : h2d.Tile = null;
    @:optional public var quartz_certus_charged : h2d.Tile = null;
    @:optional public var racheline : h2d.Tile = null;
    @:optional public var redstone : h2d.Tile = null;
    @:optional public var ruby : h2d.Tile = null;
    @:optional public var sapphire : h2d.Tile = null;
    @:optional public var sheldonite : h2d.Tile = null;
    @:optional public var sheldonite_stone : h2d.Tile = null;
    @:optional public var sodalite : h2d.Tile = null;
    @:optional public var sodalite_stone : h2d.Tile = null;
    @:optional public var sphalerite : h2d.Tile = null;
    @:optional public var tungsten : h2d.Tile = null;
    @:optional public var tungsten_stone : h2d.Tile = null;
}