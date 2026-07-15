---
title: Modelling with UMS
description: A practical sequence for creating a clear, portable semantic model.
---

## 1. Name domain types

Create one type for each stable domain concept: `Person`, `Film`, `Booking`, or `Session`. Use a business name rather than a storage-specific name. Give entity types one or more `Labels`; these can become graph labels or physical table names in a target.

## 2. Define identity before attributes

List the property names that identify an instance in `PrimaryKey`. A composite key is an ordered list. Add every key property to `Properties` and mark required fields with `NOT NULL`.

Use `UniquenessConstraints` for alternate composite identifiers. Single-property alternate identifiers can be expressed with `UNIQUE` on the property.

## 3. Add portable properties

Choose a UMS datatype instead of a database vendor datatype. `TextVariableLength`, `TextFixedLength`, `Integer`, and `DateTime` are portable examples. Use `Length` and `Precision` only where they carry meaning for the chosen type.

Where the business vocabulary differs from an implementation name, record `FactBasedName` or `Alias`. For collection-valued properties, use `IsArray` and `ArrayConstraints` deliberately; a separate type is often clearer when the values have their own identity or relationships.

## 4. State every relationship explicitly

Create a relationship entry wherever one type refers to another. `Source` and `Target` name the participating types; `From` and `To` map their corresponding properties. Do not rely on a matching property name alone to communicate the relationship.

For a relationship that is meaningful in its own right—such as a rating, membership, or booking—model a relationship type. Give it `Source`, `Target`, a short `Label`, a `RelationshipAnnotation`, and its own properties if needed.

## 5. Add readings people can validate

Use `FactTypeReadings` to group readings by language. Start with `English`, and use both directions when that improves clarity.

```yaml
FactTypeReadings:
  - Language: English
    Readings:
      - Booking is for Session
      - Session has Booking
```

Readings should describe one business fact, not a physical implementation detail. Prefer “Booking is for Session” over “Booking.Session_Id references Session.”

## 6. Review across paradigms

Ask four questions before treating a model as complete:

1. Could a relational implementer derive tables, keys, and foreign keys?
2. Could a graph implementer identify node labels, edge labels, and relationship properties?
3. Could a document implementer identify aggregate boundaries and safe embedding candidates?
4. Can a domain expert read the fact statements and confirm their meaning?

If the answer is yes to all four, the model is portable without losing its semantics.
