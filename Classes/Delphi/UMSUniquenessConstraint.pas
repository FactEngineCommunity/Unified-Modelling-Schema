unit UMSUniquenessConstraint;

interface

uses System.Generics.Collections;

type
  TUMSUniquenessConstraint = class
  private
    FName: string;
    FProperties: TList<string>;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property Properties: TList<string> read FProperties write FProperties;
  end;

implementation

constructor TUMSUniquenessConstraint.Create;
begin
  inherited;
  FProperties := TList<string>.Create;
end;

destructor TUMSUniquenessConstraint.Destroy;
begin
  FProperties.Free;
  inherited;
end;

end.
