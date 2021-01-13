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

#sort out all values from the array and show last one (highest)
Write-Output "Highest Seat ID: $($decArray | Sort-Object | Select-Object -Last 1)"