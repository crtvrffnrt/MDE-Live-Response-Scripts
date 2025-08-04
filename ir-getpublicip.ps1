$webClient = New-Object System.Net.WebClient  
$publicIP = $webClient.DownloadString('http://ipinfo.io/ip')  
$publicIP.Trim()  
