import Contraption_Controller.BurnerType;
import Contraption_Controller.ZapperType;
import Gui.alignRight;
import h2d.Interactive;
import Definitions.Vec2;
import hxsl.Types.Texture;
import h2d.Graphics;
import Contraption_Controller.ContraptionBaseType;
import h2d.Tile;
import h2d.Bitmap;
import h2d.Scene;
import imgui.ImGui;
import hxd.Window;

class Gui_Contraptions{
	static var buy_button_graphic:ImVec2 = {x: 100.0, y: 20.0};
	static var button_padding = 10;

	static var isContraptionHeld:Bool = false;
	static var heldContraption:Bitmap = null;
	static var contraptionBounds:Map<String, ImVec2>;

	static var maxValidContraptions:UInt = 6;
	static var contraptionValidBoxTile:Tile = null;
	static var contraptionValidBoxes:Array<Bitmap> = null;
	static var contraptionValidBoxPositions:Array<Vec2> = null;

	public static function init() {
		contraptionBounds = new Map<String, ImVec2>();
		contraptionValidBoxTile = drawContraptionBox();
		contraptionValidBoxes = new Array<Bitmap>();
	}

	public static function renderContraptionGUIs(scene:Scene) {
		if (ImGui.beginTabItem("Storage")) {
			ImGui.text("Drag contraptions to use in world");
			renderContraptionStorage(scene, Contraption_Controller.zapper);

			ImGui.endTabItem();
		}
		if (ImGui.beginTabItem("Buy Contraption")) {
			renderContraptionShop(ZapperType.getName(), ZapperType.getCost());
			renderContraptionShop(BurnerType.getName(), BurnerType.getCost());
			ImGui.endTabItem();
		}
	}

	static function renderContraptionStorage(scene:Scene, contraption:ContraptionBaseType) {
		var tile = contraption.tile;

		ImGui.imageTile(contraption.tile, new ImVec2(tile.width * 2, tile.height * 2));

		contraptionBounds.set("zapperMinBound", ImGui.getItemRectMin());
		contraptionBounds.set("zapperMaxBound", ImGui.getItemRectMax());

		if (ImGui.getIO().MouseDown_Left
			&& (isContraptionHeld || isMouseInTile(contraptionBounds.get("zapperMinBound"), contraptionBounds.get("zapperMaxBound")))) {
			if (heldContraption == null) {
				showValidContraptionPositions(scene);

				heldContraption = new Bitmap(tile, scene);
				isContraptionHeld = true;
			}
			setHeldContraptionPos(heldContraption);
		} else
			isContraptionHeld = false;

		if (!isContraptionHeld) {
			heldContraption.remove();
			deleteValidContraptionBoxes();
			heldContraption = null;
		}
	}


	static function renderContraptionShop(name:String, cost:UInt) {
		ImGui.text("Buy " + name + " --- ");
		alignRight(Std.int(buy_button_graphic.x), button_padding);
		ImGui.button(cost + "$", buy_button_graphic);
	}

	static function setHeldContraptionPos(contraption:Bitmap) {
		contraption.x = Window.getInstance().mouseX - (heldContraption.tile.width / 2);
		contraption.y = Window.getInstance().mouseY - (heldContraption.tile.height / 2);
	}

	static function isMouseInTile(min:ImVec2, max:ImVec2):Bool {
		var mousePos:ImVec2 = ImGui.getMousePos();
		if (min.x < mousePos.x && mousePos.x < max.x && min.y < mousePos.y && mousePos.y < max.y)
			return true;
		return false;
	}

	
	static function showValidContraptionPositions(scene:Scene) {
		createValidContraptionPosBox(scene, new ImVec2(0, 0));
	}

	static function createValidContraptionPosBox(scene:Scene, pos:ImVec2) {
		for (i in 0...maxValidContraptions) {
			var box:Bitmap = new Bitmap(contraptionValidBoxTile, scene);
			var interaction:Interactive = new Interactive(contraptionValidBoxTile.width, contraptionValidBoxTile.height, box);
			box.addChild(interaction);

			var pos:Vec2 = contraptionValidBoxPositions[i];

			box.x = pos.x + (contraptionValidBoxTile.width / 2);
			box.y = pos.y + (contraptionValidBoxTile.height / 2);
			interaction.x -= contraptionValidBoxTile.width / 2;
			interaction.y -= contraptionValidBoxTile.height / 2;

			interaction.onOver = function(_){
				box.setScale(1.1);
			}
			interaction.onOut = function(_){
				box.setScale(1);
			}

			contraptionValidBoxes.push(box);
		}
	}

	static function deleteValidContraptionBoxes(){
		for(box in contraptionValidBoxes){
			box.remove();
		}
	}

	static function drawContraptionBox():Tile {
		var g = new h2d.Graphics();
		var size = 30;
		var thickness = 2;

		g.beginFill(0xFFFFFF, 1);
		g.drawRect(0, 0, thickness, size);
		g.drawRect(0, 0, size, thickness);
		g.drawRect(size - thickness, 0, thickness, size);
		g.drawRect(0, size - thickness, size, thickness);

		g.beginFill(0x000000, 0.3);
		g.drawRect(thickness, thickness, size - thickness * 2, size - thickness * 2);
		g.endFill();

		var texture = new Texture(size, size, [Target]);
		g.drawTo(texture);
		g.remove();

		var tile = Tile.fromTexture(texture);

		tile.setCenterRatio(0.5, 0.5);

		return tile;
	}

	public static function calculateContraptionBoxPositions(sceneWidth:UInt, size:UInt, diggableWidth:UInt, startHeight:UInt) {
		contraptionValidBoxPositions = new Array<Vec2>();
		var sceneMiddle = sceneWidth / 2 / size;
		var currentY = 0;

		for (_ in 0...Std.int(maxValidContraptions/2)) {
			var pos:Vec2 = {x: (sceneMiddle - diggableWidth - 1) * size, y: (startHeight + currentY) * size};
			contraptionValidBoxPositions.push(pos);

			pos = {x: (sceneMiddle + diggableWidth) * size, y: (startHeight + currentY) * size};
			contraptionValidBoxPositions.push(pos);
		
			currentY += 1;
		}
	}
}