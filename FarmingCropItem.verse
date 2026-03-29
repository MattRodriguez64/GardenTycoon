
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Concurrency }
using { /Verse.org/Random }
using { /Verse.org/Assets }
using { /Fortnite.com/Devices/CreativeAnimation }
using { /Fortnite.com/Devices/CreativeAnimation/InterpolationTypes }


RainbowMaterial : material = Materials.M_RainbowItem;
AllCropsMaterial : material = Materials.M_PandaMat;
SunMaterial : material = Materials.M_Sun;
PeachMaterial : material = Materials.M_Peach;
PineappleMaterial : material = Materials.M_Pineapple;
SquidMaterial : material = Materials.M_SquidCrop;


FarmingCropItem := class<concrete>:
    ### CONSTANTES
    MAX_RAINBOW_VALUE : int = 200;
    MAX_EVENTCROP_VALUE : int = 800;
    ### VARIABLES
    @editable Id : int = -1;
    @editable var Prop : creative_prop = creative_prop{};
    var Weight : float = 0.0;
    var ItemImage : texture = UI.EmptySlotImage;
    var IsRainbow : logic = false;
    var RainbowPercentage : int = 1;
    var IsEventCrop : logic = false;
    var EventCropPercentage : int = 1;

    GetId<public>() : int = return Self.Id;

    GetProp<public>() : creative_prop = return Self.Prop;

    GetWeight<public>() : float = return Self.Weight;
    SetWeight<public>(New : float) : void = set Self.Weight = New;

    GetItemImage<public>() : texture = return Self.ItemImage;
    SetItemImage<public>(Image : texture) : void = set Self.ItemImage = Image;

    GetIsRainbow<public>() : logic = return Self.IsRainbow;
    SetIsRainbow<public>(New : logic) : void = set Self.IsRainbow = New;

    GetIsEventCrop<public>() : logic = return Self.IsEventCrop;
    SetIsEventCrop<public>(New : logic) : void = set Self.IsEventCrop = New;

    SetEventCropProp<public>() : void =
        SetIsEventCrop(true);
        Prop.SetMaterial(SquidMaterial);

    SetRainbowProp<public>() : void =
        SetIsRainbow(true);
        Prop.SetMaterial(RainbowMaterial);

    GenerateWeight<private>() : void =
        var TempWeight : float = 0.0;
        TempWeightLow := GetRandomInt(28, 82);
        TempWeightHigh := GetRandomInt(82, 142);

        HighDropValue := GetRandomInt(0, 10);
        if(HighDropValue <= 9) {
            set TempWeight = (TempWeightLow * 1.0) / 100.0;
        } else {
            set TempWeight = (TempWeightHigh * 1.0) / 100.0;
        }
        SetWeight(TempWeight);

    Reset<public>() : void =
        NewTransform : transform = transform{
            Translation := Prop.GetTransform().Translation,
            Rotation := Prop.GetTransform().Rotation,
            Scale := vector3{X:=0.001, Y:=0.001, Z:=0.001};
        };
        GenerateWeight();

        if(IsRainbow? or IsEventCrop?) {
            SetIsRainbow(false);
            SetIsEventCrop(false);
            if(Self.Id < 11) {
                Prop.SetMaterial(AllCropsMaterial);
            } else if(Self.Id = 11) {
                Prop.SetMaterial(PeachMaterial);
            } else if(Self.Id = 12) {
                Prop.SetMaterial(PineappleMaterial);
            }
        } 

        TempEventCrop := GetRandomInt(0, MAX_EVENTCROP_VALUE);
        if(TempEventCrop < EventCropPercentage) {
            SetIsEventCrop(true);
            Prop.SetMaterial(SquidMaterial);
        } else {
            TempRainbow := GetRandomInt(0, MAX_RAINBOW_VALUE);
            if(TempRainbow < RainbowPercentage) {
                SetIsRainbow(true);
                Prop.SetMaterial(RainbowMaterial);
            }
        }

        if(Prop.TeleportTo[NewTransform]) {}

    Grow<public>(Duration : float, AnimationController : animation_controller) : void =
        NewSize : float =  if(Weight <= 1.0) then 1000.0 else 1000.0 + (100.0 * GetWeight());
        AnimationKeyframe : keyframe_delta = keyframe_delta {
            DeltaLocation := vector3{X:=0.0, Y:=0.0, Z:=0.0};
            DeltaRotation := IdentityRotation();
            DeltaScale := vector3{X:=NewSize, Y:=NewSize, Z:=NewSize}
            Time := Duration;
            Interpolation := Linear;
        }

        AnimationController.SetAnimation(array{AnimationKeyframe}, ?Mode := animation_mode.OneShot);
        AnimationController.Play();

    DefaultReset<public>(AnimationController : animation_controller) : void =
        AnimationController.Pause();
        Reset();

            
