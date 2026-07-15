---
title: Fact-Based Modelling
description: Map UMS types, keys, and relationships to a Fact-Based Model.
---

For Fact-Based Modelling (FBM) practitioners, UMS is a logical model that carries the information needed to derive Value Types, Entity Types, Fact Types (including Fact Type Readings), and various Constraints.

## Mapping

| UMS concept | FBM interpretation |
| --- | --- |
| Entity type | Entity Type or Objectified/Nested Fact Type |
| `Properties` | Binary Fact Types to Value Types, or as Value Types referenced from the Roles of an Objectified/Nested Fact Type |
| `PrimaryKey` | Internal Uniqueness Constraint, or External Uniqueness Constraint |
| `UniquenessConstraints` | Named Internal or External Uniqueness Constraint |
| `Relationships` | Binary Fact Types linking Entity Types and/or Objectified/Nested Fact Types |
| Relationship type | Objectified/Nested Fact Type |
| `FactTypeReadings` | Fact Type Readings for the Fact Types created for Properties in the ER/LPG view |

