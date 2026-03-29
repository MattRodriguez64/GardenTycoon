
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

RebirthShopTrailItem := class :
    @editable Price : int = 0;
    @editable VFX : visual_effect_powerup_device = visual_effect_powerup_device{};
    @editable Button : button_device = button_device{};

    GetButton<public>() : button_device = return Self.Button;

CosmeticsManager := class(creative_device):

    @editable GameManagerDev : GameManager = GameManager{};
    @editable TrailItem1 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem2 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem3 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem4 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem5 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem6 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem7 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem8 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable TrailItem9 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable CustomizationXP : accolades_device = accolades_device{};

    @editable SunTrail1 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable DataSaveManagerDev : DataSaveManager = DataSaveManager{};

    @editable SquidTrail1 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable SquidTrail2 : RebirthShopTrailItem = RebirthShopTrailItem{};
    @editable SquidTrail3 : RebirthShopTrailItem = RebirthShopTrailItem{};

    @editable RemoveTrailButton : button_device = button_device{};
    @editable RemoveTrailVFX : visual_effect_powerup_device = visual_effect_powerup_device{};

    OnBegin<override>()<suspends>:void=
        Print(">CosmeticsManager");
        TrailItem1.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail1);
        TrailItem2.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail2);
        TrailItem3.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail3);
        TrailItem4.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail4);
        TrailItem5.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail5);
        TrailItem6.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail6);
        TrailItem7.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail7);
        TrailItem8.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail8);
        TrailItem9.GetButton().InteractedWithEvent.Subscribe(OnBuyTrail9);
        SunTrail1.GetButton().InteractedWithEvent.Subscribe(OnBuySunTrail);
        SquidTrail1.GetButton().InteractedWithEvent.Subscribe(OnBuySquidTrail1);
        SquidTrail2.GetButton().InteractedWithEvent.Subscribe(OnBuySquidTrail2);
        SquidTrail3.GetButton().InteractedWithEvent.Subscribe(OnBuySquidTrail3);
        RemoveTrailButton.InteractedWithEvent.Subscribe(OnRemoveTrail);

    OnBuyTrail1(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem1.Price);
        if(CanBuy?) {
            TrailItem1.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail2(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem2.Price);
        if(CanBuy?) {
            TrailItem2.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail3(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem3.Price);
        if(CanBuy?) {
            TrailItem3.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail4(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem4.Price);
        if(CanBuy?) {
            TrailItem4.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail5(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem5.Price);
        if(CanBuy?) {
            TrailItem5.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail6(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem6.Price);
        if(CanBuy?) {
            TrailItem6.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail7(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem7.Price);
        if(CanBuy?) {
            TrailItem7.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail8(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem8.Price);
        if(CanBuy?) {
            TrailItem8.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuyTrail9(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        CanBuy := BaseMPlayer.CanBuyItemRebirth(TrailItem9.Price);
        if(CanBuy?) {
            TrailItem9.VFX.Pickup(Agent);
            CustomizationXP.Award(Agent);
        }

    OnBuySunTrail(Agent : agent) : void =
        var IsAlreadySaved : logic = false;
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);

        var CanBuy : logic = BaseMPlayer.CanBuyItemSun(SunTrail1.Price);
        if(CurrentPlayer := BaseMPlayer.CurrentPlayer?) {
            GetPlayerSave := DataSaveManagerDev.GetPlayerData(CurrentPlayer);
            if(GetPlayerSave.TrailsBought.Length > 0) {
                if(GetPlayerSave.TrailsBought.Find[1] > -1) {
                    set IsAlreadySaved = true;
                    set CanBuy = true;
                }
            }

            if(CanBuy?) {
                SunTrail1.VFX.Pickup(Agent);
                CustomizationXP.Award(Agent);
                BaseMPlayer.SetTrailBonus(0.15);

                if(not IsAlreadySaved?) {
                    BaseMPlayer.WithdrawSun(SunTrail1.Price);
                    BaseMPlayer.GetStatisticTrackerClass().AddTrailsBought(1);
                }

                BaseMPlayer.SaveData(CurrentPlayer);
            }
        }
    
    OnRemoveTrail(Agent : agent) : void =
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);
        RemoveTrailVFX.Pickup(Agent);

        HasTrailBonus := BaseMPlayer.GetTrailBonus();
        if(HasTrailBonus > 0.0) {
            BaseMPlayer.SetTrailBonus(0.0);
        }

    OnBuySquidTrail1(Agent : agent) : void =
        var IsAlreadySaved : logic = false;
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);

        var CanBuy : logic = BaseMPlayer.CanBuyItemSquidCoin(SquidTrail1.Price);
        if(CurrentPlayer := BaseMPlayer.CurrentPlayer?) {
            GetPlayerSave := DataSaveManagerDev.GetPlayerData(CurrentPlayer);
            if(GetPlayerSave.TrailsBought.Length > 0) {
                if(GetPlayerSave.TrailsBought.Find[2] > -1) {
                    set IsAlreadySaved = true;
                    set CanBuy = true;
                }
            }

            if(CanBuy?) {
                SquidTrail1.VFX.Pickup(Agent);
                CustomizationXP.Award(Agent);
                BaseMPlayer.SetTrailBonus(0.1);

                if(not IsAlreadySaved?) {
                    BaseMPlayer.WithdrawSquidCoin(SquidTrail1.Price);
                    BaseMPlayer.GetStatisticTrackerClass().AddTrailsBought(2);
                }

                BaseMPlayer.SaveData(CurrentPlayer);
            }
        }

    OnBuySquidTrail2(Agent : agent) : void =
        var IsAlreadySaved : logic = false;
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);

        var CanBuy : logic = BaseMPlayer.CanBuyItemSquidCoin(SquidTrail2.Price);
        if(CurrentPlayer := BaseMPlayer.CurrentPlayer?) {
            GetPlayerSave := DataSaveManagerDev.GetPlayerData(CurrentPlayer);
            if(GetPlayerSave.TrailsBought.Length > 0) {
                if(GetPlayerSave.TrailsBought.Find[3] > -1) {
                    set IsAlreadySaved = true;
                    set CanBuy = true;
                }
            }

            if(CanBuy?) {
                SquidTrail2.VFX.Pickup(Agent);
                CustomizationXP.Award(Agent);
                BaseMPlayer.SetTrailBonus(0.13);

                if(not IsAlreadySaved?) {
                    BaseMPlayer.WithdrawSquidCoin(SquidTrail2.Price);
                    BaseMPlayer.GetStatisticTrackerClass().AddTrailsBought(3);
                }

                BaseMPlayer.SaveData(CurrentPlayer);
            }
        }

    OnBuySquidTrail3(Agent : agent) : void =
        var IsAlreadySaved : logic = false;
        BaseMPlayer := GameManagerDev.GetBaseManagerDevice(Agent);

        var CanBuy : logic = BaseMPlayer.CanBuyItemSquidCoin(SquidTrail3.Price);
        if(CurrentPlayer := BaseMPlayer.CurrentPlayer?) {
            GetPlayerSave := DataSaveManagerDev.GetPlayerData(CurrentPlayer);
            if(GetPlayerSave.TrailsBought.Length > 0) {
                if(GetPlayerSave.TrailsBought.Find[4] > -1) {
                    set IsAlreadySaved = true;
                    set CanBuy = true;
                }
            }

            if(CanBuy?) {
                SquidTrail3.VFX.Pickup(Agent);
                CustomizationXP.Award(Agent);
                BaseMPlayer.SetTrailBonus(0.15);

                if(not IsAlreadySaved?) {
                    BaseMPlayer.WithdrawSquidCoin(SquidTrail3.Price);
                    BaseMPlayer.GetStatisticTrackerClass().AddTrailsBought(4);
                }

                BaseMPlayer.SaveData(CurrentPlayer);
            }
        }

        
