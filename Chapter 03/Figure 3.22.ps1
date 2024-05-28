$Urls = @(
    "https://www.bpb.com",
    "https://www.example.com",
    "https://www.google.com",
    "https://www.microsoft.com",
    "https://www.openai.com",
    "https://www.github.com",
    "https://www.apple.com",
    "https://www.amazon.com",
    "https://www.twitter.com",
    "https://www.reddit.com",
    "https://www.yahoo.com",
    "https://www.wikipedia.org",
    "https://www.nytimes.com",
    "https://www.bing.com",
    "https://www.instagram.com",
    "https://www.ebay.com",
    "https://www.cnn.com",
    "https://www.espn.com",
    "https://www.weather.com",
    "https://www.twitch.tv",
    "https://www.youtube.com"
)

function Measure-ResponseTimeSequential {
    param (
        [string[]]$Urls
    )

    $Urls | ForEach-Object {
        Invoke-WebRequest $_
    }
    
}

function Measure-ResponseTimeParallel {
    param (
        [string[]]$Urls
    )

    $Urls | ForEach-Object -Parallel {
        Invoke-WebRequest $_
    } 

}


# Measure response time - Sequential processing
$ElapsedTimeSequential = Measure-Command { Measure-ResponseTimeSequential -Urls $Urls }
Write-Output "Results - Sequential processing:
$($ElapsedTimeSequential.TotalMilliseconds) Ms"

# Measure response time - Parallel processing
$ElapsedTimeParallel = Measure-Command { Measure-ResponseTimeParallel -Urls $Urls }
Write-Output "Results - Parallel processing:
$($ElapsedTimeParallel.TotalMilliseconds) Ms"