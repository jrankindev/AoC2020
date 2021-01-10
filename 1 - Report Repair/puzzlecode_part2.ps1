cls

[int[]] $arrayFromFile = Get-Content puzzleinput.txt

foreach ($input in $arrayFromFile) {
    foreach ($recInput in $arrayFromFile) {
        if ($input -ne $recInput) {
            
            $bothInputs = $input + $recInput
            $searcher = 2020 - $bothInputs

            if ($arrayFromFile -contains $searcher -and $arrayFromFile -contains $recInput -and $searcher -ne 0) {

                echo "First Matching Val: $input"
                echo "Second Matching Val: $recInput"
                echo "Third Matching Val: $searcher"

                $finalVal = $input * $recInput * $searcher
                echo "Puzzle Answer: $finalVal"
                echo ""    

            }
        }
    }
}