unit Data;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtDlgs, aiOGL, stdctrls, extctrls, jpeg;

type

  TData1 = class(TDataModule)
    ColorDialog: TColorDialog;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenPictureDialog;
    OpenPictureDialog: TOpenPictureDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure OpenDialogSelectionChange(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PBPaint(Sender: TObject);
  private
    ValidPicture: boolean;
  end;

  procedure ShowColor(Color: TColor; C1,C2,C3: TControl; Shape: TControl);
  procedure ShowVector(Vector: TVector; C1,C2,C3: TControl);
  function  GetVector(C1,C2,C3: TControl): TVector;

var
  Data1: TData1;
  PB: TPaintBox;
  PL: TLabel;
  JpegImage: TJpegImage;

implementation

{$R *.DFM}

// раскладывает TColor на составляющие R G B
procedure ShowColor(Color: TColor; C1,C2,C3: TControl; Shape: TControl);
var
  CB: TColorB;
begin
  CB:= ColorToColorB(Color, 255);
  C1.SetTextBuf(PChar(IntToStr(CB.R)));
  C2.SetTextBuf(PChar(IntToStr(CB.G)));
  C3.SetTextBuf(PChar(IntToStr(CB.B)));
  TShape(Shape).Brush.Color:= Color;
end;

procedure ShowVector(Vector: TVector; C1,C2,C3: TControl);
begin
  C1.SetTextBuf(PChar(Format('%f', [Vector.X])));
  C2.SetTextBuf(PChar(Format('%f', [Vector.Y])));
  C3.SetTextBuf(PChar(Format('%f', [Vector.Z])));
end;

// читает TVector без проверки на правильность ввода
function GetVector(C1,C2,C3: TControl): TVector;
var
  Buffer: PChar;
begin
  GetMem(Buffer, 100);
  C1.GetTextBuf(Buffer, C1.GetTextLen + 1);

  Result.X:= StrToFloat(Buffer);
  C2.GetTextBuf(Buffer, C2.GetTextLen + 1);
  Result.Y:= StrToFloat(Buffer);
  C3.GetTextBuf(Buffer, C3.GetTextLen + 1);
  Result.Z:= StrToFloat(Buffer);

  FreeMem(Buffer, 100);
end;


procedure TData1.PBPaint(Sender: TObject);
var
  DrawRect: TRect;
begin
  DrawRect := PB.ClientRect;
  if ValidPicture then
    with DrawRect do    // рисование взято из ExtDlgs.TOpenPictureDialog.PaintBoxPaint
      begin
        if (JpegImage.Width > Right - Left) or (JpegImage.Height > Bottom - Top) then
        begin
          if JpegImage.Width > JpegImage.Height then
            Bottom := Top + MulDiv(JpegImage.Height, Right - Left, JpegImage.Width)
          else
            Right := Left + MulDiv(JpegImage.Width, Bottom - Top, JpegImage.Height);
          PB.Canvas.StretchDraw(DrawRect, JpegImage);
        end
        else

   PB.Canvas.Draw(Left + (Right - Left - JpegImage.Width) div 2, Top + (Bottom - Top -
              JpegImage.Height) div 2, JpegImage);
      end else
        PB.Canvas.Rectangle(0, 0, PB.Width, PB.Height);
end;

procedure TData1.DataModuleCreate(Sender: TObject);
begin
  OpenDialog.Filter:= '3DStudio files (*.3ds)  3da Files|*.3ds;*.3da|3DStudio files (*.3ds)|*.3ds|3da Files|*.3da';
  JpegImage:= TJpegImage.Create;
  PB:= OpenDialog.FindComponent('PaintBox') as TPaintBox;
  PB.OnPaint:= PBPaint;
  PL:= OpenDialog.FindComponent('PictureLabel') as TLabel;
end;

procedure TData1.OpenDialogSelectionChange(Sender: TObject);
var
  f: TFileStream;
  Pos: cardinal;
begin
  ValidPicture:= False;
  with OpenDialog do
  if FileExists(FileName) and (UpperCase(ExtractFileExt(FileName)) = '.3DA')  then
    try
      f:= TFileStream.Create(FileName, fmOpenRead);
      try
      Pos:= PicturePosition(f);
      if Pos <> 0 then        // если Pos = 0 - файл был сохранен без картинки
        begin                  // PutPictureInFile: boolean = True;
          f.Position:= Pos;           // это позиция сохраненной картинки в jpeg формате
          JpegImage.LoadFromStream(f);  // загрузить
          ValidPicture:= True;
          PL.Caption:= Format('%d X %d', [JpegImage.Width,JpegImage.Height]);
        end;
      finally
        f.Free;
      end;
    except
      ValidPicture:= False;
    end;
  PB.Invalidate;
end;

procedure TData1.DataModuleDestroy(Sender: TObject);
begin
  JpegImage.Free;
end;

end.
