unit UMSModel;

interface

uses System.Generics.Collections, UMSModelElement;

type
  TUMSModel = class
  private
    FName, FUMSVersionNr, FModelVersionNr: string;
    FModelElement: TObjectList<TUMSModelElement>;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property UMSVersionNr: string read FUMSVersionNr write FUMSVersionNr;
    property ModelVersionNr: string read FModelVersionNr write FModelVersionNr;
    property ModelElement: TObjectList<TUMSModelElement> read FModelElement write FModelElement;
  end;

implementation

constructor TUMSModel.Create;
begin
  inherited;
  FUMSVersionNr := '0.1';
  FModelElement := TObjectList<TUMSModelElement>.Create;
end;

destructor TUMSModel.Destroy;
begin
  FModelElement.Free;
  inherited;
end;

end.
