

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


SunBoostItem := class :
    @editable Prop : creative_prop = creative_prop{};
    @editable Timer : timer_device = timer_device{};
    var IsActiveBonus : logic = false;
    var PlotFarmingBoosted : ?PlotFarming = false;

    Init<public>() : void =
        Timer.SuccessEvent.Subscribe(OnTimerEnd);

    Hide<public>() : void =
        Prop.Hide();

    CalcNewGrowingTime<private>(OldGrowingTime : float) : float =
        TempGrowingTime := OldGrowingTime * 0.4;
        return TempGrowingTime;

    Reset<public>() : void =
        Prop.Hide();
        Timer.Pause();
        Timer.Reset();

        if(PFNonNull := PlotFarmingBoosted?) {
            PFNonNull.EndBoostGrowingTime();
            set PlotFarmingBoosted = false;
        }

    OnTimerEnd<private>(Agent : ?agent) : void =
        set IsActiveBonus = false;
        Reset();
        
    Boost<public>(PlotFarmingToBoost : PlotFarming) : void =
        set PlotFarmingBoosted = option{PlotFarmingToBoost};
        if(PFNonNull := PlotFarmingBoosted?) {
            TempNewGrowingTime := CalcNewGrowingTime(PFNonNull.GrowingTime);
            PFNonNull.BoostGrowingTime(TempNewGrowingTime);
        }

        set IsActiveBonus = true;
        Prop.Show();
        
        Timer.Start();

SunBoostsManager := class(creative_device):

    @editable Button : button_device = button_device{};
    @editable GameManagerDev : GameManager = GameManager{};
    @editable BoostsPlot1 : []SunBoostItem = array{};
    @editable BoostsPlot2 : []SunBoostItem = array{};
    @editable BoostsPlot3 : []SunBoostItem = array{};
    @editable BoostsPlot4 : []SunBoostItem = array{};

    OnBegin<override>()<suspends>:void=
        Print(">BoostsManager");
        Button.InteractedWithEvent.Subscribe(OnPlayerBoost);
        InitAllBoosts();

    InitAllBoosts<private>() : void =
        for(Boost : BoostsPlot1 + BoostsPlot2 + BoostsPlot3 + BoostsPlot4) {
            Boost.Init();
            Boost.Hide();
        }

    GetBoostsListToPlayer(BaseManagerId : int) : ?[]SunBoostItem =
        case(BaseManagerId) {
            1 =>
                return option{BoostsPlot1};
            2 =>
                return option{BoostsPlot2};
            3 =>
                return option{BoostsPlot3};
            4 =>
                return option{BoostsPlot4};
            _=>
                return false;
        }

    OnPlayerBoost(Agent : agent) : void =
        PlayerBaseManager := GameManagerDev.GetBaseManagerDevice(Agent);
        PlayerBoostsList := GetBoostsListToPlayer(PlayerBaseManager.Id);
        if(PlayerBoostsListNonNull := PlayerBoostsList?) {
            TempBoostUI := SunBoostFastGrowingUI{BaseManagerDev := PlayerBaseManager, BoostsPlot := PlayerBoostsListNonNull};
            TempBoostUI.AddUI(Agent);
        }




