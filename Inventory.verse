
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Assets }


Inventory := class:
    ### CONSTANTES
    MAX_SLOTS_NUMBER : int = 9;
    ### VARIABLES
    Player : player;
    var InventorySlots<private> : []InventoryItem = array{};
    ### UI
    var MainCanvas : canvas = canvas{};

    ### GETTERS / SETTERS
    GetPlayer<public>() : player = return Self.Player;

    GetInventorySlots<public>() : []InventoryItem = return Self.InventorySlots;
    SetInventorySlots<public>(New : []InventoryItem) : void = set Self.InventorySlots = New;

    ### METHODS / UTILS
    InitIventoryToPlayer<public>() : void =
        SetInventorySlots(array{InventoryItem{}, InventoryItem{}, InventoryItem{}, InventoryItem{}, InventoryItem{}, InventoryItem{}, InventoryItem{}, InventoryItem{}, InventoryItem{}});
        AddUI();

    GetInventorySlotContent(Index : int) : tuple(int, float) =
        if(CurrentSlotInv := InventorySlots[Index]) {
            return (CurrentSlotInv.GetAcceptedItemId(), CurrentSlotInv.GetQuantity());
        }
        return (0, 0.0);

    ReloadInventorySlotContent(Index : int, ItemId : int, Quantity : float, Image : texture) : void =
        if(ItemId <> -1) {
            if(CurrentSlotInv := InventorySlots[Index]) {
                CurrentSlotInv.SetAcceptedItemId(ItemId);
                CurrentSlotInv.AddQuantity(Quantity);
                CurrentSlotInv.SetItemImage(Image);
                CurrentSlotInv.UpdateUI();
                CurrentSlotInv.SetIsEmptySlot(false);
            }
        }

    GetFirstEmptySlot<private>() : ?InventoryItem =
        for(Slot : InventorySlots) {
            IsEmptySlot := Slot.GetIsEmptySlot();
            if(IsEmptySlot?) {
                return option{Slot};
            }
        }
        return false;

    GetFirstAvailableSlotOfSameType<public>(ItemId : int, ItemWeight : float) : ?InventoryItem =
        for(Slot : InventorySlots) {
            SlotItemId := Slot.GetAcceptedItemId();
            CurrentSlotQuantity := Slot.CanAddQuantity(ItemWeight);
            if(SlotItemId = ItemId and CurrentSlotQuantity?) {
                return option{Slot};
            }
        }
        return false;

    # CanAddQuantityToSlot<public>(ItemWeight : float, CurrentSlot : InventoryItem) : logic =
    #     CurrentSlotQuantity := CurrentSlot.CanAddQuantity(ItemWeight);
    #     if(CurrentSlotQuantity?) {
    #         return true;
    #     }

    AddItemToInventory<public>(ItemId : int, ItemWeight : float, Image : texture) : logic =
        SlotAlreadyExist := GetFirstAvailableSlotOfSameType(ItemId, ItemWeight);
        if(TempSlot := SlotAlreadyExist?) { 
            CurrentSlotQuantity := TempSlot.CanAddQuantity(ItemWeight);
            if(CurrentSlotQuantity?) {
                TempSlot.AddQuantity(ItemWeight);
                return true;
            } else {
                NewSlot := GetFirstEmptySlot();
                if(TempNewSlot := NewSlot?) {
                    TempNewSlot.SetAcceptedItemId(ItemId);
                    TempNewSlot.AddQuantity(ItemWeight);
                    TempNewSlot.SetItemImage(Image);
                    TempNewSlot.UpdateUI();
                    TempNewSlot.SetIsEmptySlot(false);
                    return true;
                } else {
                    Print("> INVENTORY FULL !");
                }
            }
        } else {
            Print("> NO SLOTS CURRENTLY EXISTS TO THIS TYPE");
            NewSlot := GetFirstEmptySlot();
            if(TempNewSlot := NewSlot?) {
                TempNewSlot.SetAcceptedItemId(ItemId);
                TempNewSlot.AddQuantity(ItemWeight);
                TempNewSlot.SetItemImage(Image);
                TempNewSlot.UpdateUI();
                TempNewSlot.SetIsEmptySlot(false);
                return true;
            } else {
                Print("> INVENTORY FULL !");
            }
        }
        return false;

    AddUI() : void =
        if(PlayerUI := GetPlayerUI[Player]) {
            InitUI();
            PlayerUI.AddWidget(MainCanvas);
        }

    InitUI() : void =
        var InitValueX : float = -615.0;
        var InitValueY : float = 450.0;
        var SlotCounter : int = 0;

        for(Slot : InventorySlots) {
            Slot.InitSlotUI(InitValueX, InitValueY, MainCanvas);
            set InitValueX += 147.0; # 132.0 + 15.0 <- Margin between slots
            set SlotCounter += 1;
            if(SlotCounter = MAX_SLOTS_NUMBER) { return; }
        }
