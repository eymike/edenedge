Function Get-MSBuild {
    $lib = [System.Runtime.InteropServices.RuntimeEnvironment]
    $rtd = $lib::GetRuntimeDirectory()
    Join-Path $rtd msbuild.exe
}

Function Get-ScriptDir {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

Function Check-Error {
    if ((!$?)) {  
        Throw [System.InvalidOperationException]
    }
}

Try{
    $location = (Convert-Path (Get-Location -PSProvider FileSystem))

    $Error.Clear()
    $ErrorActionPreference = "Stop"

    (Set-Location (Get-ScriptDir))
    $msBuildPath = (Get-MSBuild)

    cd ..

    $HERE = (Convert-Path (Get-Location -PSProvider FileSystem))

    & $msBuildPath /nologo /property:"Configuration=Debug;SolutionDir=$HERE\" third-party\UnitTest++\UnitTest++.vcxproj
    Check-Error
    & $msBuildPath /nologo /property:"Configuration=Debug;SolutionDir=$HERE\" edenedgetests.vcxproj
    Check-Error
    Write-Host "blah" + $Error
    & $msBuildPath /nologo /property:"Configuration=Debug;SolutionDir=$HERE\" edenedge.vcxproj
    Check-Error

} Catch [Exception] {
    Write-Host "=========================="
    Write-Host -ForegroundColor Red "Build Failure: Check log for errors!"
    Write-Host "=========================="
    exit 1
} Finally {
    (Set-Location $location)
}