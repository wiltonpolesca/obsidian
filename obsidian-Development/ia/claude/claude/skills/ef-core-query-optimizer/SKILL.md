--- 
name: efcore-readonly-check 
description: > 
	Use when reviewing or writing EF Core queries in C#. Flags read-only 
	queries that are missing AsNoTracking, and N+1 access patterns. 

--- 

# EF Core read-only check 

When you see a LINQ-to-Entities query in this repo: 

1. If the query only reads data and never mutates it, it MUST use `.AsNoTracking()`. Flag any that don't and fix them. 
2. Look for loops that trigger a query per iteration (N+1). Suggest a single projected query with `.Select(...)` instead. 
3. Report findings as: file, line, problem, fix.