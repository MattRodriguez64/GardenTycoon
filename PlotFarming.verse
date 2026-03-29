
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Concurrency }
using { /Verse.org/Assets }


PlotFarming := class:
    @editable Id : int = -1;
    @editable CollectSound : audio_player_device = audio_player_device{};
    var Level : int = 0;
    @editable FarmingCropArr : []FarmingCrop = array{};
    var Bonus : float = 0.0;     
    @editable var GrowingTime : float = 0.0;   
    var GameManagerDev : GameManager = GameManager{};
    var OwnerPlayer : ?player = false;
    var ItemImage : texture = UI.EmptySlotImage;
    var OriginalGrowingTime : float = 0.0;
    
    GetId<public>() : int = return Self.Id;

    GetLevel<public>() : int = return Self.Level;
    SetLevel<public>(New : int) : void = set Self.Level = New;
    UpgradeLevel<public>() : void = set Self.Level += 1;
    
    GetFarmingCropArr<public>() : []FarmingCrop = return Self.FarmingCropArr;

    GetBonus<public>() : float = return Self.Bonus;
    SetBonus<public>(New : float) : void = set Self.Bonus = New;

    GetGrowingTime<public>() : float = return Self.GrowingTime;
    SetGrowingTime<public>(New : float) : void = set Self.GrowingTime = New;

    SetGameManagerDev<public>(New : GameManager) : void = set Self.GameManagerDev = New;
    GetGameManagerDev<public>() : GameManager = return Self.GameManagerDev;

    GetOwnerPlayer<public>() : ?player = return Self.OwnerPlayer;
    SetOwnerPlayer<public>(New : ?player) : void = 
        set Self.OwnerPlayer = New;
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.SetOwnerPlayer(OwnerPlayer);
        }

    SetItemImage<public>(Image : texture) : void = set Self.ItemImage = Image;

    Init<public>() : void =
        set OriginalGrowingTime = GrowingTime;
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.SetItemImage(ItemImage)
            # CurrentFarmingCrop.SetOwnerPlayer(OwnerPlayer);
            CurrentFarmingCrop.SetGameManagerDev(Self.GameManagerDev);
            CurrentFarmingCrop.Init();
            CurrentFarmingCrop.SetGrowingTime(Self.GetGrowingTime());
            CurrentFarmingCrop.SetCollectSound(CollectSound);
        }

    BoostGrowingTime<public>(NewTime : float) : void =
        SetGrowingTime(NewTime);
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.SetGrowingTime(Self.GetGrowingTime());
        }

    EndBoostGrowingTime<public>() : void =
        SetGrowingTime(Self.OriginalGrowingTime);
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.SetGrowingTime(Self.GetGrowingTime());
        }

    SetPropsInvisible<public>() : void =
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.CompletedPlane.Hide();
        }

    UnlockAndMakeGrowingFarmingCrops<public>(Index : int) : void =
        if(FarmingCropInst := FarmingCropArr[Index]) {
            FarmingCropInst.SetIsUnlocked(true);
            FarmingCropInst.ResetFarmingCropItem();
        }

    DefaultReset<public>() : void =
        set Level = 0;
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.Reset();
            CurrentFarmingCrop.SetOwnerPlayer(false);
        }

    RebirthReset<public>() : void =
        set Level = 0;
        for(CurrentFarmingCrop : FarmingCropArr) {
            CurrentFarmingCrop.Reset();
        }

    CollectAllFarmingCrop<public>(Agent : agent) : void =
        for(FCrop : FarmingCropArr) {
            IsUnlocked := FCrop.GetIsUnlocked();
            CurrentState := FCrop.GetCurrentState();

            if(IsUnlocked? and CurrentState = State.Completed) {
                FCrop.OnCollect(Agent);
            }
        }

    CollectAllFarmingCropExceptRares<public>(Agent : agent) : void =
        for(FCrop : FarmingCropArr) {
            IsUnlocked := FCrop.GetIsUnlocked();
            CurrentState := FCrop.GetCurrentState();
            IsRainbowOrSun := FCrop.GetIsRainbowOrSun();

            if(IsUnlocked? and CurrentState = State.Completed and not IsRainbowOrSun?) {
                FCrop.OnCollect(Agent);
            }
        }

    GetAllRainbowCrops<public>() : []tuple(int, int) =
        var TempArray : []tuple(int, int) = array{};
        for(FCrop : FarmingCropArr) {
            IsRainbowCrop := FCrop.FarmingCropItemClass.GetIsRainbow();
            if(IsRainbowCrop?) {
                #Print("> GetAllRainbowCrops (0) : {Id} - (1) : {FCrop.GetId()}");
                set TempArray = Concatenate(TempArray, array{(Id, FCrop.GetId())});
            }
        }

        return TempArray;

    GetFarmingCropsById<public>(Index : int) : ?FarmingCrop =
        if(FarmingCropInst := FarmingCropArr[Index - 1]) {
            return option{FarmingCropInst};
        }
        return false;
        



        
        

        

        


        


        


        