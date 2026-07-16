unit UMSTypeConverters;

interface

uses System.SysUtils, UMSConstants;

type
  EUMSConversionError = class(Exception);
  TUMSDataTypeConverter = class
  public
    class function FromYaml(const Value: string): TUMSDataType; static;
    class function ToYaml(const Value: TUMSDataType): string; static;
  end;
  TUMSConstraintConverter = class
  public
    class function FromYaml(const Value: string): TUMSConstraint; static;
    class function ToYaml(const Value: TUMSConstraint): string; static;
  end;

implementation

uses System.SysUtils;

class function TUMSDataTypeConverter.FromYaml(const Value: string): TUMSDataType;
begin
  if Value = 'Integer' then Result := dtInteger
  else if Value = 'DateTime' then Result := dtDateTime
  else if Value = 'TextFixedLength' then Result := dtTextFixedLength
  else if Value = 'TextVariableLength' then Result := dtTextVariableLength
  else raise EUMSConversionError.CreateFmt('Unknown DataType: ''%s''', [Value]);
end;

class function TUMSDataTypeConverter.ToYaml(const Value: TUMSDataType): string;
begin
  case Value of
    dtInteger: Result := 'Integer'; dtDateTime: Result := 'DateTime';
    dtTextFixedLength: Result := 'TextFixedLength';
    dtTextVariableLength: Result := 'TextVariableLength';
  end;
end;

class function TUMSConstraintConverter.FromYaml(const Value: string): TUMSConstraint;
begin
  if Value = 'NOT NULL' then Result := ctNotNull
  else if Value = 'UNIQUE' then Result := ctUnique
  else raise EUMSConversionError.CreateFmt('Unknown Constraint: ''%s''', [Value]);
end;

class function TUMSConstraintConverter.ToYaml(const Value: TUMSConstraint): string;
begin
  case Value of ctNotNull: Result := 'NOT NULL'; ctUnique: Result := 'UNIQUE'; end;
end;

end.
