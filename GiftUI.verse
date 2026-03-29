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

GiftUI := class:
    # TIMER
    #var DeliveryManagerDevice : DeliveryManager = DeliveryManager{};
    var CurrentTimer : timer_device = timer_device{};
    var IsExit : logic = false;
    var MinusValuesInSec : []float = array{3300.0, 3000.0, 2700.0, 2400.0, 2100.0, 1800.0, 1500.0, 1200.0, 900.0, 600.0, 300.0, 150.0};
    var ChestArr : []logic = array{};
    var BaseManagerDev : BaseManager = BaseManager{};

    # DEVICES
    var RewardXP : accolades_device = accolades_device{};

    var MainCanvas : canvas = canvas{};
    var GiftBox_Background : texture_block = texture_block{DefaultImage := UI.GiftBoxAppUIV2, DefaultDesiredSize := vector2{X := 950.0, Y := 900.0}};

    # EXIT BUTTON
    var ExitButton : button_quiet = button_quiet{};
    # BACK BUTTON
    var BackButton : button_quiet = button_quiet{};

    # SLOT 1 BUTTON
    var Slot1Button : button_quiet = button_quiet{};
    # SLOT 2 BUTTON
    var Slot2Button : button_quiet = button_quiet{};
    # SLOT 3 BUTTON
    var Slot3Button : button_quiet = button_quiet{};
    # SLOT 4 BUTTON
    var Slot4Button : button_quiet = button_quiet{};
    # SLOT 5 BUTTON
    var Slot5Button : button_quiet = button_quiet{};
    # SLOT 6 BUTTON
    var Slot6Button : button_quiet = button_quiet{};
    # SLOT 7 BUTTON
    var Slot7Button : button_quiet = button_quiet{};
    # SLOT 8 BUTTON
    var Slot8Button : button_quiet = button_quiet{};
    # SLOT 9 BUTTON
    var Slot9Button : button_quiet = button_quiet{};
    # SLOT 10 BUTTON
    var Slot10Button : button_quiet = button_quiet{};
    # SLOT 11 BUTTON
    var Slot11Button : button_quiet = button_quiet{};
    # SLOT 12 BUTTON
    var Slot12Button : button_quiet = button_quiet{};

    var AllSlotButtons : []button_quiet = array{};

    ToMessage<localizes>(String : string) : message = "{String}";

    AddUI(Agent : agent) : void =
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            set MainCanvas = CreateUI();
            PlayerUI.AddWidget(MainCanvas, player_ui_slot{InputMode := ui_input_mode.All});

            set AllSlotButtons = array{Slot1Button, Slot2Button, Slot3Button, Slot4Button, Slot5Button, 
            Slot6Button, Slot7Button, Slot8Button, Slot9Button, Slot10Button, Slot11Button, Slot12Button};

            set CurrentTimer = BaseManagerDev.GetTimerGiftBox();
            set ChestArr = BaseManagerDev.GetChestClaimedArr();
            set RewardXP = BaseManagerDev.GetGiftBoxRewardXP();
            spawn:
                UpdateUI(Agent);
        }

    HandleExit(Message : widget_message) : void =
        Player := Message.Player;
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(MainCanvas);
            set IsExit = true;
        }

    UpdateUI(Agent : agent)<suspends> : void =
        Print(">UpdateUI");
        var Index : int = 0;

        loop:
            BaseManagerDev.SetChestClaimedArr(ChestArr);
            Sleep(1.0);
            TimerValue := CurrentTimer.GetActiveDuration(Agent);
            if(IsExit = true) {
                break;
            }

            for(CurrentButton : AllSlotButtons) {
                if(MinusValue := MinusValuesInSec[Index], TimerSlot := Round[TimerValue - MinusValue], TimerSlot > 0) {
                    CurrentButton.SetText(ToMessage("{FormatSecondsToMinutes(TimerSlot)}"));
                } else {
                    if(IsClaimed := ChestArr[Index], IsClaimed = false) {
                        CurrentButton.SetEnabled(true);
                        CurrentButton.SetText(ToMessage("CLAIM"));
                    } else {
                        CurrentButton.SetText(ToMessage("CLAIMED"));
                    }
                }
                set Index += 1;
            }
            set Index = 0;

    OnPlayerClickButtonSlot1(Message : widget_message) : void =
        Print(">CLAIM SLOT 1 - CHEST");
        if(set ChestArr[0] = true) {
            Print(">ChestClaimedArr[0] false -> true;");
            Slot1Button.SetEnabled(false);
            Slot1Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(50);
        }

    OnPlayerClickButtonSlot2(Message : widget_message) : void =
        Print(">CLAIM SLOT 2 - CHEST");
        if(set ChestArr[1] = true) {
            Print(">ChestClaimedArr[1] false -> true;");
            Slot2Button.SetEnabled(false);
            Slot2Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(100);
        }

    OnPlayerClickButtonSlot3(Message : widget_message) : void =
        Print(">CLAIM SLOT 3 - CHEST");
        if(set ChestArr[2] = true) {
            Print(">ChestClaimedArr[2] false -> true;");
            Slot3Button.SetEnabled(false);
            Slot3Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(200);
        }

    OnPlayerClickButtonSlot4(Message : widget_message) : void =
        Print(">CLAIM SLOT 4 - CHEST");
        if(set ChestArr[3] = true) {
            Print(">ChestClaimedArr[3] false -> true;");
            Slot4Button.SetEnabled(false);
            Slot4Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(300);
        }

    OnPlayerClickButtonSlot5(Message : widget_message) : void =
        Print(">CLAIM SLOT 5 - CHEST");
        if(set ChestArr[4] = true) {
            Print(">ChestClaimedArr[4] false -> true;");
            Slot5Button.SetEnabled(false);
            Slot5Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(400);
        }

    OnPlayerClickButtonSlot6(Message : widget_message) : void =
        Print(">CLAIM SLOT 6 - CHEST");
        if(set ChestArr[5] = true) {
            Print(">ChestClaimedArr[5] false -> true;");
            Slot6Button.SetEnabled(false);
            Slot6Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(500);
        }

    OnPlayerClickButtonSlot7(Message : widget_message) : void =
        Print(">CLAIM SLOT 7 - CHEST");
        if(set ChestArr[6] = true) {
            Print(">ChestClaimedArr[6] false -> true;");
            Slot7Button.SetEnabled(false);
            Slot7Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(1000);
        }

    OnPlayerClickButtonSlot8(Message : widget_message) : void =
        Print(">CLAIM SLOT 8 - CHEST");
        if(set ChestArr[7] = true) {
            Print(">ChestClaimedArr[7] false -> true;");
            Slot8Button.SetEnabled(false);
            Slot8Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(2000);
        }

    OnPlayerClickButtonSlot9(Message : widget_message) : void =
        Print(">CLAIM SLOT 9 - CHEST");
        if(set ChestArr[8] = true) {
            Print(">ChestClaimedArr[8] false -> true;");
            Slot9Button.SetEnabled(false);
            Slot9Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(3500);
        }

    OnPlayerClickButtonSlot10(Message : widget_message) : void =
        Print(">CLAIM SLOT 10 - CHEST");
        if(set ChestArr[9] = true) {
            Print(">ChestClaimedArr[9] false -> true;");
            Slot10Button.SetEnabled(false);
            Slot10Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(4000);
        }

    OnPlayerClickButtonSlot11(Message : widget_message) : void =
        Print(">CLAIM SLOT 11 - CHEST");
        if(set ChestArr[10] = true) {
            Print(">ChestClaimedArr[10] false -> true;");
            Slot11Button.SetEnabled(false);
            Slot11Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(4500);
        }

    OnPlayerClickButtonSlot12(Message : widget_message) : void =
        Print(">CLAIM SLOT 12 - CHEST");
        if(set ChestArr[11] = true) {
            Print(">ChestClaimedArr[11] false -> true;");
            Slot12Button.SetEnabled(false);
            Slot12Button.SetText(ToMessage("CLAIMED"));
            RewardXP.Award(Message.Player);
            BaseManagerDev.AddMoney(5000);
        }

    FormatSecondsToMinutes<public>(Seconds : int) : string = 
        Minutes := Floor(Seconds / 60) or 0
        RemainingSeconds := Mod[Seconds, 60] or 0
        return "{Minutes < 10 and "0{Minutes}" or "{Minutes}"}:{RemainingSeconds < 10 and "0{RemainingSeconds}" or "{RemainingSeconds}"}"
             
    CreateUI() : canvas =
        Print(">CreateUI");
        ExitButton.OnClick().Subscribe(HandleExit);

        Slot1Button.SetEnabled(false);
        Slot1Button.OnClick().Subscribe(OnPlayerClickButtonSlot1);
        if(IsClaimed := ChestArr[0], IsClaimed = true) {
            Slot1Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot2Button.SetEnabled(false);
        Slot2Button.OnClick().Subscribe(OnPlayerClickButtonSlot2);
        if(IsClaimed := ChestArr[1], IsClaimed = true) {
            Slot2Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot3Button.SetEnabled(false);
        Slot3Button.OnClick().Subscribe(OnPlayerClickButtonSlot3);
        if(IsClaimed := ChestArr[2], IsClaimed = true) {
            Slot3Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot4Button.SetEnabled(false);
        Slot4Button.OnClick().Subscribe(OnPlayerClickButtonSlot4);
        if(IsClaimed := ChestArr[3], IsClaimed = true) {
            Slot4Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot5Button.SetEnabled(false);
        Slot5Button.OnClick().Subscribe(OnPlayerClickButtonSlot5);
        if(IsClaimed := ChestArr[4], IsClaimed = true) {
            Slot5Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot6Button.SetEnabled(false);
        Slot6Button.OnClick().Subscribe(OnPlayerClickButtonSlot6);
        if(IsClaimed := ChestArr[5], IsClaimed = true) {
            Slot6Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot7Button.SetEnabled(false);
        Slot7Button.OnClick().Subscribe(OnPlayerClickButtonSlot7);
        if(IsClaimed := ChestArr[6], IsClaimed = true) {
            Slot7Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot8Button.SetEnabled(false);
        Slot8Button.OnClick().Subscribe(OnPlayerClickButtonSlot8);
        if(IsClaimed := ChestArr[7], IsClaimed = true) {
            Slot8Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot9Button.SetEnabled(false);
        Slot9Button.OnClick().Subscribe(OnPlayerClickButtonSlot9);
        if(IsClaimed := ChestArr[8], IsClaimed = true) {
            Slot9Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot10Button.SetEnabled(false);
        Slot10Button.OnClick().Subscribe(OnPlayerClickButtonSlot10);
        if(IsClaimed := ChestArr[9], IsClaimed = true) {
            Slot10Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot11Button.SetEnabled(false);
        Slot11Button.OnClick().Subscribe(OnPlayerClickButtonSlot11);
        if(IsClaimed := ChestArr[10], IsClaimed = true) {
            Slot11Button.SetText(ToMessage("CLAIMED !"));
        }

        Slot12Button.SetEnabled(false);
        Slot12Button.OnClick().Subscribe(OnPlayerClickButtonSlot12);
        if(IsClaimed := ChestArr[11], IsClaimed = true) {
            Slot12Button.SetText(ToMessage("CLAIMED !"));
        }

        NewUI : canvas = canvas{
            Slots := array:
                canvas_slot:
                    # PHONE BACKGROUND
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 0.0, Right := 950.0, Bottom := 900.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 0
                    SizeToContent := false
                    Widget := GiftBox_Background
                canvas_slot:
                    # SLOT 1 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -356.0, Top := -152.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot1Button
                canvas_slot:
                    # SLOT 2 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -120.0, Top := -152.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot2Button
                canvas_slot:
                    # SLOT 3 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 115.0, Top := -152.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot3Button
                canvas_slot:
                    # SLOT 4 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 355.0, Top := -152.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot4Button
                canvas_slot:
                    # SLOT 5 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -356.0, Top := 60.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot5Button
                canvas_slot:
                    # SLOT 6 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -120.0, Top := 60.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot6Button
                canvas_slot:
                    # SLOT 7 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 115.0, Top := 60.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot7Button
                canvas_slot:
                    # SLOT 8 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 355.0, Top := 60.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot8Button
                canvas_slot:
                    # SLOT 9 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -356.0, Top := 275.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot9Button
                canvas_slot:
                    # SLOT 10 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -120.0, Top := 275.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot10Button
                canvas_slot:
                    # SLOT 11 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 115.0, Top := 275.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot11Button
                canvas_slot:
                    # SLOT 12 BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 355.0, Top := 275.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := Slot12Button
                canvas_slot:
                    # EXIT BUTTON
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 400.0, Right := 910.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ExitButton
        }