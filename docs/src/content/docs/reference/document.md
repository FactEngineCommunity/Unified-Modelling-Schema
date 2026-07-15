---
title: Document modelling
description: Use UMS relationships and embedding hints to shape document aggregates safely.
---

For document practitioners, UMS is the canonical domain model before an aggregate and embedding strategy is chosen. A document representation can optimise reads without redefining the underlying meaning or identity rules.

## Mapping

| UMS concept | Document interpretation |
| --- | --- |
| Entity type | Root or nested document shape. |
| `Properties` | Document fields. |
| `PrimaryKey` | Stable document identity or natural key. |
| `Relationships` | References or containment links. |
| `Embed: true` | A preferred embedding/materialisation hint. |
| `Cardinality` | Shape of the embedded value or collection. |
| `FactTypeReadings` | Meaning retained when fields are nested or denormalised. |

## Choose an aggregate boundary

Use an aggregate boundary when related data is created, read, and updated together. The UMS relationship remains explicit whether it is embedded or referenced, so the original model can be emitted to another storage style later.

```yaml
- Name: IS_IN
  Source: Seat
  Target: Row
  From:
    - Cinema_Id
    - RowNr
  To:
    - Cinema_Id
    - RowNr
  Embed: true
  Cardinality: Many
  Readings:
    - Seat is in Row
    - Row contains Seat
```

This states that a document projection may contain a collection of seats with its row. It does not imply that `Seat` loses its identity or cannot be referenced elsewhere.

## Embed versus reference

Embed when child data is owned by the parent, bounded in size, and usually retrieved together. Reference when the related type has an independent lifecycle, is shared across aggregates, grows without a practical bound, or needs separate access control.

`Cardinality` communicates the expected embedded shape: `One`, `Many`, `ZeroOrOne`, or `ZeroOrMore`.

## Preserve semantics through denormalisation

Document projections often repeat selected values. Keep the canonical property and relationship definitions in UMS, and regard copied fields as target-specific projections. The readings help reviewers identify whether a denormalised field means the same thing as its source.
