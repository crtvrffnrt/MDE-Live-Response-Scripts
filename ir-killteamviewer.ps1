Get-Process | Where-Object { $_.Path -like "*TeamViewer*" -or $_.Name -like "*TeamViewer*" } | ForEach-Object { Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue }
