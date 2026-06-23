import h2d.Scene;
import h2d.SpriteBatch.BatchElement;
import h2d.Tile;


class Block_Spawner{
    var block_tiles: Blocks;
    var active_blocks: Array<BatchElement>;

    public function new(){
        active_blocks = new Array<BatchElement>();
        loadOreImages();
    }

    function update(scene:Scene){
        
    }

    function loadOreImages(){
        block_tiles.apatite = hxd.Res.ores.apatite.toTile();
        block_tiles.aquamarine = hxd.Res.aquamarine.toTile();
        block_tiles.bauxite = hxd.Res.bauxite.toTile();
        block_tiles.boron = hxd.Res.boron.toTile();
        block_tiles.cinnabar = hxd.Res.cinnabar.toTile();
        block_tiles.coal = hxd.Res.coal.toTile();
        block_tiles.copper = hxd.Res.copper.toTile();
        block_tiles.diamond = hxd.Res.diamond.toTile();
        block_tiles.emerald = hxd.Res.emerald.toTile();
        block_tiles.friscion = hxd.Res.friscion.toTile();
        block_tiles.galena = hxd.Res.galena.toTile();
        block_tiles.garfax = hxd.Res.garfax.toTile();
        block_tiles.gold = hxd.Res.gold.toTile();
        block_tiles.iridium = hxd.Res.iridium.toTile();
        block_tiles.iron = hxd.Res.iron.toTile();
        block_tiles.kelline = hxd.Res.kelline.toTile();
        block_tiles.lapis = hxd.Res.lapis.toTile();
        block_tiles.lead = hxd.Res.lead.toTile();
        block_tiles.lithium = hxd.Res.lithium.toTile();
        block_tiles.magnesium = hxd.Res.magnesium.toTile();
        block_tiles.mithril = hxd.Res.mithril.toTile();
        block_tiles.morganine = hxd.Res.morganine.toTile();
        block_tiles.nickel = hxd.Res.nickel.toTile();
        block_tiles.platinum = hxd.Res.platinum.toTile();
        block_tiles.silver = hxd.Res.silver.toTile();
        block_tiles.thorium = hxd.Res.thorium.toTile();
        block_tiles.tin = hxd.Res.tin.toTile();
        block_tiles.peridot = hxd.Res.peridot.toTile();
        block_tiles.peridot_stone = hxd.Res.peridot_stone.toTile();
        block_tiles.pyrite = hxd.Res.pyrite.toTile();
        block_tiles.quartz_certus = hxd.Res.quartz_certus.toTile();
        block_tiles.quartz_certus_charged = hxd.Res.quartz_certus_charged.toTile();
        block_tiles.racheline = hxd.Res.racheline.toTile();
        block_tiles.redstone = hxd.Res.redstone.toTile();
        block_tiles.ruby = hxd.Res.ruby.toTile();
        block_tiles.sapphire = hxd.Res.sapphire.toTile();
        block_tiles.sheldonite = hxd.Res.sheldonite.toTile();
        block_tiles.sheldonite_stone = hxd.Res.sheldonite_stone.toTile();
        block_tiles.sodalite = hxd.Res.sodalite.toTile();
        block_tiles.sodalite_stone = hxd.Res.sodalite_stone.toTile();
        block_tiles.sphalerite = hxd.Res.sphalerite.toTile();
        block_tiles.tungsten = hxd.Res.tungsten.toTile();
        block_tiles.tungsten_stone = hxd.Res.tungsten_stone.toTile();
    }
}

@:structInit
class Blocks {
    public var apatite : Tile;
    public var aquamarine : Tile;
    public var bauxite : Tile;
    public var boron : Tile;
    public var cinnabar : Tile;
    public var coal : Tile;
    public var copper : Tile;
    public var diamond : Tile;
    public var emerald : Tile;
    public var friscion : Tile;
    public var galena : Tile;
    public var garfax : Tile;
    public var gold : Tile;
    public var iridium : Tile;
    public var iron : Tile;
    public var kelline : Tile;
    public var lapis : Tile;
    public var lead : Tile;
    public var lithium : Tile;
    public var magnesium : Tile;
    public var mithril : Tile;
    public var morganine : Tile;
    public var nickel : Tile;
    public var platinum : Tile;
    public var silver : Tile;
    public var thorium : Tile;
    public var tin : Tile;
    public var peridot : Tile;
    public var peridot_stone : Tile;
    public var pyrite : Tile;
    public var quartz_certus : Tile;
    public var quartz_certus_charged : Tile;
    public var racheline : Tile;
    public var redstone : Tile;
    public var ruby : Tile;
    public var sapphire : Tile;
    public var sheldonite : Tile;
    public var sheldonite_stone : Tile;
    public var sodalite : Tile;
    public var sodalite_stone : Tile;
    public var sphalerite : Tile;
    public var tungsten : Tile;
    public var tungsten_stone : Tile;
}