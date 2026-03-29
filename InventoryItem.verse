
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }


InventoryItem := class<concrete>:
    ### CONSTANTES
    INIT_MAX_QUANTITY : float = 5.0;
    ### VARIABLES
    var AcceptedItemId : int = -1;
    var Quantity : float = 0.0;
    var MaxQuantity : float = 5.0;
    var IsEmptySlot : logic = true;
    ### UI
    BackgroundTextureImage : texture_block = texture_block{DefaultImage := UI.InventorySlotCard,  DefaultDesiredSize := vector2{X := 132.0, Y := 132.0}};
    TextBlockQuantity : text_block = text_block{DefaultTextColor := NamedColors.White};
    ItemTextureImage : texture_block = texture_block{DefaultImage := UI.EmptySlotImage,  DefaultDesiredSize := vector2{X := 80.0, Y := 80.0}};

    ### GETTERS / SETTERS
    GetAcceptedItemId<public>() : int = return Self.AcceptedItemId;
    SetAcceptedItemId<public>(New : int) : void = set Self.AcceptedItemId = New;

    GetQuantity<public>() : float = return Self.Quantity;
    SetQuantity<public>(New : float) : void = set Self.Quantity = New;
    AddQuantity<public>(Amount : float) : void = 
        set Self.Quantity += Amount;
        UpdateUI();

    GetMaxQuantity<public>() : float = return Self.MaxQuantity;
    SetMaxQuantity<public>(New : float) : void = set Self.MaxQuantity = New;

    GetIsEmptySlot<public>() : logic = return Self.IsEmptySlot;
    SetIsEmptySlot<public>(New : logic) : void = set Self.IsEmptySlot = New;

    ### METHODS / UTILS
    ToMessage<localizes>(String : string) : message = "{String}";

    FormatNumber(Number : float) : string =
        ConvertedToStr := ToString(Number);
        var TempStr : string = "";
        for(Index := 0..3) {
            if(CurrentChar := ConvertedToStr[Index]) {
                set TempStr += ToString(CurrentChar);
            }
        }
        return TempStr;

    CanAddQuantity<public>(ItemWeight : float) : logic =
        if((ItemWeight + Self.Quantity) < Self.MaxQuantity) {
            return true;
        }
        return false;

    SetItemImage<public>(Image : texture) : void =
        ItemTextureImage.SetImage(Image);

    UpdateUI<public>() : void =
        TextBlockQuantity.SetText(ToMessage("{FormatNumber(Self.Quantity)}KG"));

    EmptySlot<public>() : void =
        SetItemImage(UI.EmptySlotImage);
        SetAcceptedItemId(-1);
        SetIsEmptySlot(true);
        SetQuantity(0.0);
        UpdateUI();

    ResetSlot<public>() : void =
        EmptySlot();
        SetMaxQuantity(INIT_MAX_QUANTITY);

    InitSlotUI<public>(XValue : float, YValue : float, CurrentCanvas : canvas) : void =
        ResetSlot();
        TempTextWidget := canvas_slot {
                Widget := TextBlockQuantity;
                Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                Offsets := margin{Left := XValue, Top := YValue - 42.0, Right := 200.0, Bottom := 40.0}
                Alignment := vector2{X:= 0.5, Y:= 0.5}
                SizeToContent := true
            };
        #TextBlockQuantity.SetText(ToMessage("0.00KG"));
        CurrentCanvas.AddWidget(TempTextWidget);

        TempImageWidget := canvas_slot {
                Widget := BackgroundTextureImage
                Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                Offsets := margin{Left := XValue, Top := YValue, Right := 132.0, Bottom := 132.0}
                Alignment := vector2{X:= 0.5, Y:= 0.5}
                SizeToContent := false
            };
        CurrentCanvas.AddWidget(TempImageWidget);

        TempItemImageWidget := canvas_slot {
            Widget := ItemTextureImage
            Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
            Offsets := margin{Left := XValue, Top := YValue + 20.0, Right := 80.0, Bottom := 80.0}
            Alignment := vector2{X:= 0.5, Y:= 0.5}
            SizeToContent := false
        };
        CurrentCanvas.AddWidget(TempItemImageWidget);
        return;