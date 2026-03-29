
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors/NamedColors }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Colors }
using { /Verse.org/Assets }
using { /Fortnite.com/Characters }


AutoFarmUI := class:
    var MainCanvas : canvas = canvas{};
    var ImageBackground : texture_block = texture_block{DefaultImage := UI.AutoFarmHudV2, DefaultDesiredSize := vector2{X := 700.0, Y := 1000.0}};
    var BaseManagerDev : BaseManager = BaseManager{};

    var ExitButton : button_quiet = button_quiet{};
    var Button1 : button_quiet = button_quiet{};
    var Button2 : button_quiet = button_quiet{};

    AddUI(Agent : agent) : void =
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            set MainCanvas = CreateUI();
            PlayerUI.AddWidget(MainCanvas, player_ui_slot{InputMode := ui_input_mode.All});
        }
    
    Exit(Player : player) : void =
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(ExitButton);
            PlayerUI.RemoveWidget(Button1);
            PlayerUI.RemoveWidget(Button2);
            PlayerUI.RemoveWidget(MainCanvas);
            PlayerUI.RemoveWidget(ImageBackground);
        }

    HandleExit(Message : widget_message) : void =
        Print(">HandleExit");
        Player := Message.Player;
        Exit(Player);

    OnCollectEverything(Message : widget_message) : void =
        Print(">OnCollectEverything");
        if(CurrentAgent := agent[Message.Player]) {
            BaseManagerDev.OnAutoFarm(CurrentAgent);
        }

        Exit(Message.Player);

    OnCollectEverythingExceptRares(Message : widget_message) : void =
        Print(">OnCollectEverythingExceptRares");
        if(CurrentAgent := agent[Message.Player]) {
            BaseManagerDev.OnAutoFarmExceptRares(CurrentAgent);
        }

        Exit(Message.Player);

    CreateUI() : canvas =
        Print(">CreateUI");

        ExitButton.OnClick().Subscribe(HandleExit);
        Button1.OnClick().Subscribe(OnCollectEverything);
        Button2.OnClick().Subscribe(OnCollectEverythingExceptRares);

        NewUI : canvas = canvas{
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 0.0, Right := 700.0, Bottom := 1000.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 0
                    SizeToContent := false
                    Widget := ImageBackground
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 448.0, Right := 650.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ExitButton
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 184.0, Top := -215.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Button1
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 184.0, Top := 24.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Button2
        }

        return NewUI;