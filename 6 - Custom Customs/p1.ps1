cls

#grab the raw input and store into a variable
$rawInputString = Get-Content pie.txt -Raw

#split the string into array of lines
#split the whole text into an array where there are two or more linefeeds via regex
$stringsToJoin = $rawInputString -split "(\r*\n){2,}"

#remove linefeeds and replace with a space into a string array
[string[]] $arrayFromFile = $stringsToJoin -replace '\r*\n', ' '

#due to regular array limitations, we need an arraylist. create a blank one and add the range of the string array
$arrayListFromFile = New-Object System.Collections.ArrayList($null)
$arrayListFromFile.AddRange($arrayFromFile)

#loop arraylist to remove the blank lines
for ($i = 0; $i -le $arrayListFromFile.Count; $i++) {
    if ($arrayListFromFile[$i] -eq " ") {
        $arrayListFromFile.Remove($arrayListFromFile[$i])
    }
}

#loop through each element (group that answered questions)
$sumQuestions = 0
foreach ($element in $arrayListFromFile) {
    #remove all spaces so each question group is one single line
    $element = $element.Replace(' ','')
    #split each question group into a character array
    $elementCharArray = $element.ToCharArray()
    #find only the unique characters since we only care if the question was answered once
    $elementCharArray = $elementCharArray | Select -Unique
    #count how many questions were answered total and track it
    $sumQuestions = $sumQuestions + $elementCharArray.Count
}
echo "Sum of all questions answered (part 1): $sumQuestions"

#part2
#loop through each element (group that answered questions)
$sumQuestions = 0
foreach ($element in $arrayListFromFile) {
    #create element array splitting on spaces (blank lines), then loop through them
    [string[]] $elementArray = $element.Split(" ")
    $elementArray
    echo ""
}
echo "Sum of all questions answered (part 2): $sumQuestions `n"

<#
#create an array of the lowercase alphabet
[string[]] $alphabetArray = [char]'a'..[char]'z'
#create an array with the same index number for tracking
$questionCountArray = New-Object int[] 26

#loop through each element (group that answered questions)
foreach ($element in $arrayListFromFile) {
    #create element array splitting on spaces (blank lines), then loop through them
    [string[]] $elementArray = $element.Split(" ")
    foreach ($elementSplit in $elementArray) {
        #split again into a char array and loop through it for each character
        $indivQuestionArray = $elementSplit.ToCharArray()
        for ($i = 0; $i -lt $indivQuestionArray.Length; $i++) {
            #get the current character's int32 value
            $inputCharToInt = [int][char]$indivQuestionArray[$i]
            #find the array index that matches the current character's int32 value
            #have to put it back into a string cause powershell being powershell
            $indexOfInput = $alphabetArray.IndexOf($inputCharToInt.ToString())
            #add one for the index found so we can count them up later
            $questionCountArray[$indexOfInput]++
        }
    }
}

#print out alphabet counted array results
$counter = 1
for ($i = 0; $i -lt $alphabetArray.Length; $i++) {
    #cast back to char because the int value is saved
    $tempElement = [char][int]$alphabetArray[$i]
    echo "$counter -> count: $($questionCountArray[$i]), alpha: $tempElement"
    $counter++
}
echo ""#>