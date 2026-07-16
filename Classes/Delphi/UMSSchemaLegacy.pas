unit UMSSchemaLegacy;

interface

uses UMSType, UMSProperty, UMSRelationship, UMSSerialiser;

type
  /// <summary>
  /// Compatibility names for the original combined UMS-Schema.vb sample.
  /// The current UMS classes add Source, Target, Facts, precision, array and
  /// uniqueness-constraint support, so consumers should use the individual units.
  /// </summary>
  TUMSSchemaTypeDefinition = TUMSTypeDefinition;
  TUMSSchemaPropertyDefinition = TUMSPropertyDefinition;
  TUMSSchemaRelationshipDefinition = TUMSRelationshipDefinition;

implementation

end.
