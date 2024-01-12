# ? https://serverfault.com/a/1006031/1070398
$tmp = New-TemporaryFile | Rename-Item -NewName { $_ -replace 'tmp$', 'zip' } -PassThru
$url = 'https://github.com/blakeNaccarato/gist-template/archive/refs/heads/main.zip'
Invoke-WebRequest $url -OutFile $tmp
$tmpdir = "$($tmp.Directory)/$($tmp.BaseName)"
$tmp | Expand-Archive -DestinationPath $tmpdir
Get-ChildItem $tmpdir/*/* | Move-Item -Recurse -Force
Remove-Item 'LICENSE'
py -3.11 -m 'venv' --clear '.venv'
.venv/scripts/activate
New-Item -ErrorAction SilentlyContinue 'requirements.txt'
pip install --requirement 'requirements.txt'
