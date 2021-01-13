Clear-Host

#grab input and put into array
[string[]] $arrayFromFile = Get-Content pi.txt

#get total height of hill input file (how many lines there are)
$hillElevation = $arrayFromFile.Length

#get width of one input line (they are all the same width)
$hillWidth = $arrayFromFile[0].Length

#calculate how many times to repeat each element of the array in order to maintain a downhill max of 7 right
$totalWidthNeeded = $hillElevation * 8
$hillMultiplier = $totalWidthNeeded / $hillWidth
$hillMultiplier = $hillMultiplier -as [int]
if ($totalWidthNeeded % $hillWidth) {
    $hillMultiplier++
}

#resize hill using slope calcs
for ($x=0; $x -le $arrayFromFile.Length - 1; $x++) {
    $singleElement = $arrayFromFile[$x]
    for ($i = 3; $i -le $hillMultiplier - 1; $i++) {
        $arrayFromFile[$x] = $arrayFromFile[$x] + $singleElement
    }
}

function Find-Trees {
    param([int]$right, [int]$down)

    $startPosition = 0
    $treeCount = 0

    for ($x=0; $x -le $arrayFromFile.Length - 1; $x = $x + $down) {
        [string[]] $tempLineArray = $arrayFromFile[$x].ToCharArray()
        
        if ($tempLineArray[$startPosition] -eq "#") {
            $treeCount++
        }

        $startPosition = $startPosition + $right
    }
    Write-Output "Right $right, Down $down"
    Write-Output "Total trees hit: $treeCount"
    Write-Output ""
}

Find-Trees -right 1 -down 1
Find-Trees -right 3 -down 1
Find-Trees -right 5 -down 1
Find-Trees -right 7 -down 1
Find-Trees -right 1 -down 2