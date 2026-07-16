unit UMSType;

interface

uses System.Generics.Collections, UMSProperty, UMSRelationship, UMSFactTypeReadings,
  UMSFacts, UMSUniquenessConstraint;

type
  TUMSTypeDefinition = class
  private
    FName, FLabel, FSource, FTarget, FRelationshipAnnotation: string;
    FLabels, FPrimaryKey: TList<string>;
    FProperties: TObjectList<TUMSPropertyDefinition>;
    FRelationships: TObjectList<TUMSRelationshipDefinition>;
    FFactTypeReadings: TObjectList<TUMSFactTypeReadings>;
    FFacts: TObjectList<TUMSFacts>;
    FUniquenessConstraints: TObjectList<TUMSUniquenessConstraint>;
    function GetIsRelationshipType: Boolean;
  public
    destructor Destroy; override;
    property Name: string read FName write FName; // YAML key: Type
    property Labels: TList<string> read FLabels write FLabels;
    property Label: string read FLabel write FLabel;
    property Source: string read FSource write FSource;
    property Target: string read FTarget write FTarget;
    property RelationshipAnnotation: string read FRelationshipAnnotation write FRelationshipAnnotation;
    property PrimaryKey: TList<string> read FPrimaryKey write FPrimaryKey;
    property Properties: TObjectList<TUMSPropertyDefinition> read FProperties write FProperties;
    property Relationships: TObjectList<TUMSRelationshipDefinition> read FRelationships write FRelationships;
    property FactTypeReadings: TObjectList<TUMSFactTypeReadings> read FFactTypeReadings write FFactTypeReadings;
    property Facts: TObjectList<TUMSFacts> read FFacts write FFacts;
    property UniquenessConstraints: TObjectList<TUMSUniquenessConstraint> read FUniquenessConstraints write FUniquenessConstraints;
    property IsRelationshipType: Boolean read GetIsRelationshipType;
  end;

implementation

uses System.SysUtils;

destructor TUMSTypeDefinition.Destroy;
begin
  FUniquenessConstraints.Free;
  FFacts.Free;
  FFactTypeReadings.Free;
  FRelationships.Free;
  FProperties.Free;
  FPrimaryKey.Free;
  FLabels.Free;
  inherited;
end;

function TUMSTypeDefinition.GetIsRelationshipType: Boolean;
begin
  Result := FRelationshipAnnotation <> '';
end;

end.
