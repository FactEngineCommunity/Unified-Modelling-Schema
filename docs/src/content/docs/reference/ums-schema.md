---
title: UMS schema
description: The core objects and conventions of a Unified Modelling Schema document.
---

A UMS document is a YAML list. Each item is a `TypeDefinition`: either an entity type or a relationship type.

## Type definition

| Field | Purpose |
| --- | --- |
| `Type` | Stable name of the domain type. |
| `Labels` | One or more labels for an entity type. |
| `Label` | Short label for a relationship type, such as `LIKES`. |
| `PrimaryKey` | Ordered list of properties that identify the type. |
| `Properties` | Attribute definitions owned by the type. |
| `Relationships` | Directed field mappings to other types. |
| `Source`, `Target` | Endpoint types of a relationship type. |
| `RelationshipAnnotation` | A readable statement of the relationship type. |
| `FactTypeReadings` | Readings grouped by language. |
| `Facts` | Optional example or asserted facts grouped by language. |
| `UniquenessConstraints` | Named unique combinations other than the primary key. |
| `IsRelationshipType` | `true` for an association type; `false` for an entity type. |

## Properties

Every property has `Name` and `DataType`. The implementation classes support `Integer`, `DateTime`, `TextFixedLength`, and `TextVariableLength`; the model may also express `Length`, `Precision`, `Constraints`, aliases, fact-based names, arrays, readings, and facts.

Use portable types and state constraints explicitly. `NOT NULL` expresses mandatory participation; `UNIQUE` expresses a single-property alternate identifier.

```yaml
- Name: LoginName
  DataType: TextVariableLength
  Length: 100
  Constraints:
    - NOT NULL
    - UNIQUE
  FactTypeReadings:
    - Language: English
      Readings:
        - Person has LoginName
```

## Relationships

A relationship has a `Name`, `Source`, `Target`, `From`, and `To`. `From` and `To` are parallel lists: item 1 maps to item 1, item 2 to item 2, and so on. This supports both simple and composite keys.

`Embed` and `Cardinality` are optional document-oriented hints. They do not remove the relationship from the canonical model; they state a useful materialisation choice for a document target.

## Readings and facts

`FactTypeReadings` records a model statement in one or more languages. Each entry contains a `Language` and its `Readings`. `Facts` follows the same language-grouping pattern, but contains instance-level statements or example facts.

```yaml
FactTypeReadings:
  - Language: English
    Readings:
      - Person likes Film
```

The repository also contains an earlier JSON Schema and example YAML that use `TypeReadings` and `Readings` directly. Treat the language-grouped `FactTypeReadings` layout as the current documentation convention; align any validator or generator with the layout it consumes.
