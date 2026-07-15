---
title: Graph modelling
description: Use UMS to describe nodes, named edges, endpoints, and edge properties.
---

For graph practitioners, UMS distinguishes the domain relationship from the fields used to identify its endpoints. This makes named, readable graph edges first-class rather than a side effect of foreign keys.

## Mapping

| UMS concept | Property-graph interpretation |
| --- | --- |
| Entity type | Node type. |
| `Labels` | Node label or labels. |
| `Properties` | Node properties. |
| Relationship type | Edge type. |
| `Label` | Edge label, such as `LIKES`. |
| `Source`, `Target` | Edge direction and endpoint node types. |
| Relationship type properties | Edge properties. |
| `FactTypeReadings` | Semantic documentation for labels and traversals. |

## Model an edge intentionally

Use a relationship type for a graph edge that expresses a domain fact. Give it a concise, verb-like `Label`, endpoint types, and a readable annotation.

```yaml
- Type: PersonLikesFilm
  Label: LIKES
  Source: Person
  Target: Film
  RelationshipAnnotation: Person likes Film
  Properties:
    - Name: Rating
      DataType: Integer
  FactTypeReadings:
    - Language: English
      Readings:
        - Person likes Film
  IsRelationshipType: true
```

This maps naturally to `(person:Person)-[like:LIKES { Rating: … }]->(film:Film)`. The UMS relationship type is still useful for relational generation, where it may become an associative table.

## Direction and reverse readings

`Source` to `Target` defines the stored traversal direction. Record a reading in that direction, and add a reverse reading when users will navigate it that way. A reverse reading is a semantic statement; it does not require a second stored edge.

## Identity and graph lookup

Keep `PrimaryKey` even if the graph database uses internal identifiers. It preserves a stable business identity for import, deduplication, and integration. Use those key fields to resolve the source and target endpoints when materialising an edge.

## Avoid graph-only ambiguity

An edge label alone rarely captures enough meaning. Keep the endpoint type, the relationship annotation, and readings. They distinguish similarly named edges and make the model usable outside one graph engine.
