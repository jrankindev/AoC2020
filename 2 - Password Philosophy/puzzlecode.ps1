cls

#grab input and put into array
[string[]] $arrayFromFile = Get-Content puzzleinput.txt

#counter
$evalPassTrue = 0

foreach ($element in $arrayFromFile) {

    #split each element into 3 parts
    [string[]] $arrayFromElement = $element.Split(" ")

    #further split so we can get min and max values for character
    [int[]] $arrayMinMax = $arrayFromElement[0].Split("-")
    
    #remove tailing colon
    $arrayFromElement[1] = $arrayFromElement[1].Remove(1,1)
    
    echo "Minimum use: $($arrayMinMax[0])"
    echo "Maximum use: $($arrayMinMax[1])"
    echo "Letter rule: $($arrayFromElement[1])"
    echo "Password: $($arrayFromElement[2])"

    #evaluate how many of letter rule is in the password
    $letterRuleVal = ($arrayFromElement[2].Split($arrayFromElement[1])).count-1
    echo "Occurences: $letterRuleVal"
    
    #check if password is good or not and pass to counter
    if ($letterRuleVal -ne 0 -and $letterRuleVal -ge $arrayMinMax[0] -and $letterRuleVal -le $arrayMinMax[1]) {
        $evalPassTrue++
        echo "Eval: True"
    } else {
        echo "Eval: False"
    }

    echo ""

}

echo "Total true eval: $evalPassTrue"