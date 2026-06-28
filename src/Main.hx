import hxd.Window;
import h2d.Scene;

class Main extends hxd.App {
	var isInitReady = false;

	var gui:Gui;

	override function init() {
		var window = Window.getInstance();
		window.title = "idler";
		window.resize(1920, 1080);
		window.displayMode = Fullscreen;

		hxd.Res.initLocal();

		World_Controller.init(s2d); // if this is after gui initiliation, the gui doesnt load?

		gui = new Gui(s2d);

		isInitReady = true;
	}

	override function update(dt:Float) {
		gui.update(s2d.getScene(), dt);
	}

	override function onResize() {
		if (!isInitReady)
			return;
		World_Controller.onResize();
		gui.onResize(s2d);
	}

	static function main() {
		new Main();
	}
}

final class World_Controller {
	static var background:Background;
	static var block_spawner:Block_Spawner;

	static var diggable_width:UInt = 5;
	static var dirt_width:UInt = 16;
	static var dirt_scale:UInt = 6;
	
	static var block_width:UInt = 32;
	static var block_scale:UInt = 3;

	static public function init(scene:Scene, size:UInt = 32) {
		background = new Background(scene, dirt_width, dirt_scale, diggable_width);
		block_spawner = new Block_Spawner(scene, block_width, block_scale, diggable_width);
	}

	static public function onResize() {}
}
