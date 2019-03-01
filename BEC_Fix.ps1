
# get Microsoft Word process
$winword = Get-Process WINWORD -ErrorAction SilentlyContinue
if ($winword) {
  # try gracefully first
  $winword.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$winword.HasExited) {
    $winword | Stop-Process -Force
  }
}
Remove-Variable winword

# delete existing legal
remove-item "$env:APPDATA\Microsoft\Word\Startup\BEC LegalBar Library.dotm"

copy-item '\\Cinutl01\sources$\LegalBar\IntegrationFiles\Startup2010_for_iManage9.3\BEC LegalBar iManage Integration.dotm' -Destination "$env:APPDATA\Microsoft\Word\Startup"

