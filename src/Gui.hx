import hxsl.Types.Texture;
import h2d.Graphics;
import Contraptions.ContraptionType;
import h2d.Tile;
import h2d.Bitmap;
import hxd.Window;
import h2d.Scene;
import imgui.ImGui;
import imgui.ImGui.ImVec2;
import imgui.ImGuiDrawable;
import h2d.col.Matrix;

class Gui {
	var drawable:ImGuiDrawable;

	public static var debugObject = true;
	public static var showMousePosition = true;
	public static var showBlockOverlay = true;

	public function new(scene:Scene) {
		this.drawable = new ImGuiDrawable(scene);
		Gui_Debug.init();

		// ImGui.setDisplaySize(scene.width, scene.height);
	}

	public function update(scene:Scene, dt:Float) {
		drawable.update(dt);

		ImGui.newFrame();

		// ImGui.showDemoWindow();
		renderUI(scene);

		ImGui.render();
	}

	function renderUI(scene:Scene) {
		ImGui.begin("GUI", ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoResize);
		if (ImGui.beginTabBar("")) {
			Gui_Debug.renderContraptionGUIs(scene);
			Gui_Debug.renderDebugger();
			ImGui.endTabBar();
		}
		ImGui.end();
	}

	public function onResize(scene:Scene) {}
}

class Gui_Debug {
	public static var hoveredPosition:Matrix;
	public static var hoveredTile:String = null;
	static var buy_button_graphic:ImVec2 = {x: 100.0, y: 20.0};
	static var button_padding = 10;

	static var isContraptionHeld:Bool = false;
	static var heldContraption:Bitmap = null;
	static var contraptionBounds:Map<String, ImVec2>;

	static var maxUsedContraptions: UInt = 6;
	static var contraptionValidBoxTile:Tile = null;
	static var contraptionValidBoxes: Array<Bitmap> = null;
	static var contraptionValidBoxPositions: Array<ImVec2> = null;

	public static function init() {
		contraptionBounds = new Map<String, ImVec2>();
		contraptionValidBoxTile = drawContraptionBox();
		contraptionValidBoxes = new Array<Bitmap>();
	}

	public static function renderContraptionGUIs(scene:Scene) {
		if (ImGui.beginTabItem("Storage")) {
			ImGui.text("Drag contraptions to use in world");
			renderContraptionStorage(scene, Contraptions.zapper);

			ImGui.endTabItem();
		}
		if (ImGui.beginTabItem("Buy Contraption")) {
			renderContraptionShop(Contraptions.zapper);
			renderContraptionShop(Contraptions.burner);
			ImGui.endTabItem();
		}
	}

	public static function renderContraptionStorage(scene:Scene, contraption:ContraptionType) {
		var tile = contraption.tile;

		ImGui.imageTile(contraption.tile, new ImVec2(tile.width * 2, tile.height * 2));

		contraptionBounds.set("zapperMinBound", ImGui.getItemRectMin());
		contraptionBounds.set("zapperMaxBound", ImGui.getItemRectMax());

		if (ImGui.getIO().MouseDown_Left
			&& (isContraptionHeld || isMouseInTile(contraptionBounds.get("zapperMinBound"), contraptionBounds.get("zapperMaxBound")))) {
			if (heldContraption == null) {
				heldContraption = new Bitmap(tile, scene);
				isContraptionHeld = true;

				showValidContraptionPositions(scene);
			}
			setHeldContraptionPos(heldContraption);
		} else
			isContraptionHeld = false;

		if (!isContraptionHeld) {
			heldContraption.remove();
			heldContraption = null;
		}
	}

	public static function showValidContraptionPositions(scene:Scene) {
		createValidContraptionPosBox(scene, new ImVec2(0,0));
	}

	public static function createValidContraptionPosBox(scene:Scene, pos:ImVec2) {
		for (i in 0...maxUsedContraptions){
			var box:Bitmap = new Bitmap(contraptionValidBoxTile);
			


			scene.addChild(box);
			contraptionValidBoxes.push(box);
		}


	}

	public static function setHeldContraptionPos(contraption:Bitmap) {
		contraption.x = Window.getInstance().mouseX - (heldContraption.tile.width / 2);
		contraption.y = Window.getInstance().mouseY - (heldContraption.tile.height / 2);
	}

	public static function isMouseInTile(min:ImVec2, max:ImVec2):Bool {
		var mousePos:ImVec2 = ImGui.getMousePos();
		if (min.x < mousePos.x && mousePos.x < max.x && min.y < mousePos.y && mousePos.y < max.y)
			return true;
		return false;
	}

	public static function renderContraptionShop(contraption:ContraptionType) {
		ImGui.text("Buy " + contraption.name + " --- ");
		alignRight(Std.int(buy_button_graphic.x));
		ImGui.button(contraption.cost + "$", buy_button_graphic);
	}

	public static function alignRight(elementWidth:UInt) {
		return ImGui.sameLine(ImGui.getWindowWidth() - elementWidth - button_padding);
	}

	public static function renderDebugger() {
		if (ImGui.beginTabItem("Block Inspector")) {
			guiMousePosition();
			guiBlockData();
			ImGui.checkbox("Show Block Overlay", Gui.showBlockOverlay);

			// ImGui.textColored(ExtDynamic<ImVec4>(1,0,0,1), "Status: No Hovered Block");
			ImGui.endTabItem();
		}
	}

	// not functional, dunno why
	public static function renderDebugOverlay(scene:Scene, hoveredBlock:h2d.Bitmap = null) {
		if (hoveredBlock != null && Gui.showBlockOverlay) {
			var overlay:Bitmap = new Bitmap(Tile.fromColor(0x69FF6262, Std.int(hoveredBlock.width), Std.int(hoveredBlock.height), 1));
			overlay.x = hoveredBlock.x;
			overlay.y = hoveredBlock.y;
			scene.addChild(overlay);
		}
	}

	public static function createDebugUI(scene:Scene) {
		// var panel = new h2d.Flow(scene);
		// panel.layout = Vertical;
		// panel.backgroundTile = h2d.Tile.fromColor(0x000000, 160, 200, 0.7);
		// panel.padding = 10;
		// panel.addSpacing(8);
		// panel.x = scene.width - 170;
		// panel.y = 10;

		// var posBtn  = new h2d.Interactive(140, 30, panel);
		// posBtn.backgroundColor = 0x444444;

		// var posText = new h2d.Text(DefaultFont.get(), posBtn);
		// posText.text = "Toggle Positions";
		// posText.textAlign = Center;
	}

	static function guiMousePosition() {
		if (ImGui.checkbox("Show Mouse Pos", Gui.showMousePosition))
			Gui.showMousePosition = !Gui.showMousePosition;
		if (Gui.showMousePosition) {
			ImGui.text("Mouse Position: " + Window.getInstance().mouseX + ", " + Window.getInstance().mouseY);
		}
		ImGui.separator();
	}

	static function guiBlockData() {
		ImGui.text("Hover blocks to see game data: " + Gui.debugObject);

		if (ImGui.checkbox("Blocks", Gui.debugObject))
			Gui.debugObject = !Gui.debugObject;
		if (Gui.debugObject) {
			ImGui.text("Absolute Pos: " + hoveredPosition);

			ImGui.text("Block Tile: " + hoveredTile);
			// ImGui.textColored(ExtDynamic<ImVec4>(0,1,0,1), "Status: Inspecting Target");
		}
		ImGui.separator();
	}

	static function drawContraptionBox(): Tile{
		var g = new h2d.Graphics();
		var size = 28;
		var thickness = 2;

		g.beginFill(0xFFFFFF, 1);
		g.drawRect(0,0, size, size);
		g.endFill();

		g.beginFill(0x000000, 0.7);
		g.drawRect(thickness, thickness, size - thickness*2, size - thickness*2);
		g.endFill();

		var texture = new Texture(size, size, [Target]);
		g.drawTo(texture);
		g.remove();

		return Tile.fromTexture(texture);
	}

	static function calculateContraptionBoxPositions() Array<ImVec2> {
		var positions = new Array<ImVec2>();

		return positions;
	}
}
