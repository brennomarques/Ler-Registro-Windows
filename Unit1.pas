unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Registry, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    ListView1: TListView;
    BitBtnverifica2: TBitBtn;
    BitBtn3: TBitBtn;

    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnverifica2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.BitBtn1Click(Sender: TObject);
const
  UNINST_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall';
var
  Reg: TRegistry;
  SubKeys: TStringList;
  ListItem: TlistItem;
  i: integer;
  sDisplayName, sUninstallString: string;
begin

  ListView1.ViewStyle := vsReport;
  ListView1.Columns.add;
  ListView1.Columns.add;
  ListView1.Columns[0].caption := 'Nome / DisplayName';
  ListView1.Columns[1].caption := 'Desinstalação / UninstallString';
  ListView1.Columns[0].Width := 300;
  ListView1.Columns[1].Width := 300;

  Reg := TRegistry.Create;
  with Reg do
    try
      with ListView1.Items do
        try
          BeginUpdate;
          Clear;
          RootKey := HKEY_LOCAL_MACHINE;
          if OpenKeyReadOnly(UNINST_PATH) then
          begin
            SubKeys := TStringList.Create;
            try
              GetKeyNames(SubKeys);
              CloseKey;
              for i := 0 to subKeys.Count - 1 do
                if OpenKeyReadOnly(Format('%s\%s', [UNINST_PATH, SubKeys[i]])) then
                  try
                    sDisplayName     := ReadString('DisplayName');
                    sUninstallString := ReadString('UninstallString');
                    if sDisplayName <> '' then
                    begin
                      ListItem         := Add;
                      ListItem.Caption := sDisplayName;
                      ListItem.subitems.Add(sUninstallString);
                    end;
                  finally
                    CloseKey;
                  end;
            finally
              SubKeys.Free;
            end;
          end;
        finally
          ListView1.AlphaSort;
          EndUpdate;
        end;
    finally
      CloseKey;
      Free;
    end;
end;
procedure TForm1.BitBtnverifica2Click(Sender: TObject);
const
  UNINST_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall';
var
  Reg: TRegistry;
  SubKeys: TStringList;
  ListItem: TlistItem;
  i: integer;
  sDisplayName, sUninstallString: string;
begin

  ListView1.ViewStyle := vsReport;
  ListView1.Columns.add;
  ListView1.Columns.add;
  ListView1.Columns[0].caption := 'Nome / DisplayName';
  ListView1.Columns[1].caption := 'Desinstalação / UninstallString BML';
  ListView1.Columns[0].Width := 300;
  ListView1.Columns[1].Width := 300;

  Reg := TRegistry.Create;
  with Reg do
    try
      with ListView1.Items do
        try
          BeginUpdate;
          Clear;
          RootKey := HKEY_LOCAL_MACHINE;
          if OpenKeyReadOnly(UNINST_PATH) then
          begin
            SubKeys := TStringList.Create;
            try
              GetKeyNames(SubKeys);

              CloseKey;
              for i := 0 to subKeys.Count - 1 do
                if OpenKeyReadOnly(Format('%s\%s', [UNINST_PATH, SubKeys[i]])) then
                  try
                    sDisplayName     := ReadString('DisplayName');
                    sUninstallString := ReadString('UninstallString');
                    if sDisplayName <> '' then
                    begin
                      ListItem:= Add;
                      ListItem.Caption := sDisplayName;
                      ListItem.subitems.Add(sUninstallString);
                    end;
                  finally
                    CloseKey;
                  end;
            finally
              SubKeys.Free;
            end;
          end;
        finally
          ListView1.AlphaSort;
          EndUpdate;
        end;
    finally
      CloseKey;
      Free;
    end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var Reg : TRegistry;
    S : String;
begin

   Reg:= TRegistry.Create;
   Reg.rootKey:=HKEY_LOCAL_MACHINE;
   Reg.openKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinRAR archiver', false);
   S:= Reg.ReadString('DisplayName');
   ShowMessage('Nome: '+S);
   Reg.CloseKey;
   Reg.Free;

end;

end.
