unit UMSSerialiser;

interface

uses System.Generics.Collections, UMSType;

type
  /// <summary>
  /// Contract to implement with the YAML library used by the host application.
  /// The model classes deliberately have no dependency on a particular Delphi YAML library.
  /// </summary>
  IUMSYamlBackend = interface
    ['{0D5B70C4-AB2E-4B80-A56C-4D269D0E0709}']
    function DeserializeTypes(const Yaml: string): TObjectList<TUMSTypeDefinition>;
    function SerializeTypes(const Schema: TObjectList<TUMSTypeDefinition>): string;
  end;

  TUMSSchemaSerializer = class
  private
    class var FYamlBackend: IUMSYamlBackend;
    class procedure RequireBackend; static;
  public
    class procedure Configure(const AYamlBackend: IUMSYamlBackend); static;
    class function LoadFromFile(const FilePath: string): TObjectList<TUMSTypeDefinition>; static;
    class function LoadFromString(const Yaml: string): TObjectList<TUMSTypeDefinition>; static;
    class function SaveToString(const Schema: TObjectList<TUMSTypeDefinition>): string; static;
    class procedure SaveToFile(const Schema: TObjectList<TUMSTypeDefinition>; const FilePath: string); static;
  end;

implementation

uses System.SysUtils, System.IOUtils;

class procedure TUMSSchemaSerializer.Configure(const AYamlBackend: IUMSYamlBackend);
begin
  FYamlBackend := AYamlBackend;
end;

class procedure TUMSSchemaSerializer.RequireBackend;
begin
  if FYamlBackend = nil then
    raise EInvalidOp.Create('Configure a IUMSYamlBackend before serialising UMS YAML.');
end;

class function TUMSSchemaSerializer.LoadFromFile(const FilePath: string): TObjectList<TUMSTypeDefinition>;
begin
  Result := LoadFromString(TFile.ReadAllText(FilePath));
end;

class function TUMSSchemaSerializer.LoadFromString(const Yaml: string): TObjectList<TUMSTypeDefinition>;
begin
  RequireBackend;
  Result := FYamlBackend.DeserializeTypes(Yaml);
end;

class function TUMSSchemaSerializer.SaveToString(const Schema: TObjectList<TUMSTypeDefinition>): string;
begin
  RequireBackend;
  Result := FYamlBackend.SerializeTypes(Schema);
end;

class procedure TUMSSchemaSerializer.SaveToFile(const Schema: TObjectList<TUMSTypeDefinition>; const FilePath: string);
begin
  TFile.WriteAllText(FilePath, SaveToString(Schema));
end;

end.
