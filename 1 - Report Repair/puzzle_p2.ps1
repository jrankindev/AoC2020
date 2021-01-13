Clear-Host

[int[]] $arrayFromFile = Get-Content pi.txt

foreach ($input in $arrayFromFile) {
    foreach ($recInput in $arrayFromFile) {
        if ($input -ne $recInput) {
            
            $bothInputs = $input + $recInput
            $searcher = 2020 - $bothInputs

            if ($arrayFromFile -contains $searcher -and $arrayFromFile -contains $recInput -and $searcher -ne 0) {

                Write-Output "First Matching Val: $input"
                Write-Output "Second Matching Val: $recInput"
                Write-Output "Third Matching Val: $searcher"

                $finalVal = $input * $recInput * $searcher
                Write-Output "Puzzle Answer: $finalVal"
                Write-Output ""    

            }
        }
    }
}