

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }

ColorPicker := class:

    var AllWalls : []TycoonPurchase = array{};
    var AllColorsMat : []material = array{Materials.M_BuildingColor0, Materials.M_BuildingColor1, Materials.M_BuildingColor2, Materials.M_BuildingColor3, 
    Materials.M_BuildingColor4, Materials.M_BuildingColor5, Materials.M_BuildingColor6, Materials.M_BuildingColor7, Materials.M_BuildingColor8, Materials.M_BuildingColor9, 
    Materials.M_BuildingColor10, Materials.M_BuildingColor11, Materials.M_BuildingColor12, Materials.M_BuildingColor13};
    var DefaultColorsMat : material = Materials.M_BuildingColor2;

    Reset() : void =
        Print(">Reset");
        for(CurrentWall : AllWalls) {
            AllCurrentWallsInst := CurrentWall.GetCreativePropArray();
            CurrentWallInstId := CurrentWall.GetId();
            for(CurrentWallInst : AllCurrentWallsInst) {
                CurrentWallInst.SetMaterial(DefaultColorsMat, ?Index := 0);
            }
        }
        
    SetColor(Index : int) : void =
        Print(">ResetColor");
        if(GetCurrentMat := AllColorsMat[Index]) {
            for(CurrentWall : AllWalls) {
                AllCurrentWallsInst := CurrentWall.GetCreativePropArray();
                CurrentWallInstId := CurrentWall.GetId();
                for(CurrentWallInst : AllCurrentWallsInst) {
                    CurrentWallInst.SetMaterial(GetCurrentMat, ?Index := 0);
                }
            }
        }

    AddWalls(TempAllWalls : []TycoonPurchase) : void = set Self.AllWalls += TempAllWalls;