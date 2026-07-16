unit UMSProperty;

interface

uses System, System.Generics.Collections, UMSConstants, UMSFactTypeReadings, UMSFacts;

type
  TUMSArrayConstraints = class
  private
    FMinItems: System.Nullable<Integer>;
    FMaxItems: System.Nullable<Integer>;
    FUnique: System.Nullable<Boolean>;
  public
    property MinItems: System.Nullable<Integer> read FMinItems write FMinItems;
    property MaxItems: System.Nullable<Integer> read FMaxItems write FMaxItems;
    property Unique: System.Nullable<Boolean> read FUnique write FUnique;
  end;

  TUMSPropertyDefinition = class
  private
    FName, FFactBasedName, FAlias: string;
    FDataType: TUMSDataType;
    FLength, FPrecision: System.Nullable<Integer>;
    FConstraints: TList<TUMSConstraint>;
    FFactTypeReadings: TObjectList<TUMSFactTypeReadings>;
    FFacts: TObjectList<TUMSFacts>;
    FIsArray: System.Nullable<Boolean>;
    FArrayConstraints: TUMSArrayConstraints;
  public
    destructor Destroy; override;
    property Name: string read FName write FName;
    property FactBasedName: string read FFactBasedName write FFactBasedName;
    property Alias: string read FAlias write FAlias;
    property DataType: TUMSDataType read FDataType write FDataType;
    property Length: System.Nullable<Integer> read FLength write FLength;
    property Precision: System.Nullable<Integer> read FPrecision write FPrecision;
    property Constraints: TList<TUMSConstraint> read FConstraints write FConstraints;
    property FactTypeReadings: TObjectList<TUMSFactTypeReadings> read FFactTypeReadings write FFactTypeReadings;
    property Facts: TObjectList<TUMSFacts> read FFacts write FFacts;
    property IsArray: System.Nullable<Boolean> read FIsArray write FIsArray;
    property ArrayConstraints: TUMSArrayConstraints read FArrayConstraints write FArrayConstraints;
  end;

implementation

destructor TUMSPropertyDefinition.Destroy;
begin
  FArrayConstraints.Free;
  FFacts.Free;
  FFactTypeReadings.Free;
  FConstraints.Free;
  inherited;
end;

end.
