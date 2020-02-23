FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /backend
COPY * ./
ENTRYPOINT ["dotnet", "MySimpleWebApp.dll"]
