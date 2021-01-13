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
    if (
        $elementArray -like "ecl:*" -and 
        $elementArray -like "pid:*" -and 
        $elementArray -like "eyr:*" -and 
        $elementArray -like "hcl:*" -and 
        $elementArray -like "byr:*" -and 
        $elementArray -like "iyr:*" -and 
        $elementArray -like "hgt:*"
    ) {
        
        $splitElementTracker = 0
        foreach ($splitElement in $elementArray) {
            
            if ($splitElement -like "byr:*") {
                $tempVar = $splitElement.Remove(0,4)
                if ($tempVar -ge 1920 -and $tempVar -le 2002) {
                    $splitElementTracker++
                }
            }

            if ($splitElement -like "iyr:*") {
                $tempVar = $splitElement.Remove(0,4)
                if ($tempVar -ge 2010 -and $tempVar -le 2020) {
                    $splitElementTracker++
                } 
            }

            if ($splitElement -like "eyr:*") {
                $tempVar = $splitElement.Remove(0,4)
                if ($tempVar -ge 2020 -and $tempVar -le 2030) {
                    $splitElementTracker++
                }
            }
            
            if ($splitElement -like "hgt:*") {
                $tempVar = $splitElement.Remove(0,4)
                $tempVarNum = $tempVar.Substring(0,$tempVar.Length - 2)
                $tempVarUnits = $tempVar.Substring($tempVar.Length - 2, 2)
                if ($tempVarUnits -eq "cm" -and $tempVarNum -ge 150 -and $tempVarNum -le 193) {
                    $splitElementTracker++
                } elseif ($tempVarUnits -eq "in" -and $tempVarNum -ge 59 -and $tempVarNum -le 76) {
                    $splitElementTracker++
                }
            }
            
            if ($splitElement -like "hcl:*") {
                $tempVar = $splitElement.Remove(0,4)
                if ($tempVar -match '#([0-9]|[a-f]){6}') {
                    $splitElementTracker++
                }
            }
            
            if ($splitElement -like "ecl:*") {
                $tempVar = $splitElement.Remove(0,4)
                if ($tempVar -match '(amb|blu|brn|gry|grn|hzl|oth)') {
                    $splitElementTracker++
                }
            }

            if ($splitElement -like "pid:*") {
                $tempVar = $splitElement.Remove(0,4)
                [Int] $tempVarInt = $null
                if ([Int]::TryParse($tempVar,[ref]$tempVarInt)) {
                    if ($tempVar.Length -eq 9) {
                        $splitElementTracker++
                    }
                }
            }

        }

        if ($splitElementTracker -eq 7) {
            $validPassports++
            Write-Output "VALID PASSPORT"
        } else {
            Write-Output "INVALID PASSPORT"
        }
        Write-Output "Split Element Tracker: $splitElementTracker"
        Write-Output ""
    }
}

Write-Output ""
Write-Output "Total VALID Passports: $validPassports"
Write-Output "Total pass first validation: $($passFirstValidationArrayList.Count)"
Write-Output "Total to start: $($arrayListFromFile.Count)"