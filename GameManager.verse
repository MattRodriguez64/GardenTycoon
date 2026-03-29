
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Fortnite.com/FortPlayerUtilities }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
GameManager := class(creative_device):

    @editable CTS_DefaultTeam : class_and_team_selector_device = class_and_team_selector_device{};

    var IsPlayerHasPlot<private> : [player]logic = map{};

    @editable RemovePlayerCameraTimer : timer_device = timer_device{};
    @editable CameraBeforeGame : gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{};

    ### BASE MANAGER
    @editable BaseManagerDevices : []BaseManager = array{};

    @editable Timer_CloseMatchMaking : timer_device = timer_device{};

    @editable GameStartBarriersArr : []barrier_device = array{};

    # SPAWNER EVENT
    @editable SpawnerArr : []player_spawner_device = array{};
    @editable TeamSpawnerArr : []player_spawner_device = array{};

    @editable ButtonVIPZone : button_device = button_device{};
    @editable HudErrorVIPZone : hud_message_device = hud_message_device{};
    @editable TeleporterVIPZone : teleporter_device = teleporter_device{};
    @editable BarriersVIP : []barrier_device = array{};

    @editable Radio : radio_device = radio_device{};

    ### INVENTORY
    var PlayerInventoryMap : [player]Inventory = map{};

    @editable IslandCodeHud : hud_message_device = hud_message_device{};


    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded);
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved);
        Sleep(0.0);
        CTS_DefaultTeam.TeamSwitchedEvent.Subscribe(OnTeamSwitched);
        Timer_CloseMatchMaking.SuccessEvent.Subscribe(OnGameStarts);
        for(Spawner : SpawnerArr) {
            Spawner.SpawnedEvent.Subscribe(OnPlayerSpawn);
        }

        for(Spawner : TeamSpawnerArr) {
            Spawner.SpawnedEvent.Subscribe(OnPlayerTeamSpawn);
        }

        for(Player : GetPlayspace().GetPlayers()) {
            set IsPlayerHasPlot = ConcatenateMaps(IsPlayerHasPlot, map{Player => false});
            TempInv := Inventory{Player := Player};
            set PlayerInventoryMap = ConcatenateMaps(PlayerInventoryMap, map{Player => TempInv});
            PlayerInv := GetPlayerInventory(Player);
            if(PlayerInvNonNull := PlayerInv?) {
                PlayerInvNonNull.InitIventoryToPlayer();
            }
            CTS_DefaultTeam.ChangeTeam(Player);
            IslandCodeHud.Show(Player);
        }

    OnGameStarts(Agent : ?agent) : void =
        for(GameStartBarrier : GameStartBarriersArr) {
            GameStartBarrier.Disable();
            for(Player : GetPlayspace().GetPlayers()) {
                Radio.Register(Player);
            }
        }

    OnTeamSwitched(Agent : agent) : void =
        if (FortCharacter := Agent.GetFortCharacter[]){
            #Print("RESPAWN");
            FortCharacter.Damage(300.0);
        }
        Radio.Register(Agent);

    OnPlayerSpawn(Agent : agent) : void =
        Print(">OnPlayerSpawn");

    OnPlayerTeamSpawn(Agent : agent) : void =
        #Print(">OnPlayerTeamSpawn");
        for(BaseManagerDevice : BaseManagerDevices) {
            if(CurrentFort := Agent.GetFortCharacter[], Owner := BaseManagerDevice.GetCurrentPlayer()?, OwnerFort := Owner.GetFortCharacter[], CurrentFort = OwnerFort) {
                return;
            }
        }
        CTS_DefaultTeam.ChangeTeam(Agent);

    OnPlayerAdded(Player: player) : void =
        #Print(">GameManager : Player Added !");
        set IsPlayerHasPlot = ConcatenateMaps(IsPlayerHasPlot, map{Player => false});
        set PlayerInventoryMap = ConcatenateMaps(PlayerInventoryMap, map{Player => Inventory{Player := Player}});
        PlayerInv := GetPlayerInventory(Player);
        if(PlayerInvNonNull := PlayerInv?) {
            PlayerInvNonNull.InitIventoryToPlayer();
        }
        CTS_DefaultTeam.ChangeTeam(Player);
        Radio.Register(Player);
        IslandCodeHud.Show(Player);
    
    OnPlayerRemoved(Player: player) : void =
        #Print(">GameManager : Player Removed !");
        PlayerBaseM := GetBaseManagerDevice(Player);
        PlayerBaseM.SaveData(Player);

        for(CurrentPlayer -> PlayerInv : PlayerInventoryMap, CurrentPlayer <> Player) {
            set PlayerInventoryMap = ConcatenateMaps(PlayerInventoryMap, map{CurrentPlayer => PlayerInv});
        }

        for(CurrentPlayer -> HasPlotLogic : IsPlayerHasPlot, CurrentPlayer <> Player) {
            set IsPlayerHasPlot = ConcatenateMaps(IsPlayerHasPlot, map{CurrentPlayer => HasPlotLogic});
        }

        PlayerBaseM.ResetPlot(false);

    RemovePlotToPlayer(Player : player) : void =
        for(CurrentPlayer -> HasPlotLogic : IsPlayerHasPlot, CurrentPlayer <> Player) {
            set IsPlayerHasPlot = ConcatenateMaps(IsPlayerHasPlot, map{CurrentPlayer => HasPlotLogic});
        }

    GetIsPlayerHasPlot<public>() : [player]logic =
        #Print(">GetIsPlayerHasPlot");
        return IsPlayerHasPlot;

    SetIsPlayerHasPlot<public>(NewMap : [player]logic) : void =
        #Print(">SetIsPlayerHasPlot");
        set IsPlayerHasPlot = NewMap;

    CheckIsPlayerHasPlot<public>(Player : player)<transacts> : logic =
        for(CurrentPlayer -> HasPlot : IsPlayerHasPlot) {
            if(CurrentPlayer = Player) {
                return HasPlot;
            }
        }
        return false;

    AddPlayerPlot<public>(Player : player) : void =
        #Print(">AddPlayerPlot");
        for(CurrentPlayer -> HasPlot : IsPlayerHasPlot) {
            if(CurrentPlayer = Player) {
                if(set IsPlayerHasPlot[Player] = true) {
                    Print(">HasPlot Value set to true !");
                    Radio.Register(Player);
                }
            }
        }

    ### INVENTORY
    GetPlayerInventory<public>(Player : player) : ?Inventory = 
        for(CurrentPlayer -> CurrentInv : PlayerInventoryMap) {
            if(CurrentPlayer = Player) {
                return option{CurrentInv};
            }
        }
        return false;

    GetPlayerTeam<public>(Agent : agent) : ?team =
        #Print(">GetPlayerTeam");
        TeamCollection := GetPlayspace().GetTeamCollection();
        if (AgentsTeam := TeamCollection.GetTeam[Agent]) {
            TeamArray := TeamCollection.GetTeams();
            for (TeamNumber->Team : TeamArray) {
                if (AgentsTeam = Team) {
                    return option{Team};
                }
            }
        }
        return false;

    GetBaseManagerDevice(Agent : agent) : BaseManager =
        #Print(">GetBaseManagerDevice");
        for(BaseManagerDevice : BaseManagerDevices) {
            if(CurrentFort := Agent.GetFortCharacter[], Owner := BaseManagerDevice.GetCurrentPlayer()?, OwnerFort := Owner.GetFortCharacter[], CurrentFort = OwnerFort) {
                return BaseManagerDevice;
            }
        }
        return BaseManager{};

    GetAllBaseManager<public>() : []BaseManager = return Self.BaseManagerDevices;




