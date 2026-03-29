
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


PetsManagerUI := class:
    var MainCanvas : canvas = canvas{};
    var PetsImageBackground : texture_block = texture_block{DefaultImage := UI.PetsBackgroundUI, DefaultDesiredSize := vector2{X := 1000.0, Y := 800.0}};
    var PetsManagerDevice : PetsManager = PetsManager{};
    var AllPlayerOwnedPets : []PetDataSlot = array{};
    var AllCanvasSlots : []canvas_slot = array{};
    var ActivePetData : PetDataSlot = PetDataSlot{};

    var BonusText : text_block = text_block{DefaultTextColor := NamedColors.Black};
    var EquipButton : button_quiet = button_quiet{};
    var ActivePetImage : texture_block = texture_block{DefaultImage := UI.EmptySlotImage, DefaultDesiredSize := vector2{X := 200.0, Y := 200.0}};

    # EXIT BUTTON
    var ExitButton : button_quiet = button_quiet{};

    ToMessage<localizes>(String : string) : message = "+{String}%";

    AddUI(Agent : agent) : void =
        if(Player := player[Agent], PlayerUI := GetPlayerUI[Player]) {
            set MainCanvas = CreateUI();
            GenerateAllSlots();
            PlayerUI.AddWidget(MainCanvas, player_ui_slot{InputMode := ui_input_mode.All});
        }
    
    Exit(Player : player) : void =
        if(PlayerUI := GetPlayerUI[Player]) {
            PlayerUI.RemoveWidget(MainCanvas);
        }

    HandleExit(Message : widget_message) : void =
        Player := Message.Player;
        Exit(Player);

    OnPlayerEquip(Message : widget_message) : void =
        Player := Message.Player;
        if(Agent := agent[Player]) {
            PetsManagerDevice.ChoosePetById(Agent, ActivePetData.Index);
        }
        
        Exit(Player);

    GenerateAllSlots<private>() : void =
        var StartingX : float = -354.0;
        var StartingY : float = 7.0;
        var CurrentX : float = -354.0;
        var CurrentY : float = 7.0;
        var Counter : int = 0;

        for(I := 0..20) {
            if(GetCurrentPet := AllPlayerOwnedPets[I]) {
                var CurrentPetImage : texture_block = texture_block{DefaultImage := GetCurrentPet.CustomTexture, DefaultDesiredSize := vector2{X := 85.0, Y := 85.0}};

                CurrentImageSlot : canvas_slot = canvas_slot{
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := CurrentX, Top := CurrentY, Right := 85.0, Bottom := 85.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 2
                    SizeToContent := false
                    Widget := CurrentPetImage
                }

                MainCanvas.AddWidget(CurrentImageSlot);
            } else {
                CurrentImageSlot : canvas_slot = canvas_slot{
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := CurrentX, Top := CurrentY, Right := 85.0, Bottom := 85.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 3
                    SizeToContent := false
                    Widget := texture_block{DefaultImage := UI.EmptySlotImage, DefaultDesiredSize := vector2{X := 85.0, Y := 85.0}};
                }

                MainCanvas.AddWidget(CurrentImageSlot);
            }
            
            var CurrentButton : button_quiet = button_quiet{};
            CurrentSlot : canvas_slot = canvas_slot{
                Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                Offsets := margin{Left := CurrentX, Top := CurrentY, Right := 90.0, Bottom := 90.0}
                Alignment := vector2{X:= 0.5, Y:= 0.5}
                ZOrder := 4
                SizeToContent := false
                Widget := CurrentButton
            }
            CurrentButton.OnClick().Subscribe(OnClicked);
            MainCanvas.AddWidget(CurrentSlot);
            set AllCanvasSlots = AllCanvasSlots + array{CurrentSlot};

            set CurrentX += 118.0;
            set Counter += 1;
            if(Counter = 7) {
                set Counter = 0;
                set CurrentX = StartingX;
                set CurrentY += 124.0;
            }
        } 

    OnClicked<private>(Message : widget_message) : void =
        Print("OnClicked");
        Source := Message.Source;
        GetIndex := GetIndexFromSource(Source);
        Print("GetIndex : {GetIndex}");
        if(CurrentSelectedPet := AllPlayerOwnedPets[GetIndex]) {
            if(ConvertedBonus := Int[CurrentSelectedPet.Bonus * 100]) {
                BonusText.SetText(ToMessage("{ConvertedBonus}"));
            }
            ActivePetImage.SetImage(CurrentSelectedPet.CustomTexture);
            set ActivePetData = CurrentSelectedPet;
        } else {
            BonusText.SetText(ToMessage("0.0"));
            ActivePetImage.SetImage(UI.EmptySlotImage);
            set ActivePetData = PetDataSlot{};
        }

    GetIndexFromSource<private>(WidgetToSearch : widget) : int =
        var TempPosition : int = 0;
        for(Slot : AllCanvasSlots) {
            if(Slot.Widget = WidgetToSearch) {
                return TempPosition;
            }
            set TempPosition += 1;
        }

        return -1;

    CreateUI() : canvas =
        Print(">CreateUI");
        ExitButton.OnClick().Subscribe(HandleExit);
        EquipButton.OnClick().Subscribe(OnPlayerEquip);
        BonusText.SetText(ToMessage("0.0"));

        NewUI : canvas = canvas{
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 0.0, Right := 1000.0, Bottom := 800.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 0
                    SizeToContent := false
                    Widget := PetsImageBackground
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := 364.0, Right := 810.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ExitButton
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := -266.0, Top := -260.0, Right := 200.0, Bottom := 56.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := BonusText
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 247.0, Top := -180.0, Right := 225.0, Bottom := 50.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := EquipButton
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X:= 0.5, Y:= 0.5}, Maximum := vector2{X:= 0.5, Y:= 0.5}}
                    Offsets := margin{Left := 0.0, Top := -180.0, Right := 200.0, Bottom := 200.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    ZOrder := 1
                    SizeToContent := false
                    Widget := ActivePetImage
        }

        return NewUI;