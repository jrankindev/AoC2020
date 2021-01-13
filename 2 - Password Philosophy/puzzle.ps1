Clear-Host

#grab input and put into array
[string[]] $arrayFromFile = Get-Content pi.txt

#counter
$evalPassTrue = 0

foreach ($element in $arrayFromFile) {

    #split each element into 3 parts
    [string[]] $arrayFromElement = $element.Split(" ")

    #further split so we can get min and max values for character
    [int[]] $arrayMinMax = $arrayFromElement[0].Split("-")
    
    #remove tailing colon
    $arrayFromElement[1] = $arrayFromElement[1].Remove(1,1)
    
    Write-Output "Minimum use: $($arrayMinMax[0])"
    Write-Output "Maximum use: $($arrayMinMax[1])"
    Write-Output "Letter rule: $($arrayFromElement[1])"
    Write-Output "Password: $($arrayFromElement[2])"

    #evaluate how many of letter rule is in the password
    $letterRuleVal = ($arrayFromElement[2].Split($arrayFromElement[1])).count-1
    Write-Output "Occurences: $letterRuleVal"
    
    #check if password is good or not and pass to counter
    if ($letterRuleVal -ne 0 -and $letterRuleVal -ge $arrayMinMax[0] -and $letterRuleVal -le $arrayMinMax[1]) {
        $evalPassTrue++
        Write-Output "Eval: True"
    } else {
        Write-Output "Eval: False"
    }

    Write-Output ""

}

Write-Output "Total true eval: $evalPassTrue"