# Unified Modelling Schema
A schema for graph, relational, multimodel, fact-based and AI databases. Built for structure and meaning. Containing also natural language predicates the schema furthers to use with AI.

\---

## What is UMS?

Most schema formats describe structure. UMS describes structure *and* semantics.

The Unified Modelling Schema is a YAML-based format for representing a complete data model — entity types, relationship types, properties, constraints, primary keys, and natural-language predicates — in a single, human-readable document that is independent of any storage technology.

UMS is designed to serve as the canonical representation of a model throughout its lifecycle: from initial design through to code generation, graph schema, relational DDL, documentation, and AI-assisted reasoning.

\---

## Key Features

**Storage-agnostic.** A UMS document makes no assumptions about where the data lives. The same schema can target a relational database, a property graph, a document store, a wide-column store, or a vector database without retranslating the semantics at each step.

**Natural-language Readings.** Every property and every relationship carries one or more Readings — natural-language verbalisations derived from ORM (Object-Role Modelling) practice. Readings preserve the intent of the model in a form that is human-readable, documentation-ready, and consumable by large language models.

**First-class relationships.** The `IsRelationshipType` flag distinguishes entity types from association types explicitly. Relationships are named, typed, directional, and verbalised — not inferred from foreign keys.

**Fact-based foundations.** UMS is grounded in fact-based modelling principles. Every assertion in the schema is expressed as an elementary fact, making the format naturally compatible with ORM, FBM, and formal logic approaches.

**AI-ready.** The inclusion of structured natural-language predicates makes UMS directly consumable by AI systems for schema understanding, query generation, ontology alignment, and semantic reasoning.

\---

## Schema Structure

A UMS document is a YAML list of typed objects. Each object may contain the following top-level keys:

|Key|Description|
|-|-|
|`Type`|The name of the entity or relationship type|
|`Labels`|Graph labels or relational table names|
|`PrimaryKey`|List of properties forming the primary key|
|`Properties`|List of property definitions (see below)|
|`Relationships`|List of relationship definitions (see below)|
|`IsRelationshipType`|`true` if this type is an association/relationship type|
|`RelationshipAnnotation`|Human-readable description of the relationship|
|`TypeReadings`|Natural-language readings for the type as a whole|
|`Label`|Short relationship label (e.g. for graph edge labelling)|

### Property Definition

```yaml
- Name: LoginName
  DataType: TextVariableLength
  Length: 100
  Constraints:
    - NOT NULL
    - UNIQUE
  Readings:
    - Person has LoginName
    - LoginName is of Person
```

### Relationship Definition

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

\---

## Example

The following excerpt models a `Person` entity type and a `PersonLikesFilm` relationship type.

```yaml
- Type: Person
  Labels:
    - Person
  PrimaryKey:
    - Person\_Id
  Properties:
    - Name: Person\_Id
      DataType: Integer
      Constraints:
        - NOT NULL
      Readings:
        - Person\_Id is of Person
        - Person has Person\_Id
    - Name: LoginName
      DataType: TextVariableLength
      Length: 100
      Constraints:
        - NOT NULL
        - UNIQUE
      Readings:
        - Person has LoginName
  IsRelationshipType: false

- Type: PersonLikesFilm
  Label: LIKES
  RelationshipAnnotation: Person likes Film
  PrimaryKey:
    - Film\_Id
    - Person\_Id
  Properties:
    - Name: Rating
      DataType: TextVariableLength
  Relationships:
    - Name: PersonPersonLikesFilm
      Source: PersonLikesFilm
      Target: Person
      From:
        - Person\_Id
      To:
        - Person\_Id
      Readings:
        - PersonLikesFilm involves Person
        - Person is involved in PersonLikesFilm
  TypeReadings:
    - Person likes Film
  IsRelationshipType: true
```

\---

## Data Types

UMS uses a set of portable, implementation-agnostic data type names that map to native types in each target platform.

|UMS DataType|Description|
|-|-|
|`TextVariableLength`|Variable-length string|
|`TextFixedLength`|Fixed-length string|
|`Integer`|Whole number|
|`Decimal`|Fixed-precision number|
|`Float`|Floating-point number|
|`Boolean`|True / false|
|`DateTime`|Date and time|
|`Date`|Date only|
|`Binary`|Binary / byte data|
|`UUID`|Universally unique identifier|

\---

## Motivation

Data models lose meaning as they move from design to implementation. A carefully constructed ORM diagram, rich with natural-language verbalisations and explicit relationship semantics, becomes a flat collection of tables and foreign keys the moment it reaches a relational DDL. In a graph database, relationships gain names but lose their fact-based grounding. In a document store, structure flattens and semantics dissolve entirely.

UMS addresses this by treating the semantic content of a model as a first-class artefact — something that travels with the schema, not something that is discarded at the point of physical design.

\---

## Relationship to ORM and Fact-Based Modelling

UMS draws directly on Object-Role Modelling (ORM) and fact-based modelling traditions. The Readings carried by each property and relationship are elementary fact types in the ORM sense: binary predicates that express a single, irreducible assertion about the domain. This grounding gives UMS models a precision and verifiability that entity-attribute-value and property-graph formats do not provide natively.

\---

## Roadmap

* \[ ] Formal JSON Schema validation schema for UMS documents
* \[ ] Reference mappings: UMS → relational DDL (PostgreSQL, SQL Server)
* \[ ] Reference mappings: UMS → graph schema (Neo4j Cypher, Apache AGE)
* \[ ] Reference mappings: UMS → document schema (MongoDB, Cosmos DB)
* \[ ] UMS → OWL / RDF ontology export
* \[ ] LLM prompt templates using UMS Readings for query generation
* \[ ] Reference parser and validator (Python)

\---

## Contributing

Contributions, discussion, and critique are welcome. If you work with data models across multiple storage paradigms and have views on what a portable metamodel format should carry, please open an issue or start a discussion.

\---

## License

MIT License. See [LICENSE](LICENSE) for details.


