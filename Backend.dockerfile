FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /
COPY backend/* ./
ENTRYPOINT ["dotnet", "MySimpleWebApp.dll"]
