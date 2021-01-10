#some alternative code methods to solve other problems while i was exploring this puzzle
#the below code does not work as is, just saving it off for the future if i want to look at it for ideas

#create an array of the lowercase alphabet
[string[]] $alphathbetArray = [char]'a'..[char]'z'
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
            #get e current character's int32 value
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