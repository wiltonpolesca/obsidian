# Running unit tests

```bash
dotnet test .\\FMEPluginsTests\\FMEPluginsTests.csproj /p:CollectCoverage=true /p:CoverletOutput=lcov /p:CoverletOutput=coverage.lcov /p:Exclude='[xunit*]*' /p:ThresholdType=line /p:ThresouldStat=average


dotnet test .\FMEPluginsTests\FMEPluginsTests.csproj ^
  -p:CollectCoverage=true ^
  -p:CoverletOutput=.\TestResults\coverage\ ^
  -p:CoverletOutputFormat=lcov ^
  -p:Exclude=[xunit*]* ^
  -p:ThresholdType=line ^
  -p:ThresholdStat=average


dotnet test ./FMEPluginsTests/FMEPluginsTests.csproj 
-p:CollectCoverage=true 
-p:CoverletOutput=./TestResults/coverage.lcov 
-p:CoverletOutputFormat=lcov 
-p:Exclude=[xunit*]* -p:ThresholdType=line -p:ThresholdStat=average

RUN dotnet publish "/app/src/Api/Gallery.Api/Gallery.Api.csproj" -c Release -o /app/publish        --no-restore        --self-contained true        --runtime linux-musl-x64        /p:DebugType=None        /p:DebugSymbols=false        /p:PublishSingleFile=true
```