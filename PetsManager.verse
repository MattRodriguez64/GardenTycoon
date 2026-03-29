
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Fortnite.com/Devices/CreativeAnimation/InterpolationTypes }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Characters }
using { /Verse.org/Assets }

agent_data := class:
    var OwnedPets : []tuple(creative_prop, int) = array{};
    var ActivePetIndex : int = -1;
    var bPetPlayingAnim : logic = false;

pet_purchased_data := class<concrete>:
    @editable ButtonForPurchase : button_device = button_device{};
    @editable PetPrice : int = 0;
    @editable PetProps : []creative_prop = array{};
    @editable Bonus : float = 0.0;
    @editable IsMoneyPurchase : logic = false;
    @editable CustomTexture : texture = UI.EmptySlotImage;
    @editable IsSquidCoinPurchase : logic = false;

    var Index : int = -1;
    var MaybeMainDevice : ?PetsManager = false;
    var AvailablePetProps : []logic = array{};

    OnPurchase(Agent : agent) : void =
        if(MainDevice := MaybeMainDevice?) {
            MainDevice.OnPetPurchase(Agent, Self, false);
        }

PetDataSlot := class:
    var Index : int = -1;
    var CustomTexture : texture = UI.EmptySlotImage;
    var Bonus : float = 0.0;

PetsManager := class(creative_device):

    @editable GameManagerDev : GameManager = GameManager{};
    @editable DataSaveManagerClass : DataSaveManager = DataSaveManager{};
    @editable GoldConditionalButton : conditional_button_device = conditional_button_device{};
    @editable PlayerSpawners : []player_spawner_device = array{};
    @editable PetPurchasesData : []pet_purchased_data = array{};

    var AgentMap : [agent]agent_data = map{};
    var IdleAnimationKeyframes : []keyframe_delta = array{};

    @editable PetsManagerUIButton : button_device = button_device{};

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print("> PetsManager : ON BEGIN");

        for(PlayerSpawner : PlayerSpawners) {
            PlayerSpawner.SpawnedEvent.Subscribe(OnPlayerSpawned);
        }

        for(I := 0..PetPurchasesData.Length-1, PetPurchaseData := PetPurchasesData[I]) {
            for(J := 0..PetPurchaseData.PetProps.Length-1, PetProp := PetPurchaseData.PetProps[J]) {
                PetProp.Hide();
                set PetPurchaseData.AvailablePetProps += array{true};
            }
            set PetPurchaseData.MaybeMainDevice = option{Self};
            set PetPurchaseData.Index = I;
            PetPurchaseData.ButtonForPurchase.InteractedWithEvent.Subscribe(PetPurchaseData.OnPurchase);
        }

        UpMovementKeyFrame : keyframe_delta = keyframe_delta {
            DeltaLocation := vector3{X:=0.0, Y:=0.0, Z:=30.0};
            DeltaRotation := IdentityRotation();
            DeltaScale := vector3{X:=1.0, Y:=1.0, Z:=1.0};
            Time := 0.85;
            Interpolation := Ease;
        }

        DownMovementKeyFrame : keyframe_delta = keyframe_delta {
            DeltaLocation := vector3{X:=0.0, Y:=0.0, Z:=-30.0};
            DeltaRotation := IdentityRotation();
            DeltaScale := vector3{X:=1.0, Y:=1.0, Z:=1.0};
            Time := 0.85;
            Interpolation := Ease;
        }

        set IdleAnimationKeyframes = array{UpMovementKeyFrame, DownMovementKeyFrame};
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerLeft);

        PetsManagerUIButton.InteractedWithEvent.Subscribe(OnOpenPetsUI);

        spawn{AsyncPetFollow()};

    OnPlayerSpawned(Agent : agent) : void =
        if (not AgentMap[Agent]) {
            if(set AgentMap[Agent] = agent_data{}) {
                
            }
        }

    LoadLastPetSaved<public>(Agent : agent) : void =
        Print(">LoadLastPetSaved");
        if(CurrentPlayer := player[Agent]) {
            PlayerBaseM := GameManagerDev.GetBaseManagerDevice(Agent);
            CurrentDataPlayer := PlayerBaseM.GetStatisticTrackerClass();
            PetsArrayToPlayer := CurrentDataPlayer.GetPetsBought();
            if(PetsArrayToPlayer.Length > 0) {
                if(GetAgentPet := AgentMap[Agent]) {
                    for(Index := 0..PetsArrayToPlayer.Length - 1) {
                        if(PetSavedId := PetsArrayToPlayer[Index]) {
                            TempPetData := GetPetPurchaseDataById(PetSavedId);
                            if(TempPetDataNonNull := TempPetData?) {
                                OnPetPurchase(Agent, TempPetDataNonNull, true);
                            }
                        }
                    }
                }
            }
        }

    ChoosePetById<public>(Agent : agent, Id : int) : void =
        if(GetAgentPet := AgentMap[Agent]) {
            for(CurrentPet : GetAgentPet.OwnedPets) {
                if(Id = CurrentPet(1)) {
                    TempPetData := GetPetPurchaseDataById(Id);
                    if(TempPetDataNonNull := TempPetData?) {
                        OnPetPurchase(Agent, TempPetDataNonNull, true);
                    }
                }
            }
        }

    OnPlayerLeft(Player : player) : void =
        if(AgentData := AgentMap[Player]) {
            for(OwnedPetTuple : AgentData.OwnedPets) {
                PetProp : creative_prop = OwnedPetTuple(0);
                PetPurchaseDataIndex : int = OwnedPetTuple(1);
                PetProp.Hide();

                if(PetPurchaseData := PetPurchasesData[PetPurchaseDataIndex]) {
                    var I : int =0;
                    loop:
                        if(Availability : logic = PetPurchaseData.AvailablePetProps[I]) {
                            if(set PetPurchaseData.AvailablePetProps[I] = true) {}
                            break;
                        } 

                        if(I > PetPurchaseData.AvailablePetProps.Length) {
                            break;
                        }

                        set I += 1;
                }
            }

            for(CurrentPlayer -> CurrentAgentData : AgentMap, CurrentPlayer <> Player) {
                set AgentMap = ConcatenateMaps(AgentMap, map{CurrentPlayer => CurrentAgentData});
            }
        }


    GetPetPurchaseDataById(Id : int) : ?pet_purchased_data =
        for(CurrentPurchaseData : PetPurchasesData) {
            if(CurrentPurchaseData.Index = Id) {
                return option{CurrentPurchaseData};
            }
        }
        return false;

    OnPetPurchase(Agent : agent, PetPurchaseData :pet_purchased_data, IsLoadingData : logic) : void =
        var FoundPetIndex : int = -1;
        if(AgentData := AgentMap[Agent]) {
            for(I:=0..AgentData.OwnedPets.Length-1, OwnedPetTuple := AgentData.OwnedPets[I]) {
                PetPurchaseIndex : int = OwnedPetTuple(1);
                if(PetPurchaseIndex = PetPurchaseData.Index) {
                    set FoundPetIndex = I;
                }
            }
        }

        if(FoundPetIndex = -1) {
            var AvailablePetPropIndex : int = -1;
            for(I:= 0..PetPurchaseData.AvailablePetProps.Length-1, AvailablePetProp := PetPurchaseData.AvailablePetProps[I]) {
                if(AvailablePetProp = true) {
                    set AvailablePetPropIndex = I;
                }
            }

            if(AvailablePetPropIndex = -1) {
                Print("All Pets are Purchased!");
                return;
            }

            PlayerBaseManager := GameManagerDev.GetBaseManagerDevice(Agent);
            if(not IsLoadingData?) {
                
                # OwnedGold : int = GoldConditionalButton.GetItemCount(Agent, 0);
                var CanBuy : logic = false;

                if(PetPurchaseData.IsMoneyPurchase?) {
                    set CanBuy = PlayerBaseManager.CanBuyItemRebirth(PetPurchaseData.PetPrice);
                } else if(PetPurchaseData.IsSquidCoinPurchase?) {
                    set CanBuy = PlayerBaseManager.CanBuyItemSquidCoin(PetPurchaseData.PetPrice);
                } else {
                    set CanBuy = PlayerBaseManager.CanBuyItemSun(PetPurchaseData.PetPrice);
                }

                # OwnedGold : int = PlayerBaseManager.GetMoney();
                if(not CanBuy?) {
                    Print("Not enough Money!");
                    return;
                }

                if(not PetPurchaseData.IsMoneyPurchase? and not PetPurchaseData.IsSquidCoinPurchase?) {
                    PlayerBaseManager.WithdrawSun(PetPurchaseData.PetPrice);
                } else if(PetPurchaseData.IsSquidCoinPurchase?) {
                    PlayerBaseManager.WithdrawSquidCoin(PetPurchaseData.PetPrice);
                }
                
                PlayerStatTracker := PlayerBaseManager.GetStatisticTrackerClass();
                PlayerStatTracker.AddPetsBought(PetPurchaseData.Index);

                #Print("PetPurchaseData.Index : {PetPurchaseData.Index}");

                if(TempPlayer := player[Agent], TempPlayer.IsActive[]) {
                    DataSaveManagerClass.SavePet(Agent, PlayerStatTracker.GetPetsBought());
                }

                # GoldConditionalButton.SetItemCountRequired(0, PetPurchaseData.PetPrice);
                # GoldConditionalButton.Activate(Agent);
            }
            PlayerBaseManager.SetPetBonus(PetPurchaseData.Bonus);

            if(set PetPurchaseData.AvailablePetProps[AvailablePetPropIndex] = false) {}

            if(PetProp : creative_prop = PetPurchaseData.PetProps[AvailablePetPropIndex], AgentData := AgentMap[Agent]) {
                PetTuple : tuple(creative_prop, int) = (PetProp, PetPurchaseData.Index);

                set AgentData.OwnedPets += array{PetTuple};
                set FoundPetIndex = AgentData.OwnedPets.Length-1;
            }
        }

        if(AgentData := AgentMap[Agent]) {
            if(PetPropTuple := AgentData.OwnedPets[AgentData.ActivePetIndex]) {
                PetProp := PetPropTuple(0);
                PetProp.Hide();
            }

            set AgentData.ActivePetIndex = FoundPetIndex;

            if(PetPropTuple := AgentData.OwnedPets[AgentData.ActivePetIndex]) {
                PetProp := PetPropTuple(0);
                PetProp.Show();

                if(FortCharacter := Agent.GetFortCharacter[]) {
                    var TeleportLoc : vector3 = FortCharacter.GetTransform().Translation;
                    set TeleportLoc.X += 50.0;

                    if(PetProp.TeleportTo[TeleportLoc, IdentityRotation()]) {}
                }
            }

            set AgentData.bPetPlayingAnim = false;
        }

    AsyncPetFollow()<suspends> : void =
        FollowDistance : float = 200.0;
        WaitDistance : float = 100.0;
        SleepTime : float = 0.2;

        loop:
            Sleep(SleepTime);
            for(Player : GetPlayspace().GetPlayers(), AgentData := AgentMap[Player], 
            PetPropTuple := AgentData.OwnedPets[AgentData.ActivePetIndex], FortCharacter := Player.GetFortCharacter[]) {
                PetProp : creative_prop = PetPropTuple(0);
                PetLoc : vector3 = PetProp.GetTransform().Translation;
                PlayerLoc : vector3 = FortCharacter.GetTransform().Translation;
                DistanceToPlayer : float = Distance(PetLoc, PlayerLoc);

                if(DistanceToPlayer >= FollowDistance) {
                    if(Direction := (PlayerLoc - PetLoc).MakeUnitVector[]) {
                        DistanceToTravel : float = DistanceToPlayer - WaitDistance;
                        var LocationToTravel : vector3 = PetLoc + (Direction * DistanceToTravel);

                        set AgentData.bPetPlayingAnim = false;
                        if(PropAnimController := PetProp.GetAnimationController[]) {
                            PropAnimController.Stop();
                        }

                        PlayerRotation := FortCharacter.GetTransform().Rotation;
                        spawn{PetProp.MoveTo(LocationToTravel, PlayerRotation, SleepTime)};
                    }
                } else {
                    if(AgentData.bPetPlayingAnim = false) {
                        set AgentData.bPetPlayingAnim = true;
                        if(PropAnimController := PetProp.GetAnimationController[]) {
                            PropAnimController.SetAnimation(IdleAnimationKeyframes, ?Mode := animation_mode.Loop);
                            PropAnimController.Play();
                        }
                    }
                }
            }

    GetAllOwnedPetsIndex<private>(ArrayToSearch : []tuple(creative_prop, int)) : []int =
        var TempArray : []int = array{};
        if(ArrayToSearch.Length > 0) {
            for(Elt : ArrayToSearch) {
                set TempArray += array{Elt(1)};
            }
        }

        return TempArray;

    GetPetsDataSlotFromPlayer<public>(Agent : agent) : []PetDataSlot =
        ### GET PLAYER OWNED PETS
        var TempArray : []PetDataSlot = array{};
        if(GetAgentData := AgentMap[Agent]) {
            AllOwnedPetsIndex : []int = GetAllOwnedPetsIndex(GetAgentData.OwnedPets);
            for(CurrentPetData : PetPurchasesData) {
                for(CurrentPetIndex : AllOwnedPetsIndex) {
                    if(CurrentPetIndex = CurrentPetData.Index) {
                        TempPetDataSlot : PetDataSlot = PetDataSlot{
                            Index := CurrentPetIndex,
                            CustomTexture := CurrentPetData.CustomTexture,
                            Bonus := CurrentPetData.Bonus
                        };
                        set TempArray = TempArray + array{TempPetDataSlot};
                    }
                }
            }

        }

        return TempArray;

    OnOpenPetsUI(Agent : agent) : void =
        AllPetsDataSlot := GetPetsDataSlotFromPlayer(Agent);
        TempUI : PetsManagerUI = PetsManagerUI{AllPlayerOwnedPets := AllPetsDataSlot, PetsManagerDevice := Self};
        TempUI.AddUI(Agent);