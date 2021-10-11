
program IKE;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm},
  Childwin in 'CHILDWIN.PAS' {MDIChild},
  Data in 'Data.pas' {Data1: TDataModule},
  Info in 'Info.pas' {InfoForm},
  Objects in 'Objects.pas' {ObjectsDlg},
  Lighting in 'Lighting.pas' {LightingDlg},
  BG in 'BG.pas' {BGDlg},
  Texture in 'Texture.pas' {TextureForm},
  LookAt in 'LookAt.pas' {LookAtForm},
  Perspective in 'Perspective.pas' {PerspectiveForm},
  ExtDlgs in 'extdlgs.pas',
  Materials in 'Materials.pas' {MaterialsForm},
  Textures in 'Textures.pas' {TexturesForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TData1, Data1);
  Application.Run;
end.
