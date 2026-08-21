SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

select top 100 * from sys.objects where type = 'PK'
select distinct type, type_desc from sys.objects

Select tb.name, pk.name
  from sys.objects as tb inner join (
       Select name,
             parent_object_id id,
             object_id
        from sys.objects where type = 'PK') as pk
         on pk.id = tb.object_id

Select top 100 * from sys.tables
select distinct type, type_desc from  sys.tables

SELECT SCHEMA_NAME(t.schema_id) AS SchemaName,
       t.name AS TableName,
       k.name AS PrimaryKeyName,
       c.name AS ColumnName,
       ic.key_ordinal AS ColumnOrder
  FROM sys.key_constraints k INNER JOIN sys.tables        t  ON k.parent_object_id = t.object_id
                             INNER JOIN sys.index_columns ic ON k.parent_object_id = ic.object_id 
                                                            AND k.unique_index_id = ic.index_id
                             INNER JOIN sys.columns c        ON ic.object_id = c.object_id 
                                                            AND ic.column_id = c.column_id
WHERE k.type = 'PK'
ORDER BY t.name;

select top 100 * from sys.columns

SELECT SCHEMA_NAME(t.schema_id) AS SchemaName,
       t.name AS TableName,
       k.name AS PrimaryKeyName,
       c.name AS ColumnName,
       ic.key_ordinal AS ColumnOrder

SELECT SCHEMA_NAME(t.schema_id) AS SchemaName,
       t.name AS TableName,
       c.name AS ColumnName,
       ic.column_id column_order
  FROM sys.tables t INNER JOIN sys.index_columns ic ON t.parent_object_id = ic.object_id 
                             INNER JOIN sys.columns c        ON ic.object_id = c.object_id 
                                                            AND ic.column_id = c.column_id
ORDER BY ic.key_ordinal;

select top 20 * from sys.columns  c inner join sys.index_columns ic on ic.object_id = c.object_id  and ic.column_id = c.column_id
select * from sys.tables where object_id = 3

SELECT TABLE_NAME, Column_Name
FROM INFORMATION_SCHEMA.COLUMNS 
ORDER BY 1, 2
WHERE TABLE_NAME = 'CYMEQCONVFAULTCURVEMODELPT'