#!/bin/bash
# Esperar hasta que SQL Server esté disponible
until /opt/mssql-tools/bin/sqlcmd -S umbraco-db-mssql-2017,1433 -U sa -P $SA_PASSWORD -Q "SELECT 1" > /dev/null 2>&1; do
  echo "Esperando que SQL Server esté disponible..."
  sleep 5
done

# Crear la base de datos si no existe
/opt/mssql-tools/bin/sqlcmd -S umbraco-db-mssql-2017,1433 -U sa -P $SA_PASSWORD -Q "IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'portafolio') CREATE DATABASE portafolio"
