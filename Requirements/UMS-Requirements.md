The following are the required elements of the Unified Data Schema per modelling-regime/database type.



# Relational / Entity Relationship Diagrams

The following are the UMS requirements for relational databases.

## Tables

Tables / Entities (Entity Types) need to be included by name.

## Attributes / Fields

Attributes / Fields, for Tables, need to be listed by name and with relevant Data Types, with length and precision (See Data Types below).
Included for each Attribute/Field/Column must be its Data Type and whether the Attribute/Field/Column is unique for the Table/Entity(Entity Type).
Data Types for Attributes/Fields/Columns must include Length and Precision where required.

## Foreign Key References

Foreign Key References need to be listed per Table / Entity (Entity Type), including the From and To/Destination Columns.

## Primary Keys

Primary Keys for a Table / Entity (Entity Type) need to be expressed, including the Columns/Attributes of the Primary Key.

## Unique Keys

Unique Keys for a Table/Entity(Entity Type) need to be expressed, including the Columns/Attributes of the Unique Key.

## Data Types

Data Types needed to be listed by name, with annotation as to length and decimal places/precision.

======================

# Graph / Labeled Property Graphs / Property Graph Schema

The following are the UMS requirements for graph databases.

## Node Types/Verticies

Node Types need to be included by name.

## Properties

Properties, for Node Types, need to be listed by name and with relevant Data Types, with length and precision (See Data Types below).
Included for each Property must be its Data Type and whether the Property is unique for the Node Type.
Data Types for Property must include Length and Precision where required.

## Edges / Relationships

Edges/Relationships must be catered for, including any Properties that are specific to a Relationship, including the metadata for the Properties (DataType, Length, Precision).

## Label / Labels

Each Edge/Relationship is to have one Label (E.g. IS_IN) for a Graph Schema within the UMS, and each Node Type must be able to have one or more Labels (E.g. Person, Employee).

NB Labels are optional, but if there is to be a Graph Schema within the overall UMS document, then the Label/Labels for the relevant Relationship/Node Types must be included.

=======================

# Fact-Based Modelling

The following are the UMS requirements for Fact-Based/Semantic modelling.

## Value Types

Value Types must be captured, including DataType and Length and Precision where required. Value Types may appear by way of Attributes/Properties/Fields/Columns.

## Entity Types

Entity Types must be captured, and may be by way of Tables/Node Types.

## Fact Types

Fact Types must be able to be captured, but may be implied by Fact Type Readings, or Tables/Node Types when it comes to Objectified Fact Types.

## Fact Type Readings

Fact Type Readings must be able to be Captured for Relationships, Properties and Objectified Fact Types, and as each Fact Type Reading implies a Fact Type.

## Constraints

- Uniqueness Constraints must be able to be captured (both Internal Uniqueness Constraints (E.g. A manifest as Primary Keys), and External Uniqueness Constraints (E.g. As manifest as either Primary Keys or Uniqueness Constraints).




