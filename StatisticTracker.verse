
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

StatisticTracker := class:
    var Money<private> : int = 0;
    var BuildColorBought<private> : []int = array{};
    var FarmUpgrades<private> : []int = array{};
    var PurchasesMade<private> : []int = array{};
    var PlotFarmingLevels<private> : []int = array{};
    var LoginCounter<private> : int = 0;
    var RebirthCounter<private> : int = 0;
    var PetsBought<private> : []int = array{};
    var TrailsBought<private> : []int = array{};
    var RainbowCrops<private> : []tuple(int, int) = array{};
    var SunMoney<private> : int = 0;
    var SquidCoin<private> : int = 0;

    # GETTERS/SETTERS()
    GetMoney<public>() : int =
        return Money;

    SetMoney<public>(NewMoney : int) : void =
        set Money = NewMoney;
    
    GetBuildColorBought<public>() : []int =
        return BuildColorBought;

    SetBuildColorBought<public>(NewBuildColorBought : []int) : void =
        set BuildColorBought = NewBuildColorBought;

    GetFarmUpgrades<public>() : []int =
        return FarmUpgrades;

    SetFarmUpgrades<public>(NewFarmUpgrades : []int) : void =
        set FarmUpgrades = NewFarmUpgrades;

    GetPurchasesMade<public>() : []int =
        return PurchasesMade;

    SetPurchasesMade<public>(NewPurchasesMade : []int) : void =
        set PurchasesMade = NewPurchasesMade;

    GetPlotFarmingLevels<public>() : []int =
        return PlotFarmingLevels;

    SetPlotFarmingLevels<public>(NewPlotFarmingLevels : []int) : void =
        set PlotFarmingLevels = NewPlotFarmingLevels;

    GetLoginCounter<public>() : int =
        return LoginCounter;

    SetLoginCounter<public>(NewLoginCounter : int) : void =
        set LoginCounter = NewLoginCounter;

    GetRebirthCounter<public>() : int =
        return RebirthCounter;

    SetRebirthCounter<public>(NewRebirthCounter : int) : void =
        set RebirthCounter = NewRebirthCounter;

    GetPetsBought<public>() : []int =
        return PetsBought;

    SetPetsBought<public>(NewPetsBought : []int) : void =
        set PetsBought = NewPetsBought;

    GetTrailsBought<public>() : []int =
        return TrailsBought;

    SetTrailsBought<public>(NewTrailsBought : []int) : void =
        set TrailsBought = NewTrailsBought;

    GetRainbowCrops<public>() : []tuple(int, int) =
        return RainbowCrops;

    SetRainbowCrops<public>(NewRainbowCrops : []tuple(int, int)) : void =
        set RainbowCrops = NewRainbowCrops;

    GetSunMoney<public>() : int =
        return SunMoney;

    SetSunMoney<public>(NewSunMoney : int) : void =
        set SunMoney = NewSunMoney;

    GetSquidCoin<public>() : int =
        return SquidCoin;

    SetSquidCoin<public>(NewSquidCoin : int) : void =
        set SquidCoin = NewSquidCoin;

    # FUNCTIONS()

    AddFarmUpgrades<public>(FarmUpgradeId : int) : void =
        #Print(">>AddFarmUpgrades");
        set FarmUpgrades = FarmUpgrades + array{FarmUpgradeId};

    AddPurchaseMade<public>(PurchaseId : int) : void =
        #Print(">>AddPurchaseMade");
        for (Index := 0..PurchasesMade.Length - 1) {
            if (Element := PurchasesMade[Index], Element = PurchaseId) {
                return;
            }
        }
        
        set PurchasesMade = PurchasesMade + array{PurchaseId};

    AddBuildColorBought<public>(ColorId : int) : void =
        #Print(">>AddBuildColorBought");
        for (Index := 0..BuildColorBought.Length - 1) {
            if (Element := BuildColorBought[Index], Element = ColorId) {
                return;
            }
        }
        
        set BuildColorBought = BuildColorBought + array{ColorId};

    AddPetsBought<public>(PetId : int) : void =
        #Print(">>AddPetsBought");
        for (Index := 0..PetsBought.Length - 1) {
            if (Element := PetsBought[Index], Element = PetId) {
                return;
            }
        }

        set PetsBought = Concatenate(PetsBought, array{PetId});

    AddTrailsBought<public>(TrailId : int) : void =
        #Print(">>AddTrailsBought");
        for (Index := 0..TrailsBought.Length - 1) {
            if (Element := TrailsBought[Index], Element = TrailId) {
                return;
            }
        }

        set TrailsBought = Concatenate(TrailsBought, array{TrailId});

    AddRainbowCrops<public>(RainbowCropId : tuple(int, int)) : void =
        #Print(">>AddRainbowCrops");
        for (Index := 0..RainbowCrops.Length - 1) {
            if (Element := RainbowCrops[Index], Element = RainbowCropId) {
                return;
            }
        }

        set RainbowCrops = Concatenate(RainbowCrops, array{RainbowCropId});

    IncrementLoginCounter<public>() : void =
        set LoginCounter += 1;

    IncrementRebirthCounter<public>() : void =
        set RebirthCounter += 1;

    AddLoginCounter(Amount : int) : void = set LoginCounter += Amount;
