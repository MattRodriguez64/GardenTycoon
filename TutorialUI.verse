
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


TutorialUI := class:
    var MainCanvas : canvas = canvas{};
    var TutoDataHud : texture_block = texture_block{DefaultImage := UI.MessageBox, DefaultDesiredSize := vector2{X := 900.0, Y := 350.0}};
    var BaseManagerDev : BaseManager = BaseManager{};

    # TUTO BUTTON
    var TutoButton : button_loud = button_loud{};
    # NO BUTTON
    var NoButton : button_loud = button_loud{};

    var Text : text_block = text_block{};

    ToMessage<localizes>(String : string) : message = "{String}";

    AddUI(Agent : agent) : void =
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            set MainCanvas = CreateUI();
            PlayerUI.AddWidget(MainCanvas, player_ui_slot{InputMode := ui_input_mode.All});
        }

    HandleExit(Player : player) : void =
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(MainCanvas);
        }

    OnSelectNo(Message : widget_message) : void =
        Print(">OnSelectNo");
        HandleExit(Message.Player);

    OnSelectTuto(Message : widget_message) : void =
        Print(">OnSelectTuto");
        BaseManagerDev.OnStartTutorial();
        HandleExit(Message.Player);

    CreateUI() : canvas =
        Print(">CreateUI");
        Text.SetText(ToMessage("WELCOME TO GROW GARDEN\n TYCOON ! LET'S DO A QUICK\n TUTORIAL ON THE MAP."));
        TutoButton.SetText(ToMessage("YES"));
        TutoButton.OnClick().Subscribe(OnSelectTuto);
        NoButton.SetText(ToMessage("NO"));
        NoButton.OnClick().Subscribe(OnSelectNo);

        NewUI : canvas = canvas{
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 250.0, Right := 900.0, Bottom := 350.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 0
                    SizeToContent := false
                    Widget := TutoDataHud
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -290.0, Top := 360.0, Right := 200.0, Bottom := 80.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := TutoButton
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -10.0, Top := 360.0, Right := 200.0, Bottom := 80.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := NoButton
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -138.0, Top := 264.0, Right := 542.0, Bottom := 145.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Text
        }
