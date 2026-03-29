
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Assets }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
########################################################################
### - BASE MANAGER CLASS
########################################################################
### - AUTHOR/OWNER : MATT RODRIGUEZ (matt.rodriguez64600@gmail.com)
### - DATE : 20/03/2025
### - VERSION : 1.0
### - PUBLICATIONS : (1er, --/--/2025)
########################################################################

BaseManager := class(creative_device):
    #######################################
    ### - BASE MANAGER SETUP - VARIABLES
    #######################################

    @editable Id : int = -1;
    @editable GameManagerDevice : GameManager = GameManager{};
    @editable CTS_Team1 : class_and_team_selector_device = class_and_team_selector_device{}
    @editable PlayerRef : player_reference_device = player_reference_device{};
    var CurrentPlayerTeam : ?team = false;
    var CurrentPlayer : ?player = false;
    var IsJustRebirth : logic = false;
    @editable ClaimXP : accolades_device = accolades_device{};
    @editable PurchaseXP : accolades_device = accolades_device{};
    @editable PetManagerDev : PetsManager = PetsManager{};
    ### NO MONEY
    @editable Audio_NoMoney : audio_player_device = audio_player_device{};
    ### BUY
    @editable Audio_Buy : audio_player_device = audio_player_device{};
    ### PLAYER LEVEL
    var PlayerLevelClass : PlayerLevel = PlayerLevel{};
    ### SAVE DATA
    @editable DataSaveManagerClass : DataSaveManager = DataSaveManager{};
    ### STATS TRACKER
    var StatisticTrackerClass : StatisticTracker = StatisticTracker{};
    ### UTIL
    UtilsClass : Utils = Utils{};
    ### TASK
    var CancelTask : logic = false;
    ### REBIRTH
    @editable BillboardRebirth : billboard_device = billboard_device{};
    var PurchasesNeededToRebirth : int = 176;
    @editable RebirthButton : button_device = button_device{};
    @editable RebirthHud : hud_message_device = hud_message_device{};
    ### DATAS
    @editable Data_Claim : analytics_device = analytics_device{};
    @editable Data_Rebirth : analytics_device = analytics_device{};
    ### CROP XP
    @editable CollectXP : accolades_device = accolades_device{};
    ### PET BONUS
    var PetBonus : float = 0.0;
    ### TRAIL BONUS
    var TrailBonus : float = 0.0;
    ### AUTO FARM
    @editable SignalRemoteGranter : item_granter_device = item_granter_device{};
    @editable SignalRemoteAutoFarm : signal_remote_manager_device = signal_remote_manager_device{};

    ### MONEY
    var CurrentMoneyAccount : int = 40;
    var Bonus : float = 0.0;
    var RebirthCounter : int = 0;
    var PropertyRevenue : int = 0;
    var CurrentSunAccount : int = 0;
    var CurrentSquidCoinAccount : int = 0;

    # PAINT PLOT / GIFT
    var ColorPickerClass : ColorPicker = ColorPicker{};
    @editable ColorPlotButton : button_device = button_device{};
    @editable GiftBoxRewardXP : accolades_device = accolades_device{};
    var ChestClaimedArr : []logic = array{false, false, false, false, false, false, false, false, false, false, false, false};
    @editable GiftBoxTimer : timer_device = timer_device{};
    @editable GiftButton : button_device = button_device{};

    # PURCHASES
    var JustBoughtUpgrade : logic = false;
    var AllTycoonPurchaseArray : []TycoonPurchase = array{};
    @editable Claim : TycoonPurchase = TycoonPurchase{};

    @editable CarrotPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeCarrots : TycoonPurchase = TycoonPurchase{};
    @editable CarrotsUpgradesArr : []TycoonPurchase = array{};

    @editable PotatoPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradePotatoes : TycoonPurchase = TycoonPurchase{};
    @editable PotatoesUpgradesArr : []TycoonPurchase = array{};

    @editable TomatoPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeTomatoes : TycoonPurchase = TycoonPurchase{};
    @editable TomatoesUpgradesArr : []TycoonPurchase = array{};

    @editable WheatPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeWheats : TycoonPurchase = TycoonPurchase{};
    @editable WheatsUpgradesArr : []TycoonPurchase = array{};

    @editable PumpkinPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradePumpkins : TycoonPurchase = TycoonPurchase{};
    @editable PumpkinsUpgradesArr : []TycoonPurchase = array{};

    @editable BananaPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeBananas : TycoonPurchase = TycoonPurchase{};
    @editable BananasUpgradesArr : []TycoonPurchase = array{};

    @editable WatermelonPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeWatermelons : TycoonPurchase = TycoonPurchase{};
    @editable WatermelonsUpgradesArr : []TycoonPurchase = array{};

    @editable AvocadoPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeAvocados : TycoonPurchase = TycoonPurchase{};
    @editable AvocadosUpgradesArr : []TycoonPurchase = array{};

    @editable LemonPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeLemons : TycoonPurchase = TycoonPurchase{};
    @editable LemonsUpgradesArr : []TycoonPurchase = array{};

    @editable DragonFruitPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradeDragonFruits : TycoonPurchase = TycoonPurchase{};
    @editable DragonFruitsUpgradesArr : []TycoonPurchase = array{};

    ### PEACHES
    @editable PeachPlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradePeaches : TycoonPurchase = TycoonPurchase{};
    @editable PeachesUpgradesArr : []TycoonPurchase = array{};

    ### PINEAPPLES
    @editable PineapplePlotFarming : PlotFarming = PlotFarming{};
    var NextUpgradePineapples : TycoonPurchase = TycoonPurchase{};
    @editable PineapplesUpgradesArr : []TycoonPurchase = array{};

    ### TUTORIAL
    var IsTutorialActive : logic = false;
    @editable TutoStep1Hud : hud_message_device = hud_message_device{};
    @editable TutoStep1Device : mutator_zone_device = mutator_zone_device{};

    @editable TutoStep2Hud : hud_message_device = hud_message_device{};
    @editable TutoStep2Device : timer_device = timer_device{};

    @editable TutoStep3Hud : hud_message_device = hud_message_device{};
    @editable TutoStep3Device : button_device = button_device{};

    @editable TutoStep4Hud : hud_message_device = hud_message_device{};
    @editable TutoMapIndicator : map_indicator_device = map_indicator_device{};

    @editable TutoButton : button_device = button_device{};

    IsStartingTutorial(Player : player) : void =
        TutoUI : TutorialUI = TutorialUI{BaseManagerDev := Self};
        TutoUI.AddUI(Player);

    OnRestartTuto(Agent : agent) : void =
        if(GetPlayer := CurrentPlayer?) {
            IsStartingTutorial(GetPlayer);
        }

    OnStartTutorial() : void =
        if(GetPlayer := CurrentPlayer?, GetAgent := agent[GetPlayer]) {
            set IsTutorialActive = true;
            TutoStep1Hud.Show(GetAgent);
        } 

    OnTutoStep1Ended(Agent : agent) : void =  # MUTATOR
        IsOwnerResult := IsOwner(Agent);
        if(not IsOwnerResult?) { return; }

        if(not IsTutorialActive?) { return; }

        if(GetPlayer := CurrentPlayer?, GetAgent := agent[GetPlayer]) {
            TutoStep1Hud.Hide(GetAgent);
            TutoStep2Device.Start(GetAgent);
            TutoStep2Hud.Show(GetAgent);
        }

    OnTutoStep2Ended(Agent : ?agent) : void = # TIMER
        if(not IsTutorialActive?) { return; }
        if(GetPlayer := CurrentPlayer?, GetAgent := agent[GetPlayer]) {
            TutoStep2Hud.Hide(GetAgent);
            TutoStep3Hud.Show(GetAgent);
            TutoMapIndicator.Enable();
            for(X := 0..20) {
                TutoMapIndicator.ActivateObjectivePulse(GetAgent);
            } 
        }

    OnTutoStep3Ended(Agent : agent) : void = # BUTTON
        IsOwnerResult := IsOwner(Agent);
        if(not IsOwnerResult?) { return; }
        
        if(not IsTutorialActive?) { return; }

        if(GetPlayer := CurrentPlayer?, GetAgent := agent[GetPlayer]) {
            TutoStep3Hud.Hide(GetAgent);
            set IsTutorialActive = false;
            TutoStep4Hud.Show(GetAgent);
            TutoMapIndicator.Enable();
            for(X := 0..20) {
                TutoMapIndicator.DeactivateObjectivePulse(GetAgent);
            }
        }

    OnBegin<override>()<suspends>:void=
        Print(">BaseManager : ON BEGIN");
        ### TUTORIAL
        # STEP 1
        TutoStep1Device.AgentEntersEvent.Subscribe(OnTutoStep1Ended);
        # STEP 2
        TutoStep2Device.SuccessEvent.Subscribe(OnTutoStep2Ended);
        # STEP 3
        TutoStep3Device.InteractedWithEvent.Subscribe(OnTutoStep3Ended);
        # TUTO BUTTON
        TutoButton.InteractedWithEvent.Subscribe(OnRestartTuto);
        ### CLAIM
        Claim.GetMutator().AgentEntersEvent.Subscribe(OnPlayerClaim);
        ### COLOR PICKER
        ColorPickerClass.AddWalls(array{Claim});
        ColorPlotButton.InteractedWithEvent.Subscribe(OnPlayerColorPlot);
        ### GIFT
        GiftButton.InteractedWithEvent.Subscribe(OnPlayerOpenGift);
        ### REBIRTH
        RebirthButton.InteractedWithEvent.Subscribe(OnPlayerRebirth);
        RebirthButton.Disable();
        ### AUTO FARM
        SignalRemoteAutoFarm.PrimarySignalEvent.Subscribe(OnAutoFarmUI);
        ### CARROTS
        for(Index := 0..CarrotsUpgradesArr.Length-1) {
            if(CurrentUpgrade := CarrotsUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerCarrotUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > CarrotsUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := CarrotsUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        CarrotPlotFarming.SetItemImage(UI.CarrotImage);
        if(CurrentUpgrade := CarrotsUpgradesArr[0]) {
            set NextUpgradeCarrots = CurrentUpgrade;
        }

        ### POTATOES
        for(Index := 0..PotatoesUpgradesArr.Length-1) {
            if(CurrentUpgrade := PotatoesUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerPotatoUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > PotatoesUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := PotatoesUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        PotatoPlotFarming.SetItemImage(UI.PotatoImage);
        if(CurrentUpgrade := PotatoesUpgradesArr[0]) {
            set NextUpgradePotatoes = CurrentUpgrade;
            NextUpgradeCarrots.AddNextPurchases(array{CurrentUpgrade});
        }

        ### TOMATOES
        for(Index := 0..TomatoesUpgradesArr.Length-1) {
            if(CurrentUpgrade := TomatoesUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerTomatoUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > TomatoesUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := TomatoesUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        TomatoPlotFarming.SetItemImage(UI.TomatoImage);
        if(CurrentUpgrade := TomatoesUpgradesArr[0]) {
            set NextUpgradeTomatoes = CurrentUpgrade;
            NextUpgradePotatoes.AddNextPurchases(array{CurrentUpgrade});
        }


        ### WHEATS
        for(Index := 0..WheatsUpgradesArr.Length-1) {
            if(CurrentUpgrade := WheatsUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerWheatUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > WheatsUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := WheatsUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        WheatPlotFarming.SetItemImage(UI.WheatImage);
        if(CurrentUpgrade := WheatsUpgradesArr[0]) {
            set NextUpgradeWheats = CurrentUpgrade;
            NextUpgradeTomatoes.AddNextPurchases(array{CurrentUpgrade});
        }

        ### PUMPKINS
        for(Index := 0..PumpkinsUpgradesArr.Length-1) {
            if(CurrentUpgrade := PumpkinsUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerPumpkinUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > PumpkinsUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := PumpkinsUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        PumpkinPlotFarming.SetItemImage(UI.PumpkinImage);
        if(CurrentUpgrade := PumpkinsUpgradesArr[0]) {
            set NextUpgradePumpkins = CurrentUpgrade;
            NextUpgradeWheats.AddNextPurchases(array{CurrentUpgrade});
        }

        ### PEACHES
        for(Index := 0..PeachesUpgradesArr.Length-1) {
            if(CurrentUpgrade := PeachesUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerPeachUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > PeachesUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := PeachesUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        PeachPlotFarming.SetItemImage(UI.PeachImage);
        if(CurrentUpgrade := PeachesUpgradesArr[0]) {
            set NextUpgradePeaches = CurrentUpgrade;
            NextUpgradePumpkins.AddNextPurchases(array{CurrentUpgrade});
        }


        ### BANANAS
        for(Index := 0..BananasUpgradesArr.Length-1) {
            if(CurrentUpgrade := BananasUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerBananaUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > BananasUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := BananasUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        BananaPlotFarming.SetItemImage(UI.BananaImage);
        if(CurrentUpgrade := BananasUpgradesArr[0]) {
            set NextUpgradeBananas = CurrentUpgrade;
            NextUpgradePumpkins.AddNextPurchases(array{CurrentUpgrade});
        }

        ### PINEAPPLES
        for(Index := 0..PineapplesUpgradesArr.Length-1) {
            if(CurrentUpgrade := PineapplesUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerPineappleUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > PineapplesUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := PineapplesUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        PineapplePlotFarming.SetItemImage(UI.PineappleImage);
        if(CurrentUpgrade := PineapplesUpgradesArr[0]) {
            set NextUpgradePineapples = CurrentUpgrade;
            NextUpgradeBananas.AddNextPurchases(array{CurrentUpgrade});
        }

        ### WATERMELONS
        for(Index := 0..WatermelonsUpgradesArr.Length-1) {
            if(CurrentUpgrade := WatermelonsUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerWatermelonUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > WatermelonsUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := WatermelonsUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        WatermelonPlotFarming.SetItemImage(UI.WatermelonImage);
        if(CurrentUpgrade := WatermelonsUpgradesArr[0]) {
            set NextUpgradeWatermelons = CurrentUpgrade;
            NextUpgradeBananas.AddNextPurchases(array{CurrentUpgrade});
        }

        ### AVOCADOS
        for(Index := 0..AvocadosUpgradesArr.Length-1) {
            if(CurrentUpgrade := AvocadosUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerAvocadoUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > AvocadosUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := AvocadosUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        AvocadoPlotFarming.SetItemImage(UI.AvocadoImage);
        if(CurrentUpgrade := AvocadosUpgradesArr[0]) {
            set NextUpgradeAvocados = CurrentUpgrade;
            NextUpgradeWatermelons.AddNextPurchases(array{CurrentUpgrade});
        }

        ### LEMONS
        for(Index := 0..LemonsUpgradesArr.Length-1) {
            if(CurrentUpgrade := LemonsUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerLemonUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > LemonsUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := LemonsUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        LemonPlotFarming.SetItemImage(UI.LemonImage);
        if(CurrentUpgrade := LemonsUpgradesArr[0]) {
            set NextUpgradeLemons = CurrentUpgrade;
            NextUpgradeAvocados.AddNextPurchases(array{CurrentUpgrade});
        }

        ### DRAGONFRUITS
        for(Index := 0..DragonFruitsUpgradesArr.Length-1) {
            if(CurrentUpgrade := DragonFruitsUpgradesArr[Index]) {
                CurrentUpgrade.GetMutator().AgentEntersEvent.Subscribe(OnPlayerDragonFruitUpgrade);
                CurrentUpgrade.GetMutator().AgentExitsEvent.Subscribe(OnPlayerExitUpgrade);
                if(Index + 1 > DragonFruitsUpgradesArr.Length-1) {
                    CurrentUpgrade.SetNextPurchasesArray(array{});
                } else {
                    if(NextUpgrade := DragonFruitsUpgradesArr[Index + 1]) {
                        CurrentUpgrade.SetNextPurchasesArray(array{NextUpgrade});
                    }
                }
                set AllTycoonPurchaseArray += array{CurrentUpgrade};
            }
        }
        DragonFruitPlotFarming.SetItemImage(UI.DragonFruitImage);
        if(CurrentUpgrade := DragonFruitsUpgradesArr[0]) {
            set NextUpgradeDragonFruits = CurrentUpgrade;
            NextUpgradeLemons.AddNextPurchases(array{CurrentUpgrade});
        }

        ### CARROTS
        CarrotPlotFarming.SetGameManagerDev(GameManagerDevice)
        CarrotPlotFarming.Init();
        ### POTATOES
        PotatoPlotFarming.SetGameManagerDev(GameManagerDevice)
        PotatoPlotFarming.Init();
        ### TOMATOES
        TomatoPlotFarming.SetGameManagerDev(GameManagerDevice)
        TomatoPlotFarming.Init();
        ### WHEATS
        WheatPlotFarming.SetGameManagerDev(GameManagerDevice)
        WheatPlotFarming.Init();
        ### PUMPKINS
        PumpkinPlotFarming.SetGameManagerDev(GameManagerDevice)
        PumpkinPlotFarming.Init();
        ### BANANAS
        BananaPlotFarming.SetGameManagerDev(GameManagerDevice)
        BananaPlotFarming.Init();
        ### WATERMELONS
        WatermelonPlotFarming.SetGameManagerDev(GameManagerDevice)
        WatermelonPlotFarming.Init();
        ### AVOCADOS
        AvocadoPlotFarming.SetGameManagerDev(GameManagerDevice)
        AvocadoPlotFarming.Init();
        ### LEMONS
        LemonPlotFarming.SetGameManagerDev(GameManagerDevice)
        LemonPlotFarming.Init();
        ### DRAGON FRUITS
        DragonFruitPlotFarming.SetGameManagerDev(GameManagerDevice)
        DragonFruitPlotFarming.Init();
        ### PEACHES
        PeachPlotFarming.SetGameManagerDev(GameManagerDevice)
        PeachPlotFarming.Init();
        ### PINEAPPLES
        PineapplePlotFarming.SetGameManagerDev(GameManagerDevice)
        PineapplePlotFarming.Init();

        Claim.SetNextPurchasesArray(array{NextUpgradeCarrots});
        ResetPlot(false);
        
    ToMessage<localizes>(String : string) : message = "{String}";

    OnAutoFarmUI(Agent : agent) : void =
        if(TemPlayer := player[Agent], PlayerBaseM := CurrentPlayer?, TemPlayer = PlayerBaseM) {
            TempAutoFarmUI := AutoFarmUI{BaseManagerDev := Self};
            TempAutoFarmUI.AddUI(Agent);
        }

    OnAutoFarm(Agent : agent) : void =
        for(Plot : array{DragonFruitPlotFarming, LemonPlotFarming, AvocadoPlotFarming, WatermelonPlotFarming, BananaPlotFarming, PeachPlotFarming, PineapplePlotFarming,
        CarrotPlotFarming, PotatoPlotFarming, TomatoPlotFarming, WheatPlotFarming, PumpkinPlotFarming}) {
            Plot.CollectAllFarmingCrop(Agent);
        }

    OnAutoFarmExceptRares(Agent : agent) : void =
        for(Plot : array{DragonFruitPlotFarming, LemonPlotFarming, AvocadoPlotFarming, WatermelonPlotFarming, BananaPlotFarming, PeachPlotFarming, PineapplePlotFarming,
        CarrotPlotFarming, PotatoPlotFarming, TomatoPlotFarming, WheatPlotFarming, PumpkinPlotFarming}) {
            Plot.CollectAllFarmingCropExceptRares(Agent);
        }

    GetFruitImage<public>(Index : int) : texture =
        var TempIndex : int = Index - 1;
        if(Index > -1) {
            if(TempIndex = 99) { ### 100 - 1
                set TempIndex = 12;
            } else if(TempIndex = 49) { ### 50 - 1
                set TempIndex = 13;
            } else if(TempIndex = 74) { ### 75 - 1
                set TempIndex = 14;
            }

            if(TempImage := array{UI.CarrotImage, UI.PotatoImage, UI.TomatoImage, UI.WheatImage, UI.PumpkinImage, 
            UI.BananaImage, UI.WatermelonImage, UI.AvocadoImage, UI.LemonImage, UI.DragonFruitImage, UI.PeachImage, UI.PineappleImage, UI.RainbowItem, UI.SunItem, UI.SquidItem}[TempIndex]) {
                return TempImage;
            }
        }
        return UI.EmptySlotImage;

    OnPlayerRebirth(Agent : agent) : void =
        ResetPlot(true);
        set RebirthCounter += 1;
        StatisticTrackerClass.IncrementRebirthCounter();

        TempPopUpRebirthUI : PopUpRebirthUI = PopUpRebirthUI{};
        TempPopUpRebirthUI.Initialize(Agent, RebirthCounter);

        if(Player := player[Agent]) {
            SaveData(Player);
        }

        Data_Rebirth.Submit(Agent);

    ResetAllFarmingPlots<private>() : void =
        for(Plot : array{CarrotPlotFarming, PotatoPlotFarming, TomatoPlotFarming, WheatPlotFarming, PumpkinPlotFarming, PeachPlotFarming, PineapplePlotFarming,
        BananaPlotFarming, WatermelonPlotFarming, AvocadoPlotFarming, LemonPlotFarming, DragonFruitPlotFarming}) {
            Plot.EndBoostGrowingTime();
            Plot.DefaultReset();
        }

    ResetAllFarmingPlotsRebirth<private>() : void =
        for(Plot : array{CarrotPlotFarming, PotatoPlotFarming, TomatoPlotFarming, WheatPlotFarming, PumpkinPlotFarming, PeachPlotFarming, PineapplePlotFarming,
        BananaPlotFarming, WatermelonPlotFarming, AvocadoPlotFarming, LemonPlotFarming, DragonFruitPlotFarming}) {
            Plot.RebirthReset();
        }

    GetAllFarmingPlotsRainbow<private>() : void =
        var TempArray : []tuple(int, int) = array{};
        for(Plot : array{CarrotPlotFarming, PotatoPlotFarming, TomatoPlotFarming, WheatPlotFarming, PumpkinPlotFarming, PeachPlotFarming, PineapplePlotFarming,
        BananaPlotFarming, WatermelonPlotFarming, AvocadoPlotFarming, LemonPlotFarming, DragonFruitPlotFarming}) {
            PlotRainbowCrops := Plot.GetAllRainbowCrops();
            if(PlotRainbowCrops.Length > 0) {
                set TempArray = Concatenate(TempArray, PlotRainbowCrops);
            }
        }

        StatisticTrackerClass.SetRainbowCrops(TempArray);
          
    ResetPlot(IsRebirth : logic) : void =
        #Print(">ResetPlot");
        for(TycoonPurchaseUnit : AllTycoonPurchaseArray) {
            TycoonPurchaseUnit.HideAllProps();
            TycoonPurchaseUnit.DisablePurchase();
        }
        ### CLAIM
        Claim.HideAllProps();
        Claim.EnablePurchase();

        set CurrentMoneyAccount = 40;
        ### RESET COLOR PICKER
        ColorPickerClass.Reset();

        CarrotPlotFarming.SetPropsInvisible();
        PotatoPlotFarming.SetPropsInvisible();
        TomatoPlotFarming.SetPropsInvisible();
        WheatPlotFarming.SetPropsInvisible();
        PumpkinPlotFarming.SetPropsInvisible();
        BananaPlotFarming.SetPropsInvisible();
        WatermelonPlotFarming.SetPropsInvisible();
        AvocadoPlotFarming.SetPropsInvisible();
        LemonPlotFarming.SetPropsInvisible();
        DragonFruitPlotFarming.SetPropsInvisible();
        PeachPlotFarming.SetPropsInvisible();
        PineapplePlotFarming.SetPropsInvisible();

        SetNextUpgrade(1, 0);
        SetNextUpgrade(2, 0);
        SetNextUpgrade(3, 0);
        SetNextUpgrade(4, 0);
        SetNextUpgrade(5, 0);
        SetNextUpgrade(6, 0);
        SetNextUpgrade(7, 0);
        SetNextUpgrade(8, 0);
        SetNextUpgrade(9, 0);
        SetNextUpgrade(10, 0);
        SetNextUpgrade(11, 0);
        SetNextUpgrade(12, 0);

        RebirthButton.Disable();
        
        ColorPickerClass.Reset();
        BillboardRebirth.SetText(ToMessage(" "));
        StatisticTrackerClass.SetPurchasesMade(array{});
        StatisticTrackerClass.SetFarmUpgrades(array{});
        ResetAllFarmingPlotsRebirth();
        if(IsRebirth = false) {
            ResetAllFarmingPlots();
            set PetBonus = 0.0;
            set TrailBonus = 0.0;
            set RebirthCounter = 0;
            set CurrentPlayer = false;
            set CurrentPlayerTeam = false;
            set CurrentSunAccount = 0;
            set CurrentSquidCoinAccount = 0;
            PlayerRef.Clear();
            GiftBoxTimer.Reset();
            set PropertyRevenue = 0;
            set ChestClaimedArr = array{false, false, false, false, false, false, false, false, false, false, false, false};
            set CancelTask = true;
            set StatisticTrackerClass = StatisticTracker{};
            set PlayerLevelClass = PlayerLevel{};
        } else {
            PlayerLevelClass.AddCurrentXp(2500);
            if(TempPlayer := CurrentPlayer?, TempPlayer.IsActive[]) {
                SaveData(TempPlayer);
            }
        }
        set IsJustRebirth = IsRebirth;
        

    IsOwner<public>(Agent : agent) : logic = 
        if(CurrentFort := Agent.GetFortCharacter[], Owner := CurrentPlayer?, OwnerFort := Owner.GetFortCharacter[], CurrentFort <> OwnerFort) {
            return false;
        }
        return true;


    IsSuccessfulBuying(Agent : agent, Value : int, Purchase : TycoonPurchase) : void =
        if(Value = 0) {
            return;
        }

        if(Value = -1) {
            Audio_NoMoney.Play(Agent);
        } else if(Value = 1) {
            PurchaseXP.Award(Agent);
            Audio_Buy.Play(Agent);
            set CurrentMoneyAccount -= Purchase.GetPrice();
            
            StatisticTrackerClass.AddPurchaseMade(Purchase.GetId());
            UpdateBillboardRebirth(Agent);
            PlayerLevelClass.AddCurrentXp(20);
            if(TempPlayer := CurrentPlayer?, TempPlayer.IsActive[]) {
                SaveData(TempPlayer);
            }
        }

    UpdateBillboardRebirth(Agent : agent) : void =
        PurchasesMade := StatisticTrackerClass.GetPurchasesMade().Length ;
        Result := ((PurchasesMade * 1.0) / (PurchasesNeededToRebirth * 1.0)) * 100.0;
        BillboardRebirth.SetText(ToMessage("{Result}%"));
        if(PurchasesMade >= PurchasesNeededToRebirth) {
            RebirthButton.Enable();
            RebirthHud.Show(Agent);
        }

    OnPlayerColorPlot(Agent : agent) : void =
        IsOwnerResult := IsOwner(Agent);
        if(IsOwnerResult?) {
            NewColorPickerUI : ColorPickerUI = ColorPickerUI{
                ColorPickerClass := ColorPickerClass, 
                CurrentRebirthCount := RebirthCounter,
                BaseManagerDev := Self
                };
            NewColorPickerUI.AddUI(Agent);
        }


    #######################################
    ### - PLAYER CLAIM
    #######################################
    OnPlayerClaim(Agent : agent) : void =
        Print(">BaseManager : OnPlayerClaim");
        if(IsJustRebirth = true) {
            if(CurrentFort := Agent.GetFortCharacter[], Owner := CurrentPlayer?, OwnerFort := Owner.GetFortCharacter[], CurrentFort <> OwnerFort) {
                return;
            }
        }

        if(Player := player[Agent], (CurrentPlayer = false) or (IsJustRebirth = true)) {
            if(GameManagerDevice.CheckIsPlayerHasPlot(Player) = true and IsJustRebirth = false) {
                Print(">BaseManager : PLAYER ALREADY HAVE A PLOT !");
            } else {
                Print(">BaseManager : PLAYER ADDED TO THE PLAYER !");
                ### CHECK IS FIRST CLAIM
                if(not GameManagerDevice.CheckIsPlayerHasPlot(Player)?) {
                    set IsJustRebirth = false;
                }

                PlayerRef.Register(Agent);
                IsBuying := Claim.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, false);
                IsSuccessfulBuying(Agent, IsBuying, Claim);
                ClaimXP.Award(Agent);
                GiftBoxTimer.Start();

                if(IsJustRebirth = false) {
                    SignalRemoteGranter.GrantItem(Agent);
                    set CurrentPlayerTeam = GameManagerDevice.GetPlayerTeam(Agent);
                    GameManagerDevice.AddPlayerPlot(Player);
                    set CurrentPlayer = option{Player};
                    set CancelTask = false;
                    Player.InitUI();
                    ### CARROTS
                    CarrotPlotFarming.SetOwnerPlayer(option{Player});
                    ### POTATOES
                    PotatoPlotFarming.SetOwnerPlayer(option{Player});
                    ### TOMATOES
                    TomatoPlotFarming.SetOwnerPlayer(option{Player});
                    ### WHEATS
                    WheatPlotFarming.SetOwnerPlayer(option{Player});
                    ### PUMPKINS
                    PumpkinPlotFarming.SetOwnerPlayer(option{Player});
                    ### BANANAS
                    BananaPlotFarming.SetOwnerPlayer(option{Player});
                    ### WATERMELONS
                    WatermelonPlotFarming.SetOwnerPlayer(option{Player});
                    ### AVOCADOS
                    AvocadoPlotFarming.SetOwnerPlayer(option{Player});
                    ### LEMONS
                    LemonPlotFarming.SetOwnerPlayer(option{Player});
                    ### DRAGON FRUITS
                    DragonFruitPlotFarming.SetOwnerPlayer(option{Player});
                    ### PEACHES
                    PeachPlotFarming.SetOwnerPlayer(option{Player});
                    ### PINEAPPLES
                    PineapplePlotFarming.SetOwnerPlayer(option{Player});
                    ### PLAYER LEVEL
                    PlayerLevelClass.SetAgent(Agent);
                    PlayerLevelClass.SetPlayerUI();
                    CTS_Team1.ChangeTeam(Agent);
                    ### CHECK PLAYER SAVED DATA
                    CheckSavedData(Player);
                    StatisticTrackerClass.IncrementLoginCounter();
                }
                ### DATA
                Data_Claim.Submit(Agent);
            }
        }

    CheckSavedData(Player : player) : void =
        DataSaveManagerClass.CheckDataPlayer(Player);
        CurrentDataPlayer := DataSaveManagerClass.GetPlayerData(Player);

        if(CurrentDataPlayer.LoginCounter > 0) {
            LoadSavedData(Player);
        #     NewLoadSavedDataUI : LoadSavedDataUI = LoadSavedDataUI{BaseManagerDev := Self};
        #     NewLoadSavedDataUI.AddUI(Player);
        } else {
            ### ASK TO START TUTORIAL
            IsStartingTutorial(Player);
        }

    LoadSavedData(Player : player) : void =
        Print("LoadSavedData");
        DataSaveManagerClass.CheckDataPlayer(Player);
        CurrentDataPlayer := DataSaveManagerClass.GetPlayerData(Player);
        set CurrentMoneyAccount = CurrentDataPlayer.Money;
        set CurrentSunAccount = CurrentDataPlayer.SunMoney;
        set CurrentSquidCoinAccount = CurrentDataPlayer.SquidCoin;
        set RebirthCounter = CurrentDataPlayer.RebirthCounter;
        StatisticTrackerClass.SetPurchasesMade(CurrentDataPlayer.PurchasesMadeArray);
        StatisticTrackerClass.AddLoginCounter(CurrentDataPlayer.LoginCounter);
        StatisticTrackerClass.SetFarmUpgrades(CurrentDataPlayer.FarmUpgradesArray);
        StatisticTrackerClass.SetPetsBought(CurrentDataPlayer.PetsBought);
        StatisticTrackerClass.SetTrailsBought(CurrentDataPlayer.TrailsBought);
        StatisticTrackerClass.SetSunMoney(CurrentDataPlayer.SunMoney);
        StatisticTrackerClass.SetSquidCoin(CurrentDataPlayer.SquidCoin);
        
        ### REBUILD PLOT
        for(Purchase : AllTycoonPurchaseArray) {
            PurchaseId := Purchase.GetId();
            for(SavedPurchase : CurrentDataPlayer.PurchasesMadeArray) {
                if(SavedPurchase = PurchaseId) {
                    if(PurchaseId > 1) {
                        # Print("PurchaseId > 1")
                        IsBuying := Purchase.OnPlayerBuy(Player, 1000000000, CurrentPlayer, true);
                        if(PurchaseId = 25) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 49) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 64) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 88) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 106) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 114) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 132) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 140) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 148) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 151) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 159) {
                            Purchase.DisablePurchase();
                        } else if(PurchaseId = 177) {
                            Purchase.DisablePurchase();
                        }
                        ## TODO : PINEAPPLES
                    }  else {
                        Purchase.OnPlayerBuy(Player, 1000000000, CurrentPlayer, false);
                    }
                }
            }
        }
        UpdateBillboardRebirth(Player);

        ### ENABLE ALL SAVED PLOT FARMING
        AllFarmUpgradesSaved := StatisticTrackerClass.GetFarmUpgrades();
        ### TO DO  : SORT FARM UPGRADES
        AllFarmUpgradesSorted := UtilsClass.BubbleSort(AllFarmUpgradesSaved, AllFarmUpgradesSaved.Length);
        # Print("AllFarmUpgradesSaved : {AllFarmUpgradesSaved.Length}")
        var TempInitId : int = 1;
        var TempLevel : int = 0;
        for(FarmingCropSaved : AllFarmUpgradesSorted) {
            #Print("FarmingCropSaved : {FarmingCropSaved}");
            if(TempInitId <> FarmingCropSaved) {
                set TempLevel = 0;
                set TempInitId = FarmingCropSaved;
            } 

            TempPlotFarming := GetPlotFarming(FarmingCropSaved);
            if(TempPlotFarmingNonNull := TempPlotFarming?) {
                # Print("UnlockAndMakeGrowingFarmingCrops")
                TempPlotFarmingNonNull.UnlockAndMakeGrowingFarmingCrops(TempLevel);
                
                if(CurrentDataPlayer.RainbowCrops.Find[(FarmingCropSaved, TempLevel)] > - 1) {
                    GetFCrop := TempPlotFarmingNonNull.GetFarmingCropsById(TempLevel);
                    if(GetFCropNonNull := GetFCrop?) {
                        #Print("RAINBOW PROP FOUND !");
                        GetFCropNonNull.SetRainbowFarmingCrop();
                    }
                }

                set TempLevel += 1;
                TempPlotFarmingNonNull.SetLevel(TempLevel);
                if(TempPlotFarmingNonNull.FarmingCropArr.Length <> TempLevel) {
                    SetNextUpgrade(TempInitId, TempLevel);
                } 
            }
        }

        ### LOAD INVENTORY DATAS
        CurrentPlayerInv := GameManagerDevice.GetPlayerInventory(Player);
        if(NonNullPlayerInv := CurrentPlayerInv?) {
            if(CurrentDataPlayer.InvSlot1(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(0, CurrentDataPlayer.InvSlot1(0), CurrentDataPlayer.InvSlot1(1), GetFruitImage(CurrentDataPlayer.InvSlot1(0)));
                #Print("CURRENT ID SLOT 1 : {CurrentDataPlayer.InvSlot1(0)}");
            }

            if(CurrentDataPlayer.InvSlot2(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(1, CurrentDataPlayer.InvSlot2(0), CurrentDataPlayer.InvSlot2(1), GetFruitImage(CurrentDataPlayer.InvSlot2(0)));
            }

            if(CurrentDataPlayer.InvSlot3(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(2, CurrentDataPlayer.InvSlot3(0), CurrentDataPlayer.InvSlot3(1), GetFruitImage(CurrentDataPlayer.InvSlot3(0)));
            }

            if(CurrentDataPlayer.InvSlot4(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(3, CurrentDataPlayer.InvSlot4(0), CurrentDataPlayer.InvSlot4(1), GetFruitImage(CurrentDataPlayer.InvSlot4(0)));
            }

            if(CurrentDataPlayer.InvSlot5(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(4, CurrentDataPlayer.InvSlot5(0), CurrentDataPlayer.InvSlot5(1), GetFruitImage(CurrentDataPlayer.InvSlot5(0)));
            }

            if(CurrentDataPlayer.InvSlot6(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(5, CurrentDataPlayer.InvSlot6(0), CurrentDataPlayer.InvSlot6(1), GetFruitImage(CurrentDataPlayer.InvSlot6(0)));
            }

            if(CurrentDataPlayer.InvSlot7(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(6, CurrentDataPlayer.InvSlot7(0), CurrentDataPlayer.InvSlot7(1), GetFruitImage(CurrentDataPlayer.InvSlot7(0)));
            }

            if(CurrentDataPlayer.InvSlot8(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(7, CurrentDataPlayer.InvSlot8(0), CurrentDataPlayer.InvSlot8(1), GetFruitImage(CurrentDataPlayer.InvSlot8(0)));
            }

            if(CurrentDataPlayer.InvSlot9(0) <> 0) {
                NonNullPlayerInv.ReloadInventorySlotContent(8, CurrentDataPlayer.InvSlot9(0), CurrentDataPlayer.InvSlot9(1), GetFruitImage(CurrentDataPlayer.InvSlot9(0)));
            }
        }

        ### GET BACK LEVELS DATAS
        PlayerLevelClass.SetCurrentLevel(CurrentDataPlayer.CurrentLevel);
        PlayerLevelClass.SetCurrentXp(CurrentDataPlayer.CurrentXp);
        PlayerLevelClass.SetNextLevelXpNeeded(CurrentDataPlayer.CurrentNextLevelXpNeeded);

        if(Agent := agent[Player]) {
            PetManagerDev.LoadLastPetSaved(Agent);
        }
        

    SaveData(Player : player) : void =
        ### GENERAL DATAS
        GetAllFarmingPlotsRainbow();
        CurrentMoneyToSave := CurrentMoneyAccount;
        CurrentLoginCounterToSave := StatisticTrackerClass.GetLoginCounter();
        CurrentPurchasesToSave := StatisticTrackerClass.GetPurchasesMade();
        CurrentFarmUpgrades := StatisticTrackerClass.GetFarmUpgrades();
        CurrentRebirthCounterToSave := RebirthCounter;
        CurrentBuildColorBoughtToSave := array{-1};
        CurrentLevelToSave := PlayerLevelClass.GetCurrentLevel();
        CurrentXpToSave := PlayerLevelClass.GetCurrentXp();
        CurrentNextLevelXpNeededToSave := PlayerLevelClass.GetNextLevelXpNeeded();
        CurrentPetsBought := StatisticTrackerClass.GetPetsBought();
        CurrentTrailsBought := StatisticTrackerClass.GetTrailsBought();
        CurrentSunMoney := StatisticTrackerClass.GetSunMoney();
        CurrentSquidCoin := StatisticTrackerClass.GetSquidCoin();
        CurrentRainbowCrops := StatisticTrackerClass.GetRainbowCrops();

        ### INVENTORY DATAS
        CurrentPlayerInv := GameManagerDevice.GetPlayerInventory(Player);
        if(NonNullPlayerInv := CurrentPlayerInv?) {
            CurrentInvSlot1 := NonNullPlayerInv.GetInventorySlotContent(0);
            CurrentInvSlot2 := NonNullPlayerInv.GetInventorySlotContent(1);
            CurrentInvSlot3 := NonNullPlayerInv.GetInventorySlotContent(2);
            CurrentInvSlot4 := NonNullPlayerInv.GetInventorySlotContent(3);
            CurrentInvSlot5 := NonNullPlayerInv.GetInventorySlotContent(4);
            CurrentInvSlot6 := NonNullPlayerInv.GetInventorySlotContent(5);
            CurrentInvSlot7 := NonNullPlayerInv.GetInventorySlotContent(6);
            CurrentInvSlot8 := NonNullPlayerInv.GetInventorySlotContent(7);
            CurrentInvSlot9 := NonNullPlayerInv.GetInventorySlotContent(8);

            DataSaveManagerClass.SaveDataPlayer(
                Player, 
                CurrentMoneyToSave, 
                CurrentLoginCounterToSave, 
                CurrentPurchasesToSave, 
                CurrentFarmUpgrades,
                CurrentRebirthCounterToSave,
                CurrentBuildColorBoughtToSave, 
                CurrentLevelToSave, 
                CurrentXpToSave, 
                CurrentNextLevelXpNeededToSave,
                CurrentInvSlot1,
                CurrentInvSlot2,
                CurrentInvSlot3,
                CurrentInvSlot4,
                CurrentInvSlot5,
                CurrentInvSlot6,
                CurrentInvSlot7,
                CurrentInvSlot8,
                CurrentInvSlot9,
                CurrentPetsBought,
                CurrentTrailsBought,
                CurrentSunMoney,
                CurrentRainbowCrops,
                CurrentSquidCoin);
        }

    GetPlotFarming(PlotId : int) : ?PlotFarming =
        for(Plot : array{CarrotPlotFarming, PotatoPlotFarming, TomatoPlotFarming, WheatPlotFarming, PumpkinPlotFarming, 
        BananaPlotFarming, WatermelonPlotFarming, AvocadoPlotFarming, LemonPlotFarming, DragonFruitPlotFarming, PeachPlotFarming, PineapplePlotFarming}) {
            if(Plot.Id = PlotId) {
                return option{Plot};
            }
        }
        return false;

    SetNextUpgrade(NextUpId : int, Level : int) : void =
        case(NextUpId) {
            1 => {
                if(CurrentUpgrade := CarrotsUpgradesArr[Level]) {
                    set NextUpgradeCarrots = CurrentUpgrade;
                    return;
                }
            }

            2 => {
                if(CurrentUpgrade := PotatoesUpgradesArr[Level]) {
                    set NextUpgradePotatoes = CurrentUpgrade;
                    return;
                }
            }

            3 => {
                if(CurrentUpgrade := TomatoesUpgradesArr[Level]) {
                    set NextUpgradeTomatoes = CurrentUpgrade;
                    return;
                }
            }

            4 => {
                if(CurrentUpgrade := WheatsUpgradesArr[Level]) {
                    set NextUpgradeWheats = CurrentUpgrade;
                    return;
                }
            }

            5 => {
                if(CurrentUpgrade := PumpkinsUpgradesArr[Level]) {
                    set NextUpgradePumpkins = CurrentUpgrade;
                    return;
                }
            }

            6 => {
                if(CurrentUpgrade := BananasUpgradesArr[Level]) {
                    set NextUpgradeBananas = CurrentUpgrade;
                    return;
                }
            }

            7 => {
                if(CurrentUpgrade := WatermelonsUpgradesArr[Level]) {
                    set NextUpgradeWatermelons = CurrentUpgrade;
                    return;
                }
            }

            8 => {
                if(CurrentUpgrade := AvocadosUpgradesArr[Level]) {
                    set NextUpgradeAvocados = CurrentUpgrade;
                    return;
                }
            }

            9 => {
                if(CurrentUpgrade := LemonsUpgradesArr[Level]) {
                    set NextUpgradeLemons = CurrentUpgrade;
                    return;
                }
            }

            10 => {
                if(CurrentUpgrade := DragonFruitsUpgradesArr[Level]) {
                    set NextUpgradeDragonFruits = CurrentUpgrade;
                    return;
                }
            }
    
            11 => {
                if(CurrentUpgrade := PeachesUpgradesArr[Level]) {
                    set NextUpgradePeaches = CurrentUpgrade;
                    return;
                }
            }

            12 => {
                if(CurrentUpgrade := PineapplesUpgradesArr[Level]) {
                    set NextUpgradePineapples = CurrentUpgrade;
                    return;
                }
            }

            _=> { return; }
        }

    GetNextUpgrade(NextUpId : int) : ?TycoonPurchase =
        var Index : int = 1;
        for(NextUp : array{NextUpgradeCarrots, NextUpgradePotatoes, NextUpgradeTomatoes, NextUpgradeWheats, NextUpgradePumpkins,
        NextUpgradeBananas, NextUpgradeWatermelons, NextUpgradeAvocados, NextUpgradeLemons, NextUpgradeDragonFruits, NextUpgradePeaches, NextUpgradePineapples}) {
            if(Index = NextUpId) {
                return option{NextUp};
            }
            set Index += 1;
        }
        return false;

    ### OnPlayerExitUpgrade
    OnPlayerExitUpgrade(Agent : agent) : void =
        Result := IsOwner(Agent);
        if(Result?) {
            set JustBoughtUpgrade = false;
        }

    ### OnPlayerCarrotUpgrade
    OnPlayerCarrotUpgrade(Agent : agent) : void =
        # Print(">OnPlayerCarrotUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeCarrots.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(1);
            IsSuccessfulBuying(Agent, IsBuying, NextUpgradeCarrots);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            CarrotPlotFarming.UnlockAndMakeGrowingFarmingCrops(CarrotPlotFarming.GetLevel());
            ### UPGRADE
            CarrotPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := CarrotPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(CarrotsUpgradesArr);
            TempCurrentId := NextUpgradeCarrots.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := CarrotsUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeCarrots = TempNextUp;
            }
        }


    ### OnPlayerPotatoUpgrade
    OnPlayerPotatoUpgrade(Agent : agent) : void =
        # Print(">OnPlayerPotatoUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradePotatoes.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradePotatoes);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(2);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            PotatoPlotFarming.UnlockAndMakeGrowingFarmingCrops(PotatoPlotFarming.GetLevel());
            ### UPGRADE
            PotatoPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := PotatoPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(PotatoesUpgradesArr);
            TempCurrentId := NextUpgradePotatoes.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := PotatoesUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradePotatoes = TempNextUp;
            }
        }

    ### OnPlayerTomatoUpgrade
    OnPlayerTomatoUpgrade(Agent : agent) : void =
        # Print(">OnPlayerTomatoUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeTomatoes.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeTomatoes);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(3);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            TomatoPlotFarming.UnlockAndMakeGrowingFarmingCrops(TomatoPlotFarming.GetLevel());
            ### UPGRADE
            TomatoPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := TomatoPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(TomatoesUpgradesArr);
            TempCurrentId := NextUpgradeTomatoes.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := TomatoesUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeTomatoes = TempNextUp;
            }
        }

    ### OnPlayerWheatUpgrade
    OnPlayerWheatUpgrade(Agent : agent) : void =
        # Print(">OnPlayerWheatUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeWheats.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeWheats);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(4);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            WheatPlotFarming.UnlockAndMakeGrowingFarmingCrops(WheatPlotFarming.GetLevel());
            ### UPGRADE
            WheatPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := WheatPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(WheatsUpgradesArr);
            TempCurrentId := NextUpgradeWheats.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := WheatsUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeWheats = TempNextUp;
            }
        }

    ### OnPlayerPumpkinUpgrade
    OnPlayerPumpkinUpgrade(Agent : agent) : void =
        # Print(">OnPlayerPumpkinUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradePumpkins.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradePumpkins);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(5);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            PumpkinPlotFarming.UnlockAndMakeGrowingFarmingCrops(PumpkinPlotFarming.GetLevel());
            ### UPGRADE
            PumpkinPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := PumpkinPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(PumpkinsUpgradesArr);
            TempCurrentId := NextUpgradePumpkins.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := PumpkinsUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradePumpkins = TempNextUp;
            }
        }

    ### OnPlayerBananaUpgrade
    OnPlayerBananaUpgrade(Agent : agent) : void =
        # Print(">OnPlayerBananaUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeBananas.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeBananas);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(6);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            BananaPlotFarming.UnlockAndMakeGrowingFarmingCrops(BananaPlotFarming.GetLevel());
            ### UPGRADE
            BananaPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := BananaPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(BananasUpgradesArr);
            TempCurrentId := NextUpgradeBananas.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := BananasUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeBananas = TempNextUp;
            }
        }

    ### OnPlayerWatermelonUpgrade
    OnPlayerWatermelonUpgrade(Agent : agent) : void =
        # Print(">OnPlayerWatermelonUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeWatermelons.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeWatermelons);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(7);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            WatermelonPlotFarming.UnlockAndMakeGrowingFarmingCrops(WatermelonPlotFarming.GetLevel());
            ### UPGRADE
            WatermelonPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := WatermelonPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(WatermelonsUpgradesArr);
            TempCurrentId := NextUpgradeWatermelons.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := WatermelonsUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeWatermelons = TempNextUp;
            }
        }

    ### OnPlayerAvocadoUpgrade
    OnPlayerAvocadoUpgrade(Agent : agent) : void =
        # Print(">OnPlayerAvocadoUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeAvocados.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeAvocados);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(8);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            AvocadoPlotFarming.UnlockAndMakeGrowingFarmingCrops(AvocadoPlotFarming.GetLevel());
            ### UPGRADE
            AvocadoPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := AvocadoPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(AvocadosUpgradesArr);
            TempCurrentId := NextUpgradeAvocados.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := AvocadosUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeAvocados = TempNextUp;
            }
        }

    ### OnPlayerLemonUpgrade
    OnPlayerLemonUpgrade(Agent : agent) : void =
        # Print(">OnPlayerLemonUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeLemons.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeLemons);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(9);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            LemonPlotFarming.UnlockAndMakeGrowingFarmingCrops(LemonPlotFarming.GetLevel());
            ### UPGRADE
            LemonPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := LemonPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(LemonsUpgradesArr);
            TempCurrentId := NextUpgradeLemons.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := LemonsUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeLemons = TempNextUp;
            }
        }


    ### OnPlayerDragonFruitUpgrade
    OnPlayerDragonFruitUpgrade(Agent : agent) : void =
        # Print(">OnPlayerDragonFruitUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradeDragonFruits.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradeDragonFruits);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(10);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            DragonFruitPlotFarming.UnlockAndMakeGrowingFarmingCrops(DragonFruitPlotFarming.GetLevel());
            ### UPGRADE
            DragonFruitPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := DragonFruitPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(DragonFruitsUpgradesArr);
            TempCurrentId := NextUpgradeDragonFruits.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := DragonFruitsUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradeDragonFruits = TempNextUp;
            }
        }

    ### OnPlayerPeachUpgrade
    OnPlayerPeachUpgrade(Agent : agent) : void =
        # Print(">OnPlayerPeachUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradePeaches.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradePeaches);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(11);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            PeachPlotFarming.UnlockAndMakeGrowingFarmingCrops(PeachPlotFarming.GetLevel());
            ### UPGRADE
            PeachPlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := PeachPlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(PeachesUpgradesArr);
            TempCurrentId := NextUpgradePeaches.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := PeachesUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradePeaches = TempNextUp;
            }
        }

    ### OnPlayerPineappleUpgrade
    OnPlayerPineappleUpgrade(Agent : agent) : void =
        # Print(">OnPlayerPineappleUpgrade");
        if(JustBoughtUpgrade?) {
            return;
        }
        set JustBoughtUpgrade = true;
        ### CHECKING IF CAN BUY
        IsBuying := NextUpgradePineapples.OnPlayerBuy(Agent, CurrentMoneyAccount, CurrentPlayer, true);
        IsSuccessfulBuying(Agent, IsBuying, NextUpgradePineapples);
        ### IF HAS BEEN BOUGHT
        if(IsBuying = 1) {
            StatisticTrackerClass.AddFarmUpgrades(12);
            ### UNLOCK AND MAKE GROWING CURRENT FARMING CROP
            PineapplePlotFarming.UnlockAndMakeGrowingFarmingCrops(PineapplePlotFarming.GetLevel());
            ### UPGRADE
            PineapplePlotFarming.UpgradeLevel();
            ### CHECK CURRENT PLOT LEVEL
            CurrentPlotLevel := PineapplePlotFarming.GetLevel();
            ### CHECK IS LAST UPGRADE : TO DISABLE
            TempLastItem := GetLastItem(PineapplesUpgradesArr);
            TempCurrentId := NextUpgradePineapples.GetId();
            if(TempLast := TempLastItem?) {
                TempLastId := TempLast.GetId();
                if(TempLastId = TempCurrentId) {
                    TempLast.DisablePurchase();
                    return;
                }
            }

            if(TempNextUp := PineapplesUpgradesArr[CurrentPlotLevel]) {
                set NextUpgradePineapples = TempNextUp;
            }
        }

    OnPlayerOpenGift(Agent : agent) : void =
        #Print(">OnPlayerOpenGift");
        IsOwnerResult := IsOwner(Agent);
        if(not IsOwnerResult?) { return; }
        var GiftUIClass : GiftUI = GiftUI{BaseManagerDev := Self};
        GiftUIClass.AddUI(Agent);


    #######################################
    ### - GETTERS/SETTERS - METHODS UTILS
    #######################################
    GetLastItem(CurrentArr : []t where t:type) : ?t =
        if(TempItem := CurrentArr[CurrentArr.Length - 1]) {
            return option{TempItem};
        }
        return false;

    GetCurrentPlayer<public>()<transacts> : ?player = return CurrentPlayer;

    AddMoney<public>(Amount : int) : void = set Self.CurrentMoneyAccount += Amount;

    GetMoney<public>() : int = return Self.CurrentMoneyAccount;

    WithdrawMoney<public>(Amount : int) : void = set Self.CurrentMoneyAccount -= Amount;

    GetRebirthCounter<public>() : int = return Self.RebirthCounter;

    CanBuyItem(Price : int) : logic =
        if(Self.CurrentMoneyAccount >= Price) {
            return true;
        }
        return false;

    CanBuyItemRebirth(Price : int) : logic =
        if(Self.RebirthCounter >= Price) {
            return true;
        }
        return false;

    GetRoundedString<private>(Input : float, NumDigitsAfterDecimal : int) : string =
        if:
            Multiplier := Pow(10.0, NumDigitsAfterDecimal * 1.0)
            RoundedValue := RoundedTickRate := float[Round[Input*Multiplier]*1.0] / Multiplier
            BeforeDecimal := Floor[RoundedValue]
            AfterDecimal := Abs(Round[(RoundedValue - BeforeDecimal*1.0)*Multiplier])
            var AfterDecimalString : string = ToString(AfterDecimal)

            #pad with leading zeroes
            for (It := 0..(NumDigitsAfterDecimal-AfterDecimalString.Length-1)):
                set AfterDecimalString = array{'0'} + AfterDecimalString
        then:
            "{BeforeDecimal}.{AfterDecimalString}"
        else:
            ToString(Input)

    FormatMoney<private>(Amount : int) : string =
        #Print(">FormatMoney");
        if(Amount > 1000000) {
            # > 1M
            TempStr : string = "{GetRoundedString((Amount * 1.0) / 1000000.0, 2)}M";
            return TempStr;
            
        }else if(Amount > 100000) {
            # > 100K
            TempStr : string = "{GetRoundedString((Amount * 1.0) / 1000.0, 2)}K";
            return TempStr;

        }
        return "{Amount}";

    FormatSecondsToMinutes<public>(Seconds : int) : string = 
        Minutes := Floor(Seconds / 60) or 0
        RemainingSeconds := Mod[Seconds, 60] or 0
        return "{Minutes < 10 and "0{Minutes}" or "{Minutes}"}:{RemainingSeconds < 10 and "0{RemainingSeconds}" or "{RemainingSeconds}"}"

    GetChestClaimedArr<public>() : []logic =
        return ChestClaimedArr;

    SetChestClaimedArr<public>(NewArr : []logic) : void =
        set ChestClaimedArr = NewArr;

    GetTimerGiftBox<public>() : timer_device =
        return GiftBoxTimer;

    GetGiftBoxRewardXP<public>() : accolades_device =
        return GiftBoxRewardXP;

    GetStatisticTrackerClass<public>() : StatisticTracker = return Self.StatisticTrackerClass;

    AddXp(Amount : int) : void = 
        PlayerLevelClass.AddCurrentXp(Amount);

    GetPetBonus<public>() : float = return Self.PetBonus;

    SetPetBonus<public>(NewAmount : float) : void = set Self.PetBonus = NewAmount;

    GetTrailBonus<public>() : float = return Self.TrailBonus;

    SetTrailBonus<public>(NewAmount : float) : void = set Self.TrailBonus = NewAmount;

    GetCurrentSunAccount<public>() : int = return Self.CurrentSunAccount;

    SetCurrentSunAccount<public>(Amount : int) : void = set Self.CurrentSunAccount = Amount;

    WithdrawSun<public>(Amount : int) : void = set Self.CurrentSunAccount -= Amount;

    AddSun<public>(Amount : int) : void = set Self.CurrentSunAccount += Amount;

    CanBuyItemSun(Price : int) : logic =
        if(Self.CurrentSunAccount >= Price) {
            return true;
        }
        return false;

    GetCurrentSquidCoinAccount<public>() : int = return Self.CurrentSquidCoinAccount;

    SetCurrentSquidCoinAccount<public>(Amount : int) : void = set Self.CurrentSquidCoinAccount = Amount;

    WithdrawSquidCoin<public>(Amount : int) : void = set Self.CurrentSquidCoinAccount -= Amount;

    AddSquidCoin<public>(Amount : int) : void = set Self.CurrentSquidCoinAccount += Amount;

    CanBuyItemSquidCoin(Price : int) : logic =
        if(Self.CurrentSquidCoinAccount >= Price) {
            return true;
        }
        return false;

    ###########################################################################
    ## UI PART
    ###########################################################################
    UIText<localizes>(Value : string) : message = "{Value}$";

    UITextMoneyPerSec<localizes>(Value : string) : message = "{Value}$/s";

    UITextFollowers<localizes>(Value : string) : message = "{Value}";

    UITextGift<localizes>(Value : string) : message = "{Value}";

    UITextSun<localizes>(Value : string) : message = "{Value}";

    UITextSave<localizes>(Value : string) : message = "{Value}";

    UITextRebirthBonus<localizes>(Value : string) : message = "{Value}%";

    (Player : player).InitUI() : void =

        TextWidget : text_block = text_block{DefaultTextColor := NamedColors.White};

        TextureImage : texture = HUD.hud_money_v2;

        TextWidgetRebirth : text_block = text_block{DefaultTextColor := NamedColors.White};

        TextureImageRebirth : texture = HUD.hud_rebirth_v2;

        TextWidgetSun : text_block = text_block{DefaultTextColor := NamedColors.White};

        TextureImageSun : texture = HUD.hud_squid_coin;
    #     TextWidgetFollowers : text_block = text_block{DefaultTextColor := NamedColors.White};

    #     TextureImageFollowers : texture = HUD.Hud_Followers;

    #     TextureIslandCode : texture_block = texture_block{DefaultImage := UI.StreamerTycoonIslandCode,  DefaultDesiredSize := vector2{X := 350.0, Y := 150.0}}
    
        NewCanvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Widget := TextWidget;
                    Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                    Offsets := margin{Left := -752.0, Top := -105.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    SizeToContent := true
                canvas_slot:
                    Widget := texture_block{DefaultImage := TextureImage, DefaultDesiredSize := vector2{X := 300.0, Y := 85.0}};
                    Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                    Offsets := margin{Left := -782.0, Top := -105.0, Right := 300.0, Bottom := 85.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    SizeToContent := false
                canvas_slot:
                    Widget := TextWidgetRebirth;
                    Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                    Offsets := margin{Left := -752.0, Top := 105.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    SizeToContent := true
                canvas_slot:
                    Widget := texture_block{DefaultImage := TextureImageRebirth, DefaultDesiredSize := vector2{X := 330.0, Y := 115.0}};
                    Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                    Offsets := margin{Left := -782.0, Top := 105.0, Right := 300.0, Bottom := 85.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    SizeToContent := false
                canvas_slot:
                    Widget := TextWidgetSun;
                    Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                    Offsets := margin{Left := -752.0, Top := 0.0, Right := 200.0, Bottom := 40.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    SizeToContent := true
                canvas_slot:
                    Widget := texture_block{DefaultImage := TextureImageSun, DefaultDesiredSize := vector2{X := 330.0, Y := 115.0}};
                    Anchors := anchors{ Minimum := vector2{ X := 0.5, Y := 0.5}, Maximum := vector2{ X := 0.5, Y := 0.5}};
                    Offsets := margin{Left := -782.0, Top := 0.0, Right := 300.0, Bottom := 85.0}
                    Alignment := vector2{X:= 0.5, Y:= 0.5}
                    SizeToContent := false


        if (PlayerUI := GetPlayerUI[Player], FortCharacter := Player.GetFortCharacter[]):
            PlayerUI.AddWidget(NewCanvas);
            spawn:
                FortCharacter.UpdateUI(TextWidget, TextWidgetRebirth, TextWidgetSun);

    (FortCharacter : fort_character).UpdateUI(TextBlock : text_block, TextBlockRebirth : text_block, TextBlockSun : text_block)<suspends> : void =
        loop:
            Sleep(0.4);
            TextBlock.SetText(UIText("{FormatMoney(CurrentMoneyAccount)}"));
            TextBlockSun.SetText(UITextSun("{CurrentSquidCoinAccount}"));
            TextBlockRebirth.SetText(UITextGift("{RebirthCounter}"));

            if(CancelTask?) {
                break;
            }