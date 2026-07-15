---
title: Getting started
description: Create a small, portable UMS model and understand its parts.
---

Unified Modelling Schema (UMS) is a YAML representation of a data model. It preserves implementation structure—types, properties, keys, and relationships—and the domain statements that explain what that structure means.

## Model a small domain

Start by identifying the things in the domain and the facts that connect them. The following model says that a person has a login name and that a person can like a film.

```yaml
- Type: Person
  Labels:
    - Person
  PrimaryKey:
    - Person_Id
  Properties:
    - Name: Person_Id
      DataType: Integer
      Constraints:
        - NOT NULL
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
            - LoginName is of Person
  IsRelationshipType: false

- Type: PersonLikesFilm
  Label: LIKES
  Source: Person
  Target: Film
  RelationshipAnnotation: Person likes Film
  PrimaryKey:
    - Person_Id
    - Film_Id
  Relationships:
    - Name: PersonPersonLikesFilm
      Source: PersonLikesFilm
      Target: Person
      From:
        - Person_Id
      To:
        - Person_Id
      Readings:
        - PersonLikesFilm involves Person
    - Name: FilmPersonLikesFilm
      Source: PersonLikesFilm
      Target: Film
      From:
        - Film_Id
      To:
        - Film_Id
      Readings:
        - PersonLikesFilm involves Film
  FactTypeReadings:
    - Language: English
      Readings:
        - Person likes Film
  IsRelationshipType: true
```

## Read the model

- A **type** is a domain concept. It is an entity type when `IsRelationshipType` is `false`, and an association type when it is `true`.
- A **property** has a portable UMS datatype and can carry constraints such as `NOT NULL` and `UNIQUE`.
- A **relationship** maps fields on the source type (`From`) to fields on the target type (`To`). Keep both lists in the same order.
- A **fact type reading** records the domain statement in a named language. Use short, natural sentences that a subject-matter expert can verify.

## Choose an implementation view

UMS does not require a physical storage choice at modelling time. Once the model is sound, use the reference for your implementation style:

- [Relational modelling](/reference/relational/) for tables, keys, and foreign keys.
- [Graph modelling](/reference/graph/) for nodes and named edges.
- [Document modelling](/reference/document/) for aggregate documents and embedding.
- [Multi-model modelling](/reference/multi-model/) when more than one representation serves the same domain.
