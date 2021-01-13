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

#loop arraylist to remove the blank lines
for ($i = 0; $i -le $arrayListFromFile.Count; $i++) {
    if ($arrayListFromFile[$i] -eq " ") {
        $arrayListFromFile.Remove($arrayListFromFile[$i])
    }
}

#part1
#loop through each element (group that answered questions)
$sumQuestions = 0
foreach ($element in $arrayListFromFile) {
    #remove all spaces so each question group is one single line
    $element = $element.Replace(' ','')
    #split each question group into a character array
    $elementCharArray = $element.ToCharArray()
    #find only the unique characters since we only care if the question was answered once
    $elementCharArray = $elementCharArray | Select-Object -Unique
    #count how many questions were answered total and track it
    $sumQuestions = $sumQuestions + $elementCharArray.Count
}
Write-Output "Sum of all questions answered (part 1): $sumQuestions `n"

#part2
#loop through each element (group that answered questions)
$sumQuestions = 0
foreach ($element in $arrayListFromFile) {
    #create element array splitting on spaces (blank lines), then count them.
    #this will give us the number of people in each group
    [string[]] $elementArray = $element.Split(" ")
    $groupCount = $elementArray.Count

    #now strip out spaces in element
    $element = $element.Replace(' ','')
    #split again into char array, then group
    $indivQuestionArray = $element.ToString().ToCharArray()
    $indivQuestionArray = $indivQuestionArray | Group-Object

    #loop through each question and see if it was answered by the same number as people in the group
    foreach ($element in $indivQuestionArray) {
        if ($element.Count -eq $groupCount) {
            $sumQuestions++
        }
    }
}
Write-Output "Sum of all questions answered (part 2): $sumQuestions `n"