
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

ColorPickerUI := class:

    #var CurrentCamera : gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{};
    var ColorPickerClass : ColorPicker = ColorPicker{};
    var MainCanvas : canvas = canvas{};
    var ColorPickerHud : texture_block = texture_block{DefaultImage := UI.PickerUIImage, DefaultDesiredSize := vector2{X := 1400.0, Y := 500.0}};
    var CurrentRebirthCount : int = 0;
    var BaseManagerDev : BaseManager = BaseManager{};

    # EXIT BUTTON
    var ExitButton : button_quiet = button_quiet{};
    # BACK BUTTON
    var BackButton : button_quiet = button_quiet{};

    var ColorButton1 : button_quiet = button_quiet{};
    var ColorButton2 : button_quiet = button_quiet{};
    var ColorButton3 : button_quiet = button_quiet{};
    var ColorButton4 : button_quiet = button_quiet{};
    var ColorButton5 : button_quiet = button_quiet{};
    var ColorButton6 : button_quiet = button_quiet{};
    var ColorButton7 : button_quiet = button_quiet{};
    var ColorButton8 : button_quiet = button_quiet{};
    var ColorButton9 : button_quiet = button_quiet{};
    var ColorButton10 : button_quiet = button_quiet{};
    var ColorButton11 : button_quiet = button_quiet{};
    var ColorButton12 : button_quiet = button_quiet{};
    var ColorButton13 : button_quiet = button_quiet{};
    var ColorButton14 : button_quiet = button_quiet{};

    ToMessage<localizes>(String : string) : message = "{String}";

    AddUI(Agent : agent) : void =
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            set MainCanvas = CreateUI();
            PlayerUI.AddWidget(MainCanvas, player_ui_slot{InputMode := ui_input_mode.All});
            # CurrentCamera.Enable();
            # CurrentCamera.AddTo(Agent);
        }

    HandleExit(Message : widget_message) : void =
        Player := Message.Player;
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(MainCanvas);
            # CurrentCamera.RemoveFrom(Player);
            # CurrentCamera.Disable();
        }

    OnSelectColor1(Message : widget_message) : void =
        Print(">OnSelectColor1");
        ColorPickerClass.SetColor(0);

    OnSelectColor2(Message : widget_message) : void =
        Print(">OnSelectColor2");
        ColorPickerClass.SetColor(1);

    OnSelectColor3(Message : widget_message) : void =
        Print(">OnSelectColor3");
        CanBuy := BaseManagerDev.CanBuyItem(5000);
        if(CanBuy?) {
            ColorPickerClass.SetColor(2);
            BaseManagerDev.WithdrawMoney(5000);
        }

    OnSelectColor4(Message : widget_message) : void =
        Print(">OnSelectColor4");
        CanBuy := BaseManagerDev.CanBuyItem(5000);
        if(CanBuy?) {
            ColorPickerClass.SetColor(3);
            BaseManagerDev.WithdrawMoney(5000);
        }

    OnSelectColor5(Message : widget_message) : void =
        Print(">OnSelectColor5");
        CanBuy := BaseManagerDev.CanBuyItem(5000);
        if(CanBuy?) {
            ColorPickerClass.SetColor(4);
            BaseManagerDev.WithdrawMoney(5000);
        }

    OnSelectColor6(Message : widget_message) : void =
        Print(">OnSelectColor6");
        CanBuy := BaseManagerDev.CanBuyItem(5000);
        if(CanBuy?) {
            ColorPickerClass.SetColor(5);
            BaseManagerDev.WithdrawMoney(5000);
        }

    OnSelectColor7(Message : widget_message) : void =
        Print(">OnSelectColor7");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(1);
        if(CanBuy?) {
            ColorPickerClass.SetColor(6);
        }

    OnSelectColor8(Message : widget_message) : void =
        Print(">OnSelectColor8");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(3);
        if(CanBuy?) {
            ColorPickerClass.SetColor(7);
        }

    OnSelectColor9(Message : widget_message) : void =
        Print(">OnSelectColor9");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(5);
        if(CanBuy?) {
            ColorPickerClass.SetColor(8);
        }

    OnSelectColor10(Message : widget_message) : void =
        Print(">OnSelectColor10");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(10);
        if(CanBuy?) {
            ColorPickerClass.SetColor(9);
        }

    OnSelectColor11(Message : widget_message) : void =
        Print(">OnSelectColor11");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(15);
        if(CanBuy?) {
            ColorPickerClass.SetColor(10);
        }

    OnSelectColor12(Message : widget_message) : void =
        Print(">OnSelectColor12");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(20);
        if(CanBuy?) {
            ColorPickerClass.SetColor(11);
        }

    OnSelectColor13(Message : widget_message) : void =
        Print(">OnSelectColor13");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(25);
        if(CanBuy?) {
            ColorPickerClass.SetColor(12);
        }

    OnSelectColor14(Message : widget_message) : void =
        Print(">OnSelectColor14");
        CanBuy := BaseManagerDev.CanBuyItemRebirth(30);
        if(CanBuy?) {
            ColorPickerClass.SetColor(13);
        }

    CreateUI() : canvas =
        Print(">CreateUI");
        ExitButton.OnClick().Subscribe(HandleExit);

        ColorButton1.OnClick().Subscribe(OnSelectColor1);
        ColorButton2.OnClick().Subscribe(OnSelectColor2);
        ColorButton3.OnClick().Subscribe(OnSelectColor3);
        ColorButton4.OnClick().Subscribe(OnSelectColor4);
        ColorButton5.OnClick().Subscribe(OnSelectColor5);
        ColorButton6.OnClick().Subscribe(OnSelectColor6);
        ColorButton7.OnClick().Subscribe(OnSelectColor7);
        ColorButton8.OnClick().Subscribe(OnSelectColor8);
        ColorButton9.OnClick().Subscribe(OnSelectColor9);
        ColorButton10.OnClick().Subscribe(OnSelectColor10);
        ColorButton11.OnClick().Subscribe(OnSelectColor11);
        ColorButton12.OnClick().Subscribe(OnSelectColor12);
        ColorButton13.OnClick().Subscribe(OnSelectColor13);
        ColorButton14.OnClick().Subscribe(OnSelectColor14);

        NewUI : canvas = canvas{
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 285.0, Right := 1400.0, Bottom := 500.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 0
                    SizeToContent := false
                    Widget := ColorPickerHud
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -605.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton1
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -403.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton2
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -201.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton3
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 1.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton4
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 203.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton5
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 405.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton6
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 607.0, Top := 220.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton7
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -605.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton8
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -403.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton9
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -201.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton10
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 1.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton11
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 203.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton12
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 405.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton13
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 607.0, Top := 435.0, Right := 150.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ColorButton14
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -15.0, Top := 505.0, Right := 820.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ExitButton
        }