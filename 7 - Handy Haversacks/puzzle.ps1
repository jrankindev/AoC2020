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
}

$sanitizedArrayFromFile
Write-Output ""
Write-Output "Total input: $($arrayFromFile.Count)"
Write-Output "Total sanitized input: $($sanitizedArrayFromFile.Count)"
Write-Output "Filtered: $($arrayFromFile.Count - $sanitizedArrayFromFile.Count) `n"

#search array to store entries we care about, preload with shiny gold
$searchArray = @("shiny gold")

foreach ($element in $sanitizedArrayFromFile) {
    if ($element -match $searchArray) {
        Write-Output "MATCH -> $element"
    }
}