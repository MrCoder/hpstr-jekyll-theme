---
layout: post
title: "20170627 Architect's Diary - Tablespace"
description: "about oracle tablespace"
category: Database
tags: [oracle, tablespace]
---

## How can I know which tablespace is MY default tablespace?

````
select * from DBA_USERS where USERNAME='MyADP';`
````

> Note: Not all users can do this. If your user does not have access to `DBA_USERS`, you may get
> ````
> ORA-00942: table or view does not exist
> 00942. 00000 -  "table or view does not exist"
> *Cause:
> *Action:
> Error at Line: 48 Column: 15
> ````

## Where is this specified?

When you create a new user, you can optionally specify the default tablespace and default temporary tablespace for any objects created by that user. For example

````
CREATE USER phil IDENTIFIED BY s3cr3t
      DEFAULT TABLESPACE philtablespace
      TEMPORARY TABLESPACE philtemp;
````

If you omit the clauses when creating the user, the user will inherit the database default values. These can be queried as follows:

````
SELECT *
  FROM DATABASE_PROPERTIES
  WHERE PROPERTY_NAME LIKE `DEFAULT%TABLESPACE`
````

You would then get something like:

````
PROPERTY_NAME                 PROPERTY_VALUE    DESCRIPTION
DEFAULT_PERMANENT_TABLESPACE	SYSTEM	          Default Permanent Tablespace ID
DEFAULT_TEMP_TABLESPACE	      TEMP	            ID of default temporary tablespace
````

More information see [here on stackexchange](https://dba.stackexchange.com/questions/25305/how-is-the-default-tablespace-determined-when-creating-a-table).
