cls

#grab input and put into array
#[string[]] $arrayFromFile = Get-Content puzzleinput_example.txt
[string[]] $arrayFromFile = Get-Content puzzleinput.txt

#get total height of hill input file (how many lines there are)
$hillElevation = $arrayFromFile.Length

#get width of one input line (they are all the same width)
$hillWidth = $arrayFromFile[0].Length

echo "Hill Height: $hillElevation"
echo "Hill Width: $hillWidth"

#calculate how many times to repeat each element of the array in order to maintain a downhill slope of 1 down 3 right
$totalWidthNeeded = $hillElevation * 3
$hillMultiplier = $totalWidthNeeded / $hillWidth
$hillMultiplier = $hillMultiplier -as [int]
if ($totalWidthNeeded % $hillWidth) {
    $hillMultiplier++
}

#resize hill using slope calcs
for ($x=0; $x -le $arrayFromFile.Length - 1; $x++) {
    $singleElement = $arrayFromFile[$x]
    for ($i = 2; $i -le $hillMultiplier; $i++) {
        $arrayFromFile[$x] = $arrayFromFile[$x] + $singleElement
    }
}

#lets count some trees
$startPosition = 0
$treeCount = 0
foreach ($element in $arrayFromFile) {
    [string[]] $tempLineArray = $element.ToCharArray()

    if ($tempLineArray[$startPosition] -eq "#") {
        $treeCount++
    }

    $startPosition = $startPosition + 3
}

echo "Total trees hit: $treeCount"