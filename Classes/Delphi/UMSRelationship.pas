unit UMSRelationship;

interface

uses System, System.Generics.Collections, UMSConstants, UMSFacts;

type
  TUMSRelationshipDefinition = class
  private
    FName, FLabel, FSource, FTarget: string;
    FFrom, FTo, FReadings: TList<string>;
    FEmbed: System.Nullable<Boolean>;
    FCardinality: System.Nullable<TUMSCardinality>;
    FFacts: TObjectList<TUMSFacts>;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property Label: string read FLabel write FLabel;
    property Source: string read FSource write FSource;
    property Target: string read FTarget write FTarget;
    property From: TList<string> read FFrom write FFrom;
    property To_: TList<string> read FTo write FTo;
    property Embed: System.Nullable<Boolean> read FEmbed write FEmbed;
    property Cardinality: System.Nullable<TUMSCardinality> read FCardinality write FCardinality;
    property Readings: TList<string> read FReadings write FReadings;
    property Facts: TObjectList<TUMSFacts> read FFacts write FFacts;
  end;

implementation

constructor TUMSRelationshipDefinition.Create;
begin
  inherited;
  FFrom := TList<string>.Create;
  FTo := TList<string>.Create;
  FReadings := TList<string>.Create;
end;

destructor TUMSRelationshipDefinition.Destroy;
begin
  FFacts.Free;
  FReadings.Free;
  FTo.Free;
  FFrom.Free;
  inherited;
end;

end.
