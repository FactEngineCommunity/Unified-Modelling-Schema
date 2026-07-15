---
title: Relational modelling
description: Map UMS types, keys, and relationships to a relational database design.
---

For relational practitioners, UMS is a logical model that carries the information needed to derive tables, columns, primary keys, unique constraints, and foreign keys—plus the readings that explain why they exist.

## Mapping

| UMS concept | Relational interpretation |
| --- | --- |
| Entity type | Table or viewable logical relation. |
| `Properties` | Columns. |
| `PrimaryKey` | Primary key columns, in the declared order. |
| `UniquenessConstraints` | Named `UNIQUE` constraints. |
| `Relationships` | Foreign-key constraints from `From` to `To`. |
| Relationship type | Associative table, possibly with attributes. |
| `FactTypeReadings` | Documentation for table/column and relationship semantics. |

## Entity tables

Map each entity type to a table. Choose a physical table name from `Labels` or apply a target naming convention. Map UMS datatypes to the target database’s closest exact type; do not infer business meaning solely from the physical type.

For example, a `TextVariableLength` property with `Length: 100` might become `varchar(100)`, and `NOT NULL` becomes a column nullability rule.

## Foreign keys

Each relationship gives the mapping directly. Generate a foreign key from the source type’s `From` fields to the target type’s `To` fields. Preserve the sequence for composite keys.

```yaml
- Name: IS_FOR
  Source: Booking
  Target: Session
  From:
    - Film_Id
    - DateTime
    - Cinema_Id
  To:
    - Film_Id
    - DateTime
    - Cinema_Id
  Readings:
    - Booking is for Session
    - Session has Booking
```

This becomes a three-column foreign key on `Booking`. The reading makes the intended business rule explicit, rather than leaving it implicit in a constraint name.

## Association tables

Use a relationship type when the association is more than an implementation join. `PersonLikesFilm` can become a table keyed by `Person_Id` and `Film_Id`, with a `Rating` column. Its `LIKES` label and “Person likes Film” reading remain available to documentation and non-relational targets.

## Practical checks

- Every property in `PrimaryKey` should be present in `Properties`.
- Every `From`/`To` pair should have matching cardinality and compatible types.
- Use a named uniqueness constraint for a composite candidate key; do not simulate it with several independent `UNIQUE` properties.
- Keep relationship readings close to business language, not column names.
