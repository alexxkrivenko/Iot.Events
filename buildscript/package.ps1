# https://www.appveyor.com/docs/environment-variables/

# Script static variables
$buildDir = $env:APPVEYOR_BUILD_FOLDER # e.g. C:\projects\rn-common\
$buildNumber = $env:APPVEYOR_BUILD_VERSION # e.g. 1.0.17

# C:\projects\rn-common\src\Iot.Common
$projectDir = $buildDir + "\";
# C:\projects\rn-common\src\Iot.Common\Iot.Common.csproj
$projectFile = $projectDir + "\$env:APPVEYOR_PROJECT_NAME.csproj";
# C:\projects\rn-common\src\Iot.Common\Iot.Common.x.x.x.nupkg
$nugetFile = $projectDir + $env:APPVEYOR_PROJECT_NAME + "." + $buildNumber + ".nupkg";


# Display .Net Core version
Write-Host "Checking .NET Core version" -ForegroundColor Green
& dotnet --version

# Restore the main project
Write-Host "Restoring project" -ForegroundColor Green
& dotnet restore $projectFile 

# Build the project
Write-Host "Build project, create post-build NuGet" -ForegroundColor Green
& dotnet build $projectFile --configuration Release --no-restore

# Generate a NuGet package for publishing
Write-Host "Generating NuGet Package" -ForegroundColor Green
cd $projectDir
& dotnet pack -c Release /p:PackageVersion=$buildNumber -o $projectDir

# Compress artifact
$pathToCompress = $projectDir+"\bin\Release\*";
$compressedArtifactName	= $env:APPVEYOR_PROJECT_NAME +"."+ $env:APPVEYOR_BUILD_VERSION + ".zip";

Write-Host "Generate zip artifact" -ForegroundColor Green
Compress-Archive -Path $pathToCompress -CompressionLevel Fastest -DestinationPath "compressed"
Push-AppveyorArtifact "compressed.zip" -FileName $compressedArtifactName

# Save generated artifacts
Write-Host "Saving Artifacts" -ForegroundColor Green
Push-AppveyorArtifact $nugetFile

# Publish package to NuGet
Write-Host "Publishing NuGet package" -ForegroundColor Green
& nuget push $nugetFile -ApiKey $env:NUGET_API_KEY -Source http://servicelab.tk:5555/v3/index.json

# Done
Write-Host "Done!" -ForegroundColor Green