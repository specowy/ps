$ipInfo = Invoke-RestMethod -Uri "http://ipinfo.io/json"
$publicIP = $ipInfo.ip

$target = "www.google.com"

$pingResult = Test-Connection -ComputerName $target -Count 2 -ErrorAction SilentlyContinue

if ($pingResult) {
    Write-Host -ForegroundColor green "Ping Success: $target response"
} else {
    Write-Host -ForegroundColor red "Ping Failure: $target unreachable"	
	Write-Host -ForegroundColor yellow "Resetting network"
	ipconfig /release
	ipconfig /renew
	arp -d *
	nbtstat -R
	nbtstat -RR
	ipconfig /flushdns
	ipconfig /registerdns

	Write-Host -ForegroundColor yellow "Resetting network"
	if ($pingResult) {
    		Write-Host -ForegroundColor green "Ping Success: $target response"
	} else { Write-Host -ForegroundColor red "Ping Failure: $target unreachable; something not hehe"
		exit}

Write-Host "Public IP Address: $publicIP"

speedtest.exe
