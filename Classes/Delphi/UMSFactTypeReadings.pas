unit UMSFactTypeReadings;

interface

uses System.Generics.Collections;

type
  TUMSFactTypeReadings = class
  private
    FLanguage: string;
    FReadings: TList<string>;
  public
    constructor Create; overload;
    constructor Create(const ALanguage: string); overload;
    destructor Destroy; override;
    property Language: string read FLanguage write FLanguage;
    property Readings: TList<string> read FReadings write FReadings;
  end;

implementation

constructor TUMSFactTypeReadings.Create;
begin
  inherited Create;
end;

constructor TUMSFactTypeReadings.Create(const ALanguage: string);
begin
  inherited Create;
  FLanguage := ALanguage;
  FReadings := TList<string>.Create;
end;

destructor TUMSFactTypeReadings.Destroy;
begin
  FReadings.Free;
  inherited;
end;

end.
