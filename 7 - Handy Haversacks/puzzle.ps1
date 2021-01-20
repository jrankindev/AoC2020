#clear screen
Clear-Host

#grab input and put into arraylist
[System.Collections.ArrayList] $arrayFromFile = Get-Content pie.txt

<# sanitize input
get rid of shiny gold bag entry (not bags that can contain shiny gold bags)
get rid of bags that can contain no other bags
reformat each element for processing #>

#array to store sanitized input
[string[]] $sanitizedArrayFromFile = @()

#loop through array and filter bags that contain no other bags and the shiny gold entry then add to sanitized array
for ($i = 0; $i -lt $arrayFromFile.Count; $i++) { 
    if (-not ($arrayFromFile[$i].Contains("no")) -and -not ($arrayFromFile[$i].ToString().StartsWith("shiny gold"))) {
        $sanitizedArrayFromFile += $arrayFromFile[$i]
    }
}

#loop through sanitized array and format each element
for ($i = 0; $i -lt $sanitizedArrayFromFile.Count; $i++) {
    $sanitizedArrayFromFile[$i] = $sanitizedArrayFromFile[$i].Replace(" bags contain ",":")
    $sanitizedArrayFromFile[$i] = $sanitizedArrayFromFile[$i].Replace(" bag, ",":")
    $sanitizedArrayFromFile[$i] = $sanitizedArrayFromFile[$i].Replace(" bags, ",":")
    $sanitizedArrayFromFile[$i] = $sanitizedArrayFromFile[$i].Replace(" bags.","")
    $sanitizedArrayFromFile[$i] = $sanitizedArrayFromFile[$i].Replace(" bag.","")
    $sanitizedArrayFromFile[$i] = $sanitizedArrayFromFile[$i] -replace '\d\s',''
}

Write-Host " Part 1 "  -BackgroundColor "Green" -ForegroundColor "Black"
Write-Output "Total input: $($arrayFromFile.Count)"
Write-Output "Total sanitized input: $($sanitizedArrayFromFile.Count)"
Write-Output "Filtered: $($arrayFromFile.Count - $sanitizedArrayFromFile.Count)"

#search array to store entries we care about, preload with shiny gold
$searchArray = @('shiny gold')

#track if new bag was found
$newBagFound = 0

#loop through and add bags to searchArray until no new bags are found
$loopCounter = 1

do {
    $newBagFound = 0
    #loop through each line
    for ($i = 0; $i -lt $sanitizedArrayFromFile.Count; $i++) {
        #split into individual bags
        [string[]] $elementArray = $sanitizedArrayFromFile[$i].Split(":")
        #loop through each bag
        for ($x = 0; $x -lt $elementArray.Count; $x++) {
            $searchArray | ForEach-Object {
                #true if not first element and matches element in searcharray and first element is not already in searcharray
                if ($x -gt 0 -and $elementArray[$x] -match $_ -and (-not ($searchArray.Contains($elementArray[0])))) {
                    $searchArray += $elementArray[0]
                    $newBagFound++
                }
            }
        }
    }
    Write-Host "searchArray Count: $($searchArray.Count) Loops: $loopcounter"
    $loopCounter++
} while ($newBagFound -gt 0)

#minus 1 since it contains the initial search of shiny gold
$totalBags = $searchArray.Count - 1
Write-Host " How many bag colors can eventually contain at least one shiny gold bag? (P1 Answer): $totalBags `n" -BackgroundColor "Green" -ForegroundColor "Black"

#start part 2
Write-Host " Part 2 - NOT DONE "  -BackgroundColor "DarkYellow" -ForegroundColor "Black"
Write-Output "Total input: $($arrayFromFile.Count)"

#array to store sanitized input
[string[]] $sanitizedArrayFromFileP2 = $arrayFromFile

#loop through sanitized array and format each element
for ($i = 0; $i -lt $sanitizedArrayFromFileP2.Count; $i++) {
    $sanitizedArrayFromFileP2[$i] = $sanitizedArrayFromFileP2[$i].Replace(" bags contain ",":")
    $sanitizedArrayFromFileP2[$i] = $sanitizedArrayFromFileP2[$i].Replace(" bag, ",":")
    $sanitizedArrayFromFileP2[$i] = $sanitizedArrayFromFileP2[$i].Replace(" bags, ",":")
    $sanitizedArrayFromFileP2[$i] = $sanitizedArrayFromFileP2[$i].Replace(" bags.","")
    $sanitizedArrayFromFileP2[$i] = $sanitizedArrayFromFileP2[$i].Replace(" bag.","")
    $sanitizedArrayFromFileP2[$i] = $sanitizedArrayFromFileP2[$i].Replace("no other","none")
}

#bag counter
$bagsInShinyGoldBag = 0

#find how many bags are inside a shiny gold bag
foreach ($element in $sanitizedArrayFromFileP2) {
    if ($element.ToString().StartsWith("shiny gold")) {
        $element
        [string[]] $shinyGoldArray = $element.Split(":")
        for ($i = 1; $i -lt $shinyGoldArray.Count; $i++) {
            $bagsInShinyGoldBag = $bagsInShinyGoldBag + $shinyGoldArray[$i].Substring(0,1)
        }
    }
}
$bagsInShinyGoldBag

#show answer
#Write-Host ""
Write-Host " How many individual bags are required inside your single shiny gold bag? (P2 Answer): $bagsInShinyGoldBag `n"  -BackgroundColor "DarkYellow" -ForegroundColor "Black"