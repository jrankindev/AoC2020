#clear screen
cls

#grab input and put into arraylist
[System.Collections.ArrayList] $arrayFromFile = Get-Content pie.txt

#sanitize input
#get rid of shiny gold bag entry (not bags that can contain shiny gold bags)
#get rid of bags that can contain no other bags

for ($i = 0; $i -lt $arrayFromFile.Count; $i++) { 
    if ($arrayFromFile[$i].Contains("no")) {
        $arrayFromFile[$i]
        echo "TRUE"
        $arrayFromFile.Remove($arrayFromFile[$i])
    }
}

#search array
$searchArray = @("shiny gold")

#replace no with 0
for ($i = 0; $i -lt $arrayFromFile.Count; $i++) { 
    #$arrayFromFile[$i] = $arrayFromFile[$i].Replace("no","0")

    <#if ($arrayFromFile[$i] -match $searchArray) {
        echo "TRUE -> $($arrayFromFile[$i])"
    } else {
        echo "FALSE -> $($arrayFromFile[$i])"
    }#>
    
}

$arrayFromFile

#$arrayFromFile -match $searchArray
#echo ""
#$arrayFromFile -notmatch $searchArray

#foreach ($element