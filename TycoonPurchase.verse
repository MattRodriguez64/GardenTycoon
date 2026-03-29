
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }

TycoonPurchase := class:
    ### BASIC TYCOON PURCHASE DATA
    @editable Id<private> : int = -1;
    @editable CreativePropArray<private> : []creative_prop = array{};
    @editable NonCustomizablePropArray<private> : []creative_prop = array{};
    @editable Mutator<private> : mutator_zone_device = mutator_zone_device{};
    @editable ButtonProp<private> : creative_prop = creative_prop{};
    @editable Price<private> : int = -1;
    @editable MoneyEarnedPerSec<private> : int = -1;
    var NextPurchasesArray : []TycoonPurchase = array{};
    ### DEVICES PART
    @editable HasAnimationWith<private> : logic = false;
    @editable AnimationsAttachedToArray<private> : []cinematic_sequence_device = array{};
    @editable HasButtonDeviceWith<private> : logic = false;
    @editable ButtonDeviceArray<private> : []button_device = array{};
    @editable HasTimerDeviceWith<private> : logic = false;
    @editable TimerDevice<private> : timer_device = timer_device{};
    @editable HasPropManipDeviceWith<private> : logic = false;
    @editable PropManipDevice<private> : prop_manipulator_device = prop_manipulator_device{};
    @editable HasItemSpawnerDeviceWith<private> : logic = false;
    @editable ItemSpawnerDeviceArray : []item_spawner_device = array{};
    @editable HasBarrierDeviceWith : logic = false;
    @editable BarrierDeviceArray : []barrier_device = array{};
    @editable HasMutatorDeviceWith : logic = false;
    @editable MutatorDevice : mutator_zone_device = mutator_zone_device{};

    GetId<public>() : int =
        return Self.Id;

    GetCreativePropArray<public>() : []creative_prop =
        return Self.CreativePropArray;

    GetNonCustomizablePropArray<public>() : []creative_prop =
        return Self.NonCustomizablePropArray;

    GetMutator<public>() : mutator_zone_device =
        return Self.Mutator;

    GetButtonProp<public>() : creative_prop =
        return Self.ButtonProp;

    GetPrice<public>() : int =
        return Self.Price;

    GetMoneyEarnedPerSec<public>() : int = 
        return Self.MoneyEarnedPerSec;

    GetHasAnimationWith<public>() : logic =
        return Self.HasAnimationWith;

    GetAnimationsAttachedToArray<public>() : []cinematic_sequence_device =
        return Self.AnimationsAttachedToArray;

    GetHasButtonDeviceWith<public>() : logic =
        return Self.HasButtonDeviceWith;

    GetButtonDeviceArray<public>() : []button_device =
        return Self.ButtonDeviceArray;

    GetHasTimerDeviceWith<public>() : logic =
        return Self.HasTimerDeviceWith;

    GetTimerDevice<public>() : timer_device =
        return Self.TimerDevice;

    GetHasPropManipDeviceWith<public>() : logic =
        return Self.HasPropManipDeviceWith;

    GetPropManipDevice<public>() : prop_manipulator_device =
        return Self.PropManipDevice;

    GetHasItemSpawnerDeviceWith<public>() : logic =
        return Self.HasItemSpawnerDeviceWith;

    GetItemSpawnerDeviceArray<public>() : []item_spawner_device =
        return Self.ItemSpawnerDeviceArray;

    GetHasBarrierDeviceWith<public>() : logic =
        return Self.HasBarrierDeviceWith;

    GetBarrierDeviceArray<public>() : []barrier_device =
        return Self.BarrierDeviceArray;

    GetMutatorDevice<public>() : mutator_zone_device = return Self.MutatorDevice;

    GetNextPurchasesArray<public>() : []TycoonPurchase =
        return Self.NextPurchasesArray;

    SetNextPurchasesArray<public>(NextPurchases : []TycoonPurchase) : void =
        set Self.NextPurchasesArray = NextPurchases;

    AddNextPurchases<public>(NextPurchases : []TycoonPurchase) : void =
        set Self.NextPurchasesArray += NextPurchases;

    DisablePurchase<public>() : void =
        ButtonProp.Hide();
        Mutator.Disable();

    EnablePurchase<public>() : void =
        ButtonProp.Show();
        Mutator.Enable();

    OnPlayerBuy(Agent : agent, TempCurrentMoneyAccount : int, CurrentPlayer : ?player, IsUpgrade : logic) : int =
        if(CurrentFort := Agent.GetFortCharacter[], Owner := CurrentPlayer?, OwnerFort := Owner.GetFortCharacter[], CurrentFort <> OwnerFort) {
            return 0;
        }

        CurrentPropPrice := Self.GetPrice();
        if(TempCurrentMoneyAccount - CurrentPropPrice >= 0) {
            Self.ShowAllProps(IsUpgrade);
            if(not IsUpgrade?) {
                Self.DisablePurchase();
            }
            
            ### SET VISIBLE NEXT
            if(NextPurchasesArray.Length > 0) {
                for(NextPurchase : NextPurchasesArray) {
                    NextPurchase.EnablePurchase();
                }
            }
            return 1;
        } 
        return -1;
        
    ShowAllProps<public>(IsUpgrade : logic) : void =
        for(Prop : CreativePropArray) {
            Prop.Show();
        }

        if(NonCustomizablePropArray.Length > 0) {
            for(Prop : NonCustomizablePropArray) {
                Prop.Show();
            }
        }

        if(HasAnimationWith?) {
            for(CurrentAnimation : AnimationsAttachedToArray) {
                CurrentAnimation.Play();
            }
        }

        if(HasButtonDeviceWith? and not IsUpgrade?) {
            for(Button : ButtonDeviceArray) {
                Button.Enable();
            }
        }

        if(HasTimerDeviceWith?) {
            TimerDevice.Enable();
            TimerDevice.Start();
        }

        if(HasPropManipDeviceWith?) {
            PropManipDevice.Enable();
            PropManipDevice.ShowProps();
        }

        if(HasItemSpawnerDeviceWith?) {
            for(ItemSpawner : ItemSpawnerDeviceArray) {
                ItemSpawner.Enable();
                ItemSpawner.SpawnItem();
            }
        }

        # if(HasBarrierDeviceWith?) {
        #     for(Barrier : BarrierDeviceArray) {
        #         Barrier.Enable();
        #     }
        # }

        if(HasMutatorDeviceWith?) {
            MutatorDevice.Enable();
        }

    HideAllProps<public>() : void =
        for(Prop : CreativePropArray) {
            Prop.Hide();
        }

        if(NonCustomizablePropArray.Length > 0) {
            for(Prop : NonCustomizablePropArray) {
                Prop.Hide();
            }
        }

        if(HasAnimationWith?) {
            for(CurrentAnimation : AnimationsAttachedToArray) {
                CurrentAnimation.GoToEndAndStop();
            }
        }

        if(HasButtonDeviceWith?) {
            for(Button : ButtonDeviceArray) {
                Button.Disable();
            }
        }

        if(HasTimerDeviceWith?) {
            TimerDevice.Disable();
            TimerDevice.Pause();
            TimerDevice.Reset();
        }

        if(HasPropManipDeviceWith?) {
            PropManipDevice.Disable();
            PropManipDevice.HideProps();
        }

        if(HasItemSpawnerDeviceWith?) {
            for(ItemSpawner : ItemSpawnerDeviceArray) {
                ItemSpawner.Disable();
            }
        }

        if(HasBarrierDeviceWith?) {
            for(Barrier : BarrierDeviceArray) {
                Barrier.Disable();
            }
        }

        if(HasMutatorDeviceWith?) {
            MutatorDevice.Disable();
        }

    DisableAllBarrierDevice<public>() : void =
        if(HasBarrierDeviceWith?) {
            for(Barrier : BarrierDeviceArray) {
                Barrier.Disable();
            }
        }

    EnableAllBarrierDevice<public>() : void =
        if(HasBarrierDeviceWith?) {
            for(Barrier : BarrierDeviceArray) {
                Barrier.Enable();
            }
        }