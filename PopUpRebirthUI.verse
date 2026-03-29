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
using { /Verse.org/Random }

PopUpRebirthUI := class:
    var PopUpCanvas : canvas = canvas{};
    var BackgroundPopUp : texture_block = texture_block{DefaultImage := HUD.PopUpRebirthBoost};
    var RebirthTextBlock : text_block = text_block{DefaultTextColor := NamedColors.Black};
    var BoostTextBlock : text_block = text_block{DefaultTextColor := NamedColors.Black};
    var IsExit : logic = false;

    ToMessageRebirth<localizes>(String : string) : message = "REBIRTH : {String}";
    ToMessageBoost<localizes>(String : string) : message = "+ {String}%";

    Initialize(Agent : agent, Rebirth : int) : void =
        set PopUpCanvas = MakeUI();
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.AddWidget(PopUpCanvas);
        }
        RebirthTextBlock.SetText(ToMessageRebirth(ToString(Rebirth)));
        RebirthTextBlock.SetTextOpacity(1.0);

        BoostTextBlock.SetText(ToMessageBoost(ToString(Rebirth * 5)));
        BoostTextBlock.SetTextOpacity(1.0);

        spawn{PlayAnimation(Agent)};

    DestroyPopUp(Player : player) : void =
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(BackgroundPopUp);
            PlayerUI.RemoveWidget(PopUpCanvas);
        }

    PlayAnimation(Agent : agent)<suspends> : void =
        Sleep(4.0);
        if(Player := player[Agent]) { 
            DestroyPopUp(Player);
            return;
        }

    MakeUI() : canvas =
        NewCanvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= 0.0, Top := 0.0, Right:=404.0, Bottom:=514.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := false
                    ZOrder := 0
                    Widget := BackgroundPopUp
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= 0.0, Top := 95.0, Right:=207.0, Bottom:=41.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := true
                    ZOrder := 1
                    Widget := RebirthTextBlock
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= -90.0, Top := 203.0, Right:=0.0, Bottom:=0.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := true
                    ZOrder := 1
                    Widget := BoostTextBlock