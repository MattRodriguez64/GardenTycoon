
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


GlassBridgePart := class:
    @editable Id : int = -1;
    @editable Mutator : mutator_zone_device = mutator_zone_device{};
    @editable CreativeProp : creative_prop = creative_prop{};
    var IsActive : logic = true;


(Listenable : listenable(agent)).SubscribeAgent(OutputFunc : tuple(agent, t)->void, ExtraData : t where t:type) : cancelable =
    Wrapper := wrapper_agent(t){ExtraData := ExtraData, OutputFunc := OutputFunc}
    Listenable.Subscribe(Wrapper.InputFunc)
    
wrapper_agent(t : type) := class():
    ExtraData : t;
    OutputFunc : tuple(agent, t) -> void
    InputFunc(Agent : agent):void = OutputFunc(Agent, ExtraData)

(Listenable : listenable(tuple())).SubscribeEmpty(OutputFunc : t -> void, ExtraData : t where t:type) : cancelable =
    Wrapper := wrapper_empty(t) {ExtraData := ExtraData, OutputFunc := OutputFunc}
    Listenable.Subscribe(Wrapper.InputFunc)

wrapper_empty(t : type) := class():
    ExtraData : t;
    OutputFunc : t -> void
    InputFunc():void = OutputFunc(ExtraData)


GlassBridgeManager := class(creative_device):

    @editable TimerReset : timer_device = timer_device{};
    @editable GlassBridgePartArray : []GlassBridgePart = array{};

    OnBegin<override>()<suspends>:void=
        Print(">GlassBridgeManager");

        TimerReset.SuccessEvent.Subscribe(OnResetGlassBridge);
        for(Index := 0..GlassBridgePartArray.Length - 1) {
            if(CurrentGlassBridgePart := GlassBridgePartArray[Index]) {
                CurrentGlassBridgePart.Mutator.AgentEntersEvent.SubscribeAgent(OnPlayerEnterZone, Index);
            }
        }

    OnPlayerEnterZone(Agent : agent, Index : int) : void =
        Print("Index : {Index}");
        if(CurrentGlassBridgePart := GlassBridgePartArray[Index]) {
            if(CurrentGlassBridgePart.IsActive?) {
                set CurrentGlassBridgePart.IsActive = false;
                CurrentGlassBridgePart.Mutator.Disable();
                CurrentGlassBridgePart.CreativeProp.Hide();
            }
        }

    OnResetGlassBridge(Agent : ?agent) : void =
        for(CurrentGlassBridgePart : GlassBridgePartArray) {
            set CurrentGlassBridgePart.IsActive = true;
            CurrentGlassBridgePart.Mutator.Enable();
            CurrentGlassBridgePart.CreativeProp.Show();
        }
        

