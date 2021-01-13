Clear-Host

[int[]] $arrayFromFile = Get-Content pi.txt

foreach ($input in $arrayFromFile) {
    $searcher = 2020 - $input
    if ($arrayFromFile.Contains($searcher)) {
        Write-Output "First Matching Val: $input" 
        Write-Output "Second Matching Val: $searcher"

        $finalVal = $input * $searcher
        Write-Output "Puzzle Answer: $finalVal"
        Write-Output ""
    }
}