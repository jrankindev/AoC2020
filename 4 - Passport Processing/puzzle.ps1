Clear-Host

#grab the raw input and store into a variable
$rawInputString = Get-Content pi.txt -Raw

#split the string into array of lines
#split the whole text into an array where there are two or more linefeeds via regex
$stringsToJoin = $rawInputString -split "(\r*\n){2,}"

#remove linefeeds and replace with a space into a string array
[string[]] $arrayFromFile = $stringsToJoin -replace '\r*\n', ' '

#due to regular array limitations, we need an arraylist. create a blank one and add the range of the string array
$arrayListFromFile = New-Object System.Collections.ArrayList($null)
$arrayListFromFile.AddRange($arrayFromFile)

#get current count
$arrayListLength = $arrayListFromFile.Count

#loop arraylist to remove the blank lines
for ($i = 0; $i -le $arrayListLength; $i++) {
    if ($arrayListFromFile[$i] -eq " ") {
        $arrayListFromFile.Remove($arrayListFromFile[$i])
    }
}

#loop through each element (passport) and check for each required entry except for cid since it is optional
#keep track of how many valid passports
$validPassports = 0
foreach ($element in $arrayListFromFile) {
    [string[]] $elementArray = $element.Split(" ")
    Write-Output $elementArray
    if (
        $elementArray -like "ecl:*" -and 
        $elementArray -like "pid:*" -and 
        $elementArray -like "eyr:*" -and 
        $elementArray -like "hcl:*" -and 
        $elementArray -like "byr:*" -and 
        $elementArray -like "iyr:*" -and 
        $elementArray -like "hgt:*"
    ) {
        Write-Output "VALID"
        $validPassports++
    } else {
        Write-Output "INVALID"
    }
    Write-Output ""
}

Write-Output "Total VALID Passports: $validPassports"