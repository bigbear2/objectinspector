unit OIForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    lv1: TListView;
    edt1: TEdit;
    Button1: TButton;
    tmr1: TTimer;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    F: TControl;
  end;

var
  Form1: TForm1;

implementation

uses
  ObjectInspector;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  OI: TObjectInspector;
  List:TStringList;
begin
  List := TStringList.Create;
  List.Add('Asino');
  List.Add('Capriolo');

  OI := TObjectInspector.Create(lv1);
  OI.AddText('Text1', 'Prova');
  OI.AddText('Text2', 'Prova');
  OI.AddComboBox('Text3', 'Prova',List);
  OI.AddText('Text4', 'Prova');

end;

end.

