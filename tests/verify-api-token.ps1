param(
  [Parameter(Mandatory = $true)] [string] $Helm,
  [string] $Chart = (Join-Path $PSScriptRoot '..\hap-nocoly-single-7.3.501.tgz')
)

$common = @(
  'template', 'hap-test', $Chart,
  '--namespace', 'nocoly',
  '--show-only', 'templates/secret.yaml',
  '--set-string', 'hap.addressMain=http://example.test:30880',
  '--set-string', 'persistence.storageClass=local-path'
)

$rendered = & $Helm @common
if ($LASTEXITCODE -ne 0) { throw 'Helm failed to render an automatically generated token.' }
$match = [regex]::Match(($rendered -join "`n"), 'ENV_API_TOKEN:\s*"([A-Za-z0-9]+)"')
if (-not $match.Success -or $match.Groups[1].Value.Length -ne 32) {
  throw 'An empty apiToken must render as 32 alphanumeric characters.'
}

$expected = 'UserProvidedTokenForChartTest'
$rendered = & $Helm @common '--set-string' "hap.apiToken=$expected"
if ($LASTEXITCODE -ne 0 -or ($rendered -join "`n") -notmatch "ENV_API_TOKEN:\s*`"$expected`"") {
  throw 'A user-provided apiToken must be preserved.'
}

'apiToken template checks passed'
