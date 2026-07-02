import hxd.Window;


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
		Contraption_Controller.init();

		gui = new Gui(s2d);

		isInitReady = true;
	}

	override function update(dt:Float) {
		World_Controller.update(s2d);
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
