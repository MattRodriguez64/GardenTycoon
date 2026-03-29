
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


ShopItem := class :
    @editable TypeId : int = 0;
    @editable PriceKg : float = 0.0;


ShopManager := class(creative_device):

    @editable SellButton : button_device = button_device{};
    @editable GameManagerDev : GameManager = GameManager{};
    @editable ShopItems : []ShopItem = array{};
    @editable HudMessage : hud_message_device = hud_message_device{};
    @editable SellXP : accolades_device = accolades_device{};
    
    ToMessage<localizes>(String : string) : message = "+ {String}$";

    OnBegin<override>()<suspends>:void=
        Print("ShopManager");
        SellButton.InteractedWithEvent.Subscribe(OnPlayerSellInventory);

    GetPrice<public>(ItemId : int) : float =
        for(CurrentShopItem : ShopItems) {
            if(CurrentShopItem.TypeId = ItemId) {
                return CurrentShopItem.PriceKg;
            }
        }

        return 0.0;

    OnPlayerSellInventory(Agent : agent) : void =
        Print(">OnPlayerSellInventory");
        if(Player := player[Agent]) {
            PlayerInventory := GameManagerDev.GetPlayerInventory(Player);
            if(PlayerInventoryNonNull := PlayerInventory?) {
                PlayerInventorySlots := PlayerInventoryNonNull.GetInventorySlots();
                var TempMoneyEnd : int = 0;
                for(Slot : PlayerInventorySlots) {
                    IsEmptySlot := Slot.GetIsEmptySlot();
                    if(not IsEmptySlot?) {
                        ItemId := Slot.GetAcceptedItemId();
                        ItemQuantity := Slot.GetQuantity();
                        ItemPriceKg := GetPrice(ItemId);
                        TempMoney := ItemPriceKg * ItemQuantity;
                        if(TempMoneyConverted := Int[TempMoney]) {
                            set TempMoneyEnd += TempMoneyConverted;
                            Slot.EmptySlot();
                        }
                    }
                }

                if(TempMoneyEnd <> 0) {
                    PlayerBaseManager := GameManagerDev.GetBaseManagerDevice(Agent);
                    PlayerRebirthCounter := PlayerBaseManager.GetRebirthCounter() * 1.0;
                    PlayerPetBonus := PlayerBaseManager.GetPetBonus();
                    PlayerTrailBonus := PlayerBaseManager.GetTrailBonus();
                    if(PlayerRebirthCounter > 0.0, BoostedAmountMoney := Int[TempMoneyEnd * (1.0 + (PlayerRebirthCounter * 0.05))]) {
                        set TempMoneyEnd = BoostedAmountMoney;
                    }

                    if(PlayerPetBonus > 0.0, BoostedAmountMoney := Int[TempMoneyEnd * (1.0 + PlayerPetBonus)]) {
                        set TempMoneyEnd = BoostedAmountMoney;
                    }

                    if(PlayerTrailBonus > 0.0, BoostedAmountMoney := Int[TempMoneyEnd * (1.0 + PlayerTrailBonus)]) {
                        set TempMoneyEnd = BoostedAmountMoney;
                    }

                    SellXP.Award(Agent);
                    PlayerBaseManager.AddXp(5);
                    PlayerBaseManager.AddMoney(TempMoneyEnd);
                    HudMessage.SetText(ToMessage(ToString(TempMoneyEnd)));
                    HudMessage.Show(Agent);
                    
                    if(CurrentPlayer := player[Agent]) {
                        PlayerBaseManager.SaveData(CurrentPlayer);
                    }
                }
            }
        }
