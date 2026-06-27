import hxd.res.Image;
import hxd.Window;
import h2d.Graphics;
import h2d.Scene;
import imgui.ImGui;
import imgui.ImGuiDrawable;
import h2d.col.Matrix;


class Gui{
    var drawable:ImGuiDrawable;
    public static var debugObject = true;
    public static var showMousePosition = true;


    public function new(scene:Scene){
        this.drawable = new ImGuiDrawable(scene);

        ImGui.setDisplaySize(scene.width, scene.height);
    }

    public function update(scene:Scene, dt:Float){
        drawable.update(dt);

        ImGui.newFrame();

        // ImGui.showDemoWindow();
        renderUI();

        ImGui.render();
    }

    function renderUI(){
        ImGui.begin("GUI");

        Gui_Debug.renderDebugger();

        ImGui.end();
    }

    public function onResize(scene:Scene){
        ImGui.setDisplaySize(scene.width, scene.height);
    }
}

class Gui_Debug{
    public static var hoveredPosition:Matrix;
    public static var hoveredBlock:h2d.Bitmap = null;
    public static var hoveredTile:String = null;

    public static var overlayGraphics:Graphics;
    
    public static function init(parent: h2d.Object){
        overlayGraphics = new h2d.Graphics(parent);
    }

    public static function renderDebugger(){
        if(ImGui.beginTabBar("Debugger")){
            if(ImGui.beginTabItem("Block Inspector")){
                guiMousePosition();
                guiBlockData();
                // else
                    // ImGui.textColored(ExtDynamic<ImVec4>(1,0,0,1), "Status: No Hovered Block");
                ImGui.endTabItem();
            }
            ImGui.endTabBar();
        }
    }

    public static function clear(){
        overlayGraphics.clear();
    }

    public static function createDebugUI(scene: Scene){
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

    static function guiMousePosition(){
        if(ImGui.checkbox("Show Mouse Pos", Gui.showMousePosition))
                Gui.showMousePosition = !Gui.showMousePosition;
            if(Gui.showMousePosition){
                ImGui.text("Mouse Position: " + Window.getInstance().mouseX + ", " + Window.getInstance().mouseY);
            }
            ImGui.separator();
    }

    static function guiBlockData(){
        ImGui.text("Hover blocks to see game data: " + Gui.debugObject);
            
            if(ImGui.checkbox("Blocks", Gui.debugObject))
                Gui.debugObject = !Gui.debugObject;
            if(Gui.debugObject){
                ImGui.text("Absolute Pos: " + hoveredPosition);
                ImGui.text("Block Tile: " + hoveredTile);
                // ImGui.textColored(ExtDynamic<ImVec4>(0,1,0,1), "Status: Inspecting Target");
            }
            ImGui.separator();
    }
    

    public function showPosition() {
        clear();

        overlayGraphics.lineStyle(1, 0xFF0000, 1.0);

    }
}