unit UMSConstraint;

interface

uses UMSModelElement;

type
  /// <summary>A fact-based modelling constraint expressed in controlled natural language.</summary>
  TUMSFBMConstraint = class(TUMSModelElement)
  private
    FVerbalisation: string;
  public
    property Verbalisation: string read FVerbalisation write FVerbalisation;
  end;

implementation

end.
