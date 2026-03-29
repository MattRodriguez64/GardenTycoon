
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Concurrency }
using { /Fortnite.com/Characters }
using { /Verse.org/Assets }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /UnrealEngine.com/Temporary/SpatialMath }


State := enum{NotPlanted, Planted, Growing, Completed};
Rainbow : texture = UI.RainbowItem;
Sun : texture = UI.SunItem;
Squid : texture = UI.SquidItem;


FarmingCrop := class:
    @editable Id : int = -1;
    var IsUnlocked : logic = false;
    @editable CollectButton : button_device = button_device{};
    @editable var FarmingCropItemClass : FarmingCropItem = FarmingCropItem{};
    var CurrentState : State = State.NotPlanted;
    var GrowingTime : float = 0.0;
    var GameManagerDev : GameManager = GameManager{};
    var OwnerPlayer : ?player = false;
    var ItemImage : texture = UI.EmptySlotImage;
    var AnimationController : ?animation_controller = false;
    @editable CompletedPlane : creative_prop = creative_prop{};
    var CollectSound : audio_player_device = audio_player_device{};

    GetId<public>()<transacts> : int = return Self.Id;

    GetIsUnlocked<public>() : logic = return Self.IsUnlocked;
    SetIsUnlocked<public>(New : logic) : void = set Self.IsUnlocked = New;

    GetCollectButton<public>() : button_device = return Self.CollectButton;

    GetFarmingCropItemClass<public>() : FarmingCropItem = return Self.FarmingCropItemClass;

    GetCurrentState<public>() : State = return Self.CurrentState;
    SetCurrentState<public>(New : State) : void = set Self.CurrentState = New;

    GetGrowingTime<public>() : float = return Self.GrowingTime;
    SetGrowingTime<public>(New : float) : void = set Self.GrowingTime = New;

    GetGameManagerDev<public>() : GameManager = return Self.GameManagerDev;
    SetGameManagerDev<public>(New : GameManager) : void = set Self.GameManagerDev = New;

    GetOwnerPlayer<public>() : ?player = return Self.OwnerPlayer;
    SetOwnerPlayer<public>(New : ?player) : void = set Self.OwnerPlayer = New;

    SetItemImage<public>(Image : texture) : void = set Self.ItemImage = Image;

    SetCollectSound(NewSound : audio_player_device) : void = set Self.CollectSound = NewSound;

    SetEventCropFarmingCrop<public>() : void =
        FarmingCropItemClass.SetEventCropProp();

    SetRainbowFarmingCrop<public>() : void =
        FarmingCropItemClass.SetRainbowProp();

    GetIsRainbowOrSun<public>() : logic =
        IsRainbow := FarmingCropItemClass.GetIsRainbow();
        IsEventCrop := FarmingCropItemClass.GetIsEventCrop();
        if(IsRainbow? or IsEventCrop?) {
            return true;
        }
        return false;

    IsOwner<public>(Agent : agent) : logic = 
        if(CurrentFort := Agent.GetFortCharacter[], Owner := OwnerPlayer?, OwnerFort := Owner.GetFortCharacter[], CurrentFort <> OwnerFort) {
            return false;
        }
        return true;

    Init<public>() : void =
        CollectButton.InteractedWithEvent.Subscribe(OnCollect);
        CompletedPlane.Hide();
        FarmingCropItemClass.Reset();
        FarmingCropItemClass.SetItemImage(ItemImage);
        CollectButton.Disable();
        TempFarmingCropProp := FarmingCropItemClass.GetProp();
        if(TempAnimController := TempFarmingCropProp.GetAnimationController[]) {
            set AnimationController = option{TempAnimController};
            if(AnimationControllerNonNull := AnimationController?) {
                AnimationControllerNonNull.MovementCompleteEvent.Subscribe(OnGrowEnd);
            }
        }

    OnGrowEnd<private>() : void =
        # Print(">OnGrowEnd");
        set Self.CurrentState = State.Completed;
        CollectButton.Enable();
        CompletedPlane.Show();

    OnCollect<public>(Agent : agent) : void =
        ResultIsOwner := IsOwner(Agent);
        if(not ResultIsOwner?) { return; }

        IsRainbow := FarmingCropItemClass.GetIsRainbow();
        IsEventCrop := FarmingCropItemClass.GetIsEventCrop();

        if(OwnerPlayerNonNull := OwnerPlayer?) {
            PlayerInventory := GameManagerDev.GetPlayerInventory(OwnerPlayerNonNull);
            if(PlayerInventoryNonNull := PlayerInventory?) {
                var ItemHasBeenAdded : logic = false;

                if(not IsRainbow? and not IsEventCrop?) {
                    set ItemHasBeenAdded = PlayerInventoryNonNull.AddItemToInventory(FarmingCropItemClass.GetId(), FarmingCropItemClass.GetWeight(), FarmingCropItemClass.GetItemImage());
                } 
                else if(IsEventCrop?) {
                    set ItemHasBeenAdded = PlayerInventoryNonNull.AddItemToInventory(75, FarmingCropItemClass.GetWeight(), Squid);
                } 
                else {
                    set ItemHasBeenAdded = PlayerInventoryNonNull.AddItemToInventory(100, FarmingCropItemClass.GetWeight(), Rainbow);
                }
                
                if(not ItemHasBeenAdded?) {
                    #Print("CANNOT COLLECT CROP!");
                    return;
                } else {
                    #Print("CROP ADDED!");
                    CollectSound.Play(Agent);
                }
            }
        }

        PlayerBaseManager := GameManagerDev.GetBaseManagerDevice(Agent);
        if(CurrentPlayer := player[Agent]) {
            PlayerBaseManager.AddXp(2);
            PlayerBaseManager.CollectXP.Award(Agent);
            PlayerBaseManager.SaveData(CurrentPlayer);
            if(IsEventCrop?) {
                PlayerBaseManager.AddSquidCoin(1);
            }
        }

        FarmingCropItemClass.Reset();
        CollectButton.Disable();
        set Self.CurrentState = State.NotPlanted;
        ResetFarmingCropItem();
        CompletedPlane.Hide();

    GrowFarmingCropItem() : void =
        # Print("GrowFarmingCropItem")
        set Self.CurrentState = State.Growing;
        if(AnimationControllerNonNull := AnimationController?) {
            FarmingCropItemClass.Grow(GrowingTime, AnimationControllerNonNull);
        }
        
    ResetFarmingCropItem() : void =
        set Self.CurrentState = State.Planted;
        Self.GrowFarmingCropItem();

    Reset<public>() : void =
        if(AnimationControllerNonNull := AnimationController?) {
            FarmingCropItemClass.DefaultReset(AnimationControllerNonNull);
            CollectButton.Disable();
            set Self.CurrentState = State.NotPlanted;
            CompletedPlane.Hide();
        }





        