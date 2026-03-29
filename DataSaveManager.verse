
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }

# player_data
player_data := class<final><persistable> {
    Money : int = 0;
    LoginCounter : int = 0;
    PurchasesMadeArray : []int = array{};
    FarmUpgradesArray : []int = array{};
    RebirthCounter : int = 0;
    BuildColorBought : []int = array{};
    CurrentLevel : int = 0;
    CurrentXp : int = 0;
    CurrentNextLevelXpNeeded : int = 0;
    InvSlot1 : tuple(int, float) = (-1, 0.0);
    InvSlot2 : tuple(int, float) = (-1, 0.0);
    InvSlot3 : tuple(int, float) = (-1, 0.0);
    InvSlot4 : tuple(int, float) = (-1, 0.0);
    InvSlot5 : tuple(int, float) = (-1, 0.0);
    InvSlot6 : tuple(int, float) = (-1, 0.0);
    InvSlot7 : tuple(int, float) = (-1, 0.0);
    InvSlot8 : tuple(int, float) = (-1, 0.0);
    InvSlot9 : tuple(int, float) = (-1, 0.0);
    PetsBought : []int = array{};
    TrailsBought : []int = array{};
    RainbowCrops : []tuple(int, int) = array{};
    SunMoney : int = 0;
    SquidCoin : int = 0;
}

# player_data_update
player_data_update<constructor>(OldStat : player_data, 
NewMoney : int, NewLoginCounter : int,  NewPurchasesMadeArray : []int, NewFarmUpgradesArray : []int, NewRebirthCounter : int,
NewBuildColorBought : []int, NewCurrentLevel : int, NewCurrentXp : int, NewCurrentNextLevelXpNeeded : int, 
NewInvSlot1 : tuple(int, float),  NewInvSlot2 : tuple(int, float),  NewInvSlot3 : tuple(int, float),  NewInvSlot4 : tuple(int, float),
NewInvSlot5 : tuple(int, float), NewInvSlot6 : tuple(int, float), NewInvSlot7 : tuple(int, float), NewInvSlot8 : tuple(int, float), NewInvSlot9 : tuple(int, float), 
NewPetsBought : []int, NewTrailsBought : []int, NewSunMoney : int, NewRainbowCrops : []tuple(int, int), NewSquidCoin : int)<transacts> := player_data {
    Money := NewMoney;
    LoginCounter := NewLoginCounter;
    PurchasesMadeArray := NewPurchasesMadeArray;
    FarmUpgradesArray := NewFarmUpgradesArray;
    RebirthCounter := NewRebirthCounter;
    BuildColorBought := NewBuildColorBought;
    CurrentLevel := NewCurrentLevel;
    CurrentXp := NewCurrentXp;
    CurrentNextLevelXpNeeded := NewCurrentNextLevelXpNeeded;
    InvSlot1 := NewInvSlot1;
    InvSlot2 := NewInvSlot2;
    InvSlot3 := NewInvSlot3;
    InvSlot4 := NewInvSlot4;
    InvSlot5 := NewInvSlot5;
    InvSlot6 := NewInvSlot6;
    InvSlot7 := NewInvSlot7;
    InvSlot8 := NewInvSlot8;
    InvSlot9 := NewInvSlot9;
    PetsBought := NewPetsBought;
    TrailsBought := NewTrailsBought;
    RainbowCrops := NewRainbowCrops;
    SunMoney := NewSunMoney;
    SquidCoin := NewSquidCoin;
}


MakePlayerProfileData<constructor>(Src:player_data)<transacts> := player_data:
    Money := Src.Money;
    LoginCounter := Src.LoginCounter;
    PurchasesMadeArray := Src.PurchasesMadeArray;
    FarmUpgradesArray := Src.FarmUpgradesArray;
    RebirthCounter := Src.RebirthCounter;
    BuildColorBought := Src.BuildColorBought;
    CurrentLevel := Src.CurrentLevel;
    CurrentXp := Src.CurrentXp;
    CurrentNextLevelXpNeeded := Src.CurrentNextLevelXpNeeded;
    InvSlot1 := Src.InvSlot1;
    InvSlot2 := Src.InvSlot2;
    InvSlot3 := Src.InvSlot3;
    InvSlot4 := Src.InvSlot4;
    InvSlot5 := Src.InvSlot5;
    InvSlot6 := Src.InvSlot6;
    InvSlot7 := Src.InvSlot7;
    InvSlot8 := Src.InvSlot8;
    InvSlot9 := Src.InvSlot9;
    PetsBought := Src.PetsBought;
    TrailsBought := Src.TrailsBought;
    RainbowCrops := Src.RainbowCrops;
    SunMoney := Src.SunMoney;
    SquidCoin := Src.SquidCoin;

var SavedDataPlayer : weak_map(player, player_data) = map{};

DataSaveManager := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print("DataSaveManager");

    CheckDataPlayer(Player : player) : void =
        Print(">CheckDataPlayer");
        if(not SavedDataPlayer[Player]) {
            if(set SavedDataPlayer[Player] = player_data{}) {
                Print(">NEW Player_Data created !");
            }
        }
        
    SaveDataPlayer(Player : player, NewMoney : int, NewLoginCounter : int, NewPurchasesMadeArray : []int, NewFarmUpgradesArray : []int, NewRebirthCounter : int,
    NewBuildColorBought : []int, NewCurrentLevel : int, NewCurrentXp : int, NewCurrentNextLevelXpNeeded : int, NewInvSlot1 : tuple(int, float),  NewInvSlot2 : tuple(int, float),  NewInvSlot3 : tuple(int, float),  NewInvSlot4 : tuple(int, float),
    NewInvSlot5 : tuple(int, float), NewInvSlot6 : tuple(int, float), NewInvSlot7 : tuple(int, float), NewInvSlot8 : tuple(int, float), NewInvSlot9 : tuple(int, float),
    NewPetsBought : []int, NewTrailsBought : []int, NewSunMoney : int, NewRainbowCrops : []tuple(int, int), NewSquidCoin : int) : void =
        #Print(">SaveDataPlayer");
        if(CurrentPlayerData := SavedDataPlayer[Player]) {
            # if(FitsInPlayerMap[NewPetsBought]) {
            #     Print("TRUE");
            # }

            if(set SavedDataPlayer[Player] = player_data{player_data_update<constructor>(CurrentPlayerData, NewMoney, NewLoginCounter, NewPurchasesMadeArray, NewFarmUpgradesArray, NewRebirthCounter,
                NewBuildColorBought, NewCurrentLevel, NewCurrentXp, NewCurrentNextLevelXpNeeded, NewInvSlot1, NewInvSlot2, NewInvSlot3, NewInvSlot4, NewInvSlot5,
                NewInvSlot6, NewInvSlot7, NewInvSlot8, NewInvSlot9, NewPetsBought, NewTrailsBought, NewSunMoney, NewRainbowCrops, NewSquidCoin)
                Money := NewMoney;
                LoginCounter := NewLoginCounter;
                PurchasesMadeArray := NewPurchasesMadeArray;
                FarmUpgradesArray := NewFarmUpgradesArray;
                RebirthCounter := NewRebirthCounter;
                BuildColorBought := NewBuildColorBought;
                CurrentLevel := NewCurrentLevel;
                CurrentXp := NewCurrentXp;
                CurrentNextLevelXpNeeded := NewCurrentNextLevelXpNeeded;
                InvSlot1 := NewInvSlot1;
                InvSlot2 := NewInvSlot2;
                InvSlot3 := NewInvSlot3;
                InvSlot4 := NewInvSlot4;
                InvSlot5 := NewInvSlot5;
                InvSlot6 := NewInvSlot6;
                InvSlot7 := NewInvSlot7;
                InvSlot8 := NewInvSlot8;
                InvSlot9 := NewInvSlot9;
                PetsBought := NewPetsBought;
                TrailsBought := NewTrailsBought;
                SunMoney := NewSunMoney;
                SquidCoin := NewSquidCoin;
            }) {
                Print(">SAVED");
            }

            SavePet(Player, NewPetsBought);
            SaveTrailBought(Player, NewTrailsBought);
            SaveSunMoney(Player, NewSunMoney);
            SaveSquidCoin(Player, NewSquidCoin);
            SaveRainbowCrops(Player, NewRainbowCrops);
            #SaveColorBought(Player, array{1});
        }

    GetPlayerData(Player : player) : player_data =
        if(CurrentDataPlayer := SavedDataPlayer[Player]) {
            return CurrentDataPlayer;
        }
        return player_data{};

    SavePet(Agent:agent, PetsId : []int):void=
        if:
            CheckSaveDataForPlayer[Agent]
            Player := player[Agent]
            SourceData := SavedDataPlayer[Player]
            set SavedDataPlayer[Player] = player_data:
                MakePlayerProfileData<constructor>(SourceData)
                PetsBought := PetsId;
        else:
            Print("ERROR");

    SaveColorBought(Agent:agent, ColorsId : []int):void=
        if:
            CheckSaveDataForPlayer[Agent]
            Player := player[Agent]
            SourceData := SavedDataPlayer[Player]
            set SavedDataPlayer[Player] = player_data:
                MakePlayerProfileData<constructor>(SourceData)
                BuildColorBought := ColorsId;
        else:
            Print("ERROR");

    SaveTrailBought(Agent:agent, TrailId : []int):void=
        if:
            CheckSaveDataForPlayer[Agent]
            Player := player[Agent]
            SourceData := SavedDataPlayer[Player]
            set SavedDataPlayer[Player] = player_data:
                MakePlayerProfileData<constructor>(SourceData)
                TrailsBought := TrailId;
        else:
            Print("ERROR");

    SaveSunMoney(Agent:agent, SunAmount : int):void=
        if:
            CheckSaveDataForPlayer[Agent]
            Player := player[Agent]
            SourceData := SavedDataPlayer[Player]
            set SavedDataPlayer[Player] = player_data:
                MakePlayerProfileData<constructor>(SourceData)
                SunMoney := SunAmount;
        else:
            Print("ERROR");

    SaveSquidCoin(Agent:agent, SquidCoinAmount : int):void=
        if:
            CheckSaveDataForPlayer[Agent]
            Player := player[Agent]
            SourceData := SavedDataPlayer[Player]
            set SavedDataPlayer[Player] = player_data:
                MakePlayerProfileData<constructor>(SourceData)
                SquidCoin := SquidCoinAmount;
        else:
            Print("ERROR");

    SaveRainbowCrops(Agent:agent, RainbowCropsToSave : []tuple(int, int)):void=
        if:
            CheckSaveDataForPlayer[Agent]
            Player := player[Agent]
            SourceData := SavedDataPlayer[Player]
            set SavedDataPlayer[Player] = player_data:
                MakePlayerProfileData<constructor>(SourceData)
                RainbowCrops := RainbowCropsToSave;
        else:
            Print("ERROR");

    CheckSaveDataForPlayer(Agent:agent)<decides><transacts>:void=
        if(Player := player[Agent]):
            if(SavedDataPlayer[Player]):
                #Print("PLAYER DATA FOUND!");
            else:
                set SavedDataPlayer[Player] = player_data{}