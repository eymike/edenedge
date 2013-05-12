Function Get-ScriptDir {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

$location = (Convert-Path (Get-Location -PSProvider FileSystem))

Function Check-Error {
    if ((!$?)) {  
        Throw [System.InvalidOperationException]
    }
}

Try {

$Error.Clear()

(Set-Location (Get-ScriptDir))
cd ..

if((Test-Path bin/cpptestsDebug.exe)) {
    & bin/cpptestsDebug.exe
    Check-Error
}

if((Test-Path bin/cpptestsRelease.exe)) {
    & bin/cpptestsRelease.exe
    Check-Error
}

} Catch [Exception] {
    Write-Host "=========================="
    Write-Host -ForegroundColor Red "Test Failed!"
    Write-Host "=========================="
    exit 1
} Finally {
    (Set-Location $location)
}