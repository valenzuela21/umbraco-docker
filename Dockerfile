FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Container.csproj", "src/"]
RUN dotnet restore "src/Container.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "Container.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "Container.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app

COPY --from=publish /app/publish .

USER root

RUN mkdir -p /app/wwwroot/media
RUN mkdir -p /app/umbraco /app/umbraco/Logs


RUN chmod -R 775 /app/wwwroot/media
RUN chown -R $APP_UID:$APP_UID /app/wwwroot/media
RUN chown -R $APP_UID:$APP_UID /app/umbraco --recursive
RUN chown -R $APP_UID:$APP_UID /app/wwwroot /app/umbraco

RUN chmod 644 /app/appsettings.json
RUN chown $APP_UID:$APP_UID /app/appsettings.json

RUN mkdir -p /app/data
RUN chmod -R 775 /app/data
RUN chown -R $APP_UID:$APP_UID /app/data

USER $APP_UID

ENTRYPOINT ["dotnet", "Container.dll"]
