---
layout: post
title: "20170627 Architect's Diary - ORA-00933: SQL Command not properly ended"
description: "Oracle Error"
category: Database
tags: [oracle, jhipster]
---

## Why am I getting this?

1. Get the SQL query by enable `DEBUG` log level on hibernate (org.hibernate). In my case, it looks like,

````
SELECT ...
FROM table_name fetch first ? rows only;
````

2. Test this query in `SQL developer` (or other tools). You will likely get the same error.

In my case, the problem is `featch first ? rows only`. This is a feature available to Oracle 12g+.

## How can I solve it?

If your database is on a lower version, it should use `ROWNUM` to limit the result.

````
SELECT *
FROM   (SELECT ...
        FROM table_name)
WHERE  ROWNUM <= ?
````
Change `jpa.database-platform` to `org.hibernate.dialect.Oracle10gDialect` will produce the above query.

## How to check the database version?

Try
````
SELECT version FROM V$INSTANCE;
// OR
SELECT * FROM V$VERSION
````
