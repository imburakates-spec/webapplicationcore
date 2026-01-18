

# escape=`

FROM mcr.microsoft.com/dotnet/sdk:9.0-windowsservercore-ltsc2025 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o C:\out

FROM mcr.microsoft.com/dotnet/aspnet:9.0-windowsservercore-ltsc2025 AS runtime
WORKDIR /app
COPY --from=build C:\out .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "WebApplicationCore.dll"]
