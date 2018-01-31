program OInsp;

uses
  Vcl.Forms,
  OIForm in 'OIForm.pas' {Form1},
  ObjectInspector in 'ObjectInspector.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
