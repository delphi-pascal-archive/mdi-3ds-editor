program Shadow;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  aiOGL in '..\aiOGL.pas',
  GraphicEx in '..\GraphicEx.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
