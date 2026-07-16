unit UMSFacts;

interface

uses System.Generics.Collections;

type
  TUMSFacts = class
  private
    FLanguage: string;
    FFacts: TList<string>;
  public
    constructor Create; overload;
    constructor Create(const ALanguage: string); overload;
    destructor Destroy; override;
    property Language: string read FLanguage write FLanguage;
    property Facts: TList<string> read FFacts write FFacts;
  end;

implementation

constructor TUMSFacts.Create;
begin
  inherited Create;
end;

constructor TUMSFacts.Create(const ALanguage: string);
begin
  inherited Create;
  FLanguage := ALanguage;
  FFacts := TList<string>.Create;
end;

destructor TUMSFacts.Destroy;
begin
  FFacts.Free;
  inherited;
end;

end.
