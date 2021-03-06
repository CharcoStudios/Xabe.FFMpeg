#!/bin/bash
dotnet restore
dotnet test Xabe.FFMpeg.Test/
if [[ -z "${TRAVIS_TAG}" ]]; then 
	exit 0
else
	cd Xabe.FFMpeg
	dotnet clean -c Release
	dotnet build -c Release /property:Version=$TRAVIS_TAG
	dotnet pack --no-build -c Release -o nuget /p:PackageVersion=$TRAVIS_TAG
	dotnet nuget push nuget/*.nupkg -k $NUGET_API -s https://www.nuget.org/api/v2/package
fi
