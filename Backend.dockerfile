FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
COPY ./backend /app
ENTRYPOINT ["dotnet", "/app/MySimpleWebApp.dll"]
