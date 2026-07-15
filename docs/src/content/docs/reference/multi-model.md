---
title: Multi-model modelling
description: Keep one semantic model while serving relational, graph, and document workloads.
---

Multi-model work is not simply storing the same data in several engines. It is preserving one domain meaning while selecting the representation that best serves each workload. UMS provides the shared logical contract.

## Use UMS as the canonical layer

Keep types, identifiers, properties, constraints, relationships, and readings in the UMS model. Generate or design target views from it:

| Need | Useful representation |
| --- | --- |
| Transactions, integrity, reporting | Relational tables and foreign keys. |
| Traversal, path finding, connected-data queries | Graph nodes and named edges. |
| Aggregate retrieval and API payloads | Embedded or referenced documents. |
| Semantic search, assistance, and documentation | Fact type readings and facts. |

The target representations may differ, but they should point back to the same type names and business identities.

## Do not let projections become the model

A document may embed a `Row` inside a `Cinema`. A graph may store `LIKES` as an edge. A relational database may store that same fact in an associative table. These are projections of the same relationship; none should silently redefine its cardinality, endpoints, or business meaning.

## Resolve common differences explicitly

- **Identity:** retain `PrimaryKey` even where a target has an internal identifier.
- **Naming:** keep UMS names stable; apply target naming conventions during generation.
- **Cardinality:** state it in the logical relationship and use document `Embed`/`Cardinality` as materialisation hints.
- **Constraints:** preserve mandatory and uniqueness rules in every target that can enforce them; validate elsewhere when it cannot.
- **Semantics:** keep fact type readings with the source model and publish them with generated artefacts.

## A practical delivery pattern

1. Review and approve the UMS model with domain experts.
2. Generate or hand-map a relational representation for integrity and reporting.
3. Materialise graph or document projections for the access patterns that need them.
4. Test that identifiers, relationship endpoints, and readings remain traceable to the canonical UMS type.
5. Version the UMS document alongside generated schema artefacts.

This pattern gives each platform the shape it needs without creating several competing definitions of the domain.
