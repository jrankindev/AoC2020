[int[]] $arrayFromFile = Get-Content puzzleinput.txt

foreach ($input in $arrayFromFile) {
    $searcher = 2020 - $input
    if ($arrayFromFile.Contains($searcher)) {
        echo "First Matching Val: $input" 
        echo "Second Matching Val: $searcher"

        $finalVal = $input * $searcher
        echo "Puzzle Answer: $finalVal"
        echo ""
    }
}