
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors/NamedColors }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Characters }
using { /Verse.org/Colors }
using { /Fortnite.com/UI }

PlayerLevelUI := class():
    var ProgressCanvas : canvas = canvas{};
    var PlayerLevelCard : color_block = color_block{DefaultColor := NamedColors.Black, DefaultOpacity := 0.75, DefaultDesiredSize := vector2{X := 470.0, Y := 40.0}};
    var BackgroundBar : color_block = color_block{DefaultColor := NamedColors.White};
    var ProgressBarWid : color_block = color_block{DefaultColor := NamedColors.Green};
    var PercentageValueTextBlock : text_block = text_block{DefaultTextColor := NamedColors.Black};
    var LevelTextBlock : text_block = text_block{DefaultTextColor := NamedColors.White};
    var XpNeededTextBlock : text_block = text_block{DefaultTextColor := NamedColors.White};

    ToMessage<localizes>(String : string) : message = "{String}";

    Initialize(Agent : agent) : void =
        set ProgressCanvas = MakeUI();
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.AddWidget(ProgressCanvas);
        }

    UpdateUI(LevelToDisplay : int, Coeff : float, XpLimit : int, CurrentXp : int) : void =
        
        ProgressBarWid.SetVisibility(widget_visibility.Hidden);
        ProgressCanvas.RemoveWidget(ProgressBarWid);
        ProgressBarWid.SetVisibility(widget_visibility.Visible);
        ProgressCanvas.AddWidget(
            canvas_slot:
                Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                Offsets := margin{Left:= -235.0, Top := 323.0, Right:=Coeff, Bottom:=20.0}
                Alignment := vector2{X:=0.0, Y:=0.5}
                SizeToContent := false
                ZOrder := 1
                Widget := ProgressBarWid
        );
        LevelTextBlock.SetText(ToMessage("LVL.{ToString(LevelToDisplay)}"));
        XpNeededTextBlock.SetText(ToMessage("{ToString(CurrentXp)}/{ToString(XpLimit)}"));

    MakeUI() : canvas =
        LevelTextBlock.SetText(ToMessage("LVL.1"));
        XpNeededTextBlock.SetText(ToMessage("0/320"));
        NewCanvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= 0.0, Top := 323.0, Right:=470.0, Bottom:=20.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := false
                    ZOrder := 0
                    Widget := BackgroundBar

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= -235.0, Top := 323.0, Right:=0.0, Bottom:=20.0}
                    Alignment := vector2{X:=0.0, Y:=0.5}
                    SizeToContent := false
                    ZOrder := 1
                    Widget := ProgressBarWid

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= 0.0, Top := -105.0, Right:=0.0, Bottom:=0.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := true
                    ZOrder := 2
                    Widget := PercentageValueTextBlock

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= 0.0, Top := 293.0, Right:=470.0, Bottom:=40.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := false
                    ZOrder := 10
                    Widget := PlayerLevelCard
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= -192.0, Top := 293.0, Right:=0.0, Bottom:=0.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := true
                    ZOrder := 11
                    Widget := LevelTextBlock
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:=0.5, Y:= 0.5}, Maximum := vector2{X:=0.5, Y:=0.5}}
                    Offsets := margin{Left:= 120.0, Top := 293.0, Right:=0.0, Bottom:=0.0}
                    Alignment := vector2{X:=0.5, Y:=0.5}
                    SizeToContent := true
                    ZOrder := 11
                    Widget := XpNeededTextBlock


PlayerLevel := class:

    var CurrentAgent : ?agent = false;
    var CurrentLevel : int = 1;
    var CurrentXp : int = 0;
    var NextLevelXpNeeded : int = 320;
    var CurrentPlayerLevelUI : PlayerLevelUI = PlayerLevelUI{};

    SetPlayerUI() : void =
        if(TempAgent := CurrentAgent?) {
            CurrentPlayerLevelUI.Initialize(TempAgent);
        }

    SetAgent(Agent : agent) : void = set Self.CurrentAgent = option{Agent};

    SetCurrentXp(Amount : int) : void = set Self.CurrentXp = Amount;
    GetCurrentXp() : int = return Self.CurrentXp;

    SetCurrentLevel(Amount : int) : void = set Self.CurrentLevel = Amount;
    GetCurrentLevel() : int = return Self.CurrentLevel;

    SetNextLevelXpNeeded(Amount : int) : void = set Self.NextLevelXpNeeded = Amount;
    GetNextLevelXpNeeded() : int = return Self.NextLevelXpNeeded;

    AddCurrentXp(Amount : int) : void = 
        set Self.CurrentXp += Amount;
        TempValue := IsLevelUp();
        if(TempValue?) {
            UpgradeLevel();
        }
        UpdateUI();

    UpgradeLevel() : void = 
        set Self.CurrentLevel += 1;
        set CurrentXp = 0;
        set NextLevelXpNeeded += 320;

    IsLevelUp() : logic =
        if(Self.CurrentXp >= Self.NextLevelXpNeeded) {
            return true;
        }
        return false;

    UpdateUI() : void =
        CoeffXp := (((CurrentXp * 1.0) / (NextLevelXpNeeded * 1.0)) * 100.0) * 3.80;
        CurrentPlayerLevelUI.UpdateUI(CurrentLevel, CoeffXp, NextLevelXpNeeded, CurrentXp);
