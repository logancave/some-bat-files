# PowerShell script to extract Chrome browsing history
$chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History"
$historyFile = "chrome_history.txt"

if (Test-Path $chromePath) {
    # Load the SQLite library
    Add-Type -Path "System.Data.SQLite.dll"
    $connection = New-Object -TypeName System.Data.SQLite.SQLiteConnection -ArgumentList "Data Source=$chromePath;Version=3;"
    $connection.Open()

    # Query to get browsing history
    $command = $connection.CreateCommand()
    $command.CommandText = "SELECT url, title, visit_count, last_visit_time FROM urls"
    $reader = $command.ExecuteReader()

    # Output results
    while ($reader.Read()) {
        $url = $reader["url"]
        $title = $reader["title"]
        $visit_count = $reader["visit_count"]
        $last_visit_time = $reader["last_visit_time"]
        "$url`n$title`nVisit Count: $visit_count`nLast Visit Time: $last_visit_time`n" | Out-File -Append -FilePath $historyFile
    }

    $connection.Close()
} else {
    "Chrome history file not found." | Out-File -FilePath $historyFile
}
