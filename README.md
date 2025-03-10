
# Portafolio Umbraco .Net
Get Startet Umbraco Docker.


### Install
```
  docker compose up -d
```

### Create database SQL SERVER

```
  /opt/mssql-tools/bin/sqlcmd -S umbraco-db-mssql-2017,1433 -U sa -P <Password>

  SELECT name FROM sys.databases;
  GO

  CREATE DATASABE portafolio;
  GO
```

![ScreenShot]([https://dev-to-uploads.s3.amazonaws.com/uploads/articles/th5xamgrr6se0x5ro4g6.png](https://github.com/valenzuela21/umbraco-docker/blob/master/screenshot.png?raw=true))
