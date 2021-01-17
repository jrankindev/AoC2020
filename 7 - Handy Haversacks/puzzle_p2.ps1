#clear screen
Clear-Host

#start part 2 text
Write-Host " Part 2 "  -BackgroundColor "Green" -ForegroundColor "Black"

#grab input and put into arraylist
[System.Collections.ArrayList] $arrayFromFile = Get-Content pie.txt

foreach ($element in $arrayFromFile) {
    $element
}

#show answer
Write-Host " How many individual bags are required inside your single shiny gold bag? (P2 Answer): XXXXX "  -BackgroundColor "Green" -ForegroundColor "Black"