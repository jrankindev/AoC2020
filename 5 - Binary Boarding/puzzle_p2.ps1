Clear-Host

#get input into array
[String[]] $arrayFromFile = Get-Content pi.txt

#loop through array
for ($i = 0; $i -lt $arrayFromFile.Length; $i++) {
    #replace the letters with their binary equivalent
    $arrayFromFile[$i] = $arrayFromFile[$i].Replace("F",0)
    $arrayFromFile[$i] = $arrayFromFile[$i].Replace("B",1)
    $arrayFromFile[$i] = $arrayFromFile[$i].Replace("L",0)
    $arrayFromFile[$i] = $arrayFromFile[$i].Replace("R",1)
    #now that we have a binary number, convert it to decimal
    $seatID = [convert]::ToInt32($arrayFromFile[$i],2)
    #put decimal seat value back into array
    $arrayFromFile[$i] = $seatID
}

#create new array with int type from old string array
[int[]] $decArray = $arrayFromFile

#find min and max array values
$minValue = $decArray | Sort-Object | Select-Object -First 1
$maxValue = $decArray | Sort-Object | Select-Object -Last 1

#create new array using the range of values in the previous array
[int[]] $decArrayCompare = $minValue..$maxValue

#find the missing number in decArray by comparing it to the created array using the range
$mySeat = $decArrayCompare | Where-Object {-not ($decArray -contains $_)}
Write-Output "My seat ID is: $mySeat"