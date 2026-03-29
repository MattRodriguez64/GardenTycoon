
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


BoostFastGrowingUI := class:
    var MainCanvas : canvas = canvas{};
    var BoostImageBackground : texture_block = texture_block{DefaultImage := UI.BoostBackgroundV4, DefaultDesiredSize := vector2{X := 1380.0, Y := 880.0}};
    var BaseManagerDev : BaseManager = BaseManager{};
    var BoostsPlot : []BoostItem = array{};

    # EXIT BUTTON
    var ExitButton : button_quiet = button_quiet{};

    var BoostButton1 : button_quiet = button_quiet{};
    var BoostButton2 : button_quiet = button_quiet{};
    var BoostButton3 : button_quiet = button_quiet{};
    var BoostButton4 : button_quiet = button_quiet{};
    var BoostButton5 : button_quiet = button_quiet{};
    var BoostButton6 : button_quiet = button_quiet{};
    var BoostButton7 : button_quiet = button_quiet{};
    var BoostButton8 : button_quiet = button_quiet{};
    var BoostButton9 : button_quiet = button_quiet{};
    var BoostButton10 : button_quiet = button_quiet{};
    var BoostButton11 : button_quiet = button_quiet{};
    var BoostButton12 : button_quiet = button_quiet{};

    AddUI(Agent : agent) : void =
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            set MainCanvas = CreateUI();
            PlayerUI.AddWidget(MainCanvas, player_ui_slot{InputMode := ui_input_mode.All});
        }
    
    Exit(Player : player) : void =
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(MainCanvas);
        }

    HandleExit(Message : widget_message) : void =
        Player := Message.Player;
        Exit(Player);

    OnSelectBoostButton1(Message : widget_message) : void =
        Print(">OnSelectBoostButton1");
        CanBuy := BaseManagerDev.CanBuyItem(800);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(1);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[0]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(800);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton2(Message : widget_message) : void =
        Print(">OnSelectBoostButton2");
        CanBuy := BaseManagerDev.CanBuyItem(1000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(2);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[1]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(1000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton3(Message : widget_message) : void =
        Print(">OnSelectBoostButton3");
        CanBuy := BaseManagerDev.CanBuyItem(1500);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(3);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[2]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(1500);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton4(Message : widget_message) : void =
        Print(">OnSelectBoostButton4");
        CanBuy := BaseManagerDev.CanBuyItem(2000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(4);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[3]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(2000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton5(Message : widget_message) : void =
        Print(">OnSelectBoostButton5");
        CanBuy := BaseManagerDev.CanBuyItem(3000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(5);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[4]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(3000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton6(Message : widget_message) : void =
        Print(">OnSelectBoostButton6");
        CanBuy := BaseManagerDev.CanBuyItem(4000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(6);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[5]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(4000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton7(Message : widget_message) : void =
        Print(">OnSelectBoostButton7");
        CanBuy := BaseManagerDev.CanBuyItem(6000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(7);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[6]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(6000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton8(Message : widget_message) : void =
        Print(">OnSelectBoostButton8");
        CanBuy := BaseManagerDev.CanBuyItem(8000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(8);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[7]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(8000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton9(Message : widget_message) : void =
        Print(">OnSelectBoostButton9");
        CanBuy := BaseManagerDev.CanBuyItem(10000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(9);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[8]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(10000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton10(Message : widget_message) : void =
        Print(">OnSelectBoostButton10");
        CanBuy := BaseManagerDev.CanBuyItem(15000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(10);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[9]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(15000);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton11(Message : widget_message) : void =
        Print(">OnSelectBoostButton11");
        CanBuy := BaseManagerDev.CanBuyItem(3500);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(11);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[10]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(3500);
                Exit(Message.Player);
            }
        }

    OnSelectBoostButton12(Message : widget_message) : void =
        Print(">OnSelectBoostButton12");
        CanBuy := BaseManagerDev.CanBuyItem(5000);
        if(CanBuy?) {
            GetPF := BaseManagerDev.GetPlotFarming(12);
            if(GetPFNonNull := GetPF?, CurrentBoost := BoostsPlot[11]) {
                if(CurrentBoost.IsActiveBonus?) { return; }
                CurrentBoost.Boost(GetPFNonNull);
                BaseManagerDev.WithdrawMoney(5000);
                Exit(Message.Player);
            }
        }

    CreateUI() : canvas =
        Print(">CreateUI");
        ExitButton.OnClick().Subscribe(HandleExit);

        BoostButton1.OnClick().Subscribe(OnSelectBoostButton1);
        BoostButton2.OnClick().Subscribe(OnSelectBoostButton2);
        BoostButton3.OnClick().Subscribe(OnSelectBoostButton3);
        BoostButton4.OnClick().Subscribe(OnSelectBoostButton4);
        BoostButton5.OnClick().Subscribe(OnSelectBoostButton5);
        BoostButton6.OnClick().Subscribe(OnSelectBoostButton6);
        BoostButton7.OnClick().Subscribe(OnSelectBoostButton7);
        BoostButton8.OnClick().Subscribe(OnSelectBoostButton8);
        BoostButton9.OnClick().Subscribe(OnSelectBoostButton9);
        BoostButton10.OnClick().Subscribe(OnSelectBoostButton10);
        BoostButton11.OnClick().Subscribe(OnSelectBoostButton11);
        BoostButton12.OnClick().Subscribe(OnSelectBoostButton12);

        NewUI : canvas = canvas{
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 0.0, Right := 1380.0, Bottom := 880.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 0
                    SizeToContent := false
                    Widget := BoostImageBackground
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 395.0, Right := 1330.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ExitButton
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -385.0, Top := -220.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton1
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -385.0, Top := -60.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton2
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -385.0, Top := 100.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton3
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -385.0, Top := 260.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton4
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 60.0, Top := -220.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton5
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 60.0, Top := -60.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton6
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 60.0, Top := 100.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton7
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 60.0, Top := 260.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton8
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 505.0, Top := -220.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton9
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 505.0, Top := -60.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton10
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 505.0, Top := 100.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton11
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 505.0, Top := 260.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := BoostButton12
        }

        return NewUI;