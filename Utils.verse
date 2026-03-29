
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


Utils := class:
    Partition<private>(Array : []int, Low : int, High : int) : int =

        var TempArray : []int = Array;
        var Pivot : int = 0;
        if(GetHighValue := Array[High]) {
            set Pivot = GetHighValue;
        }

        var I : int = Low;
        for(J := Low..High) {
            if(GetValueAtJ := Array[J]) {
                if(GetValueAtJ < Pivot) {
                    set I += 1;
                    set TempArray = Swap(TempArray, I, J);
                }
            }
        }

        set TempArray = Swap(TempArray, I + 1, High);

        return I + 1;

    Swap<private>(Array : []int, I : int, J : int) : []int =
        var TempArray : []int = Array;
        if(Temp := Array[I]) {
            if(ValueAtJ := Array[J], set TempArray[I] = ValueAtJ) {}
            if(set TempArray[J] = Temp) {}
        }
        return TempArray;

    QuickSort<public>(Array : []int, Low : int, High : int) : []int =
        var TempArray : []int = Array;
        if(Low < High) {
            var PartitionIndex : int = Partition(TempArray, Low, High);
            set TempArray = QuickSort(TempArray, Low, PartitionIndex - 1);
            set TempArray = QuickSort(TempArray, PartitionIndex + 1, High);
        }
        return TempArray;

    BubbleSort<public>(Array : []int, N : int) : []int =
        var TempArray : []int = Array;
        var Temp : int = 0;
        var Swapped : logic = false;

        for(I := 0..N - 1) {
            set Swapped = false;
            for(J := 0..N - I - 1) {
                if(ValueAtJ := TempArray[J], ValueAtJPlusOne := TempArray[J + 1]) {
                    if(ValueAtJ > ValueAtJPlusOne) {
                        set Temp = ValueAtJ;
                        if(set TempArray[J] = ValueAtJPlusOne) {}
                        if(set TempArray[J + 1] = Temp) {}
                        set Swapped = true;
                    }
                }
            }
        }

        return TempArray;


