
import hxd.Window;
import h2d.Scene;
import imgui.ImGui;
import imgui.ImGuiDrawable;
import h2d.col.Matrix;

class Gui {
	var drawable:ImGuiDrawable;

	public static var debugObject = true;
	public static var showMousePosition = true;
	public static var showBlockOverlay = true;

	public function new(scene:Scene) {
		this.drawable = new ImGuiDrawable(scene);
		Gui_Contraptions.init();

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
			Gui_Contraptions.renderContraptionGUIs(scene);
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


	public static function renderDebugger() {
		if (ImGui.beginTabItem("Block Inspector")) {
			guiMousePosition();
			guiBlockData();
			ImGui.checkbox("Show Block Overlay", Gui.showBlockOverlay);

			// ImGui.textColored(ExtDynamic<ImVec4>(1,0,0,1), "Status: No Hovered Block");
			ImGui.endTabItem();
		}
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
}


function alignRight(elementWidth:UInt, padding:UInt) {
	return ImGui.sameLine(ImGui.getWindowWidth() - elementWidth - padding);
}