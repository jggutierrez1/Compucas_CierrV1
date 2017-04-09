unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dbf, DB, fpcsvexport, fpfixedexport, FileUtil,
  ZConnection, ZDataset, ZSqlMonitor, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, IniFiles;

type

  { TfMain }

  TfMain = class(TForm)
    DBGrid1: TDBGrid;
    oDs_Op: TDataSource;
    oQry_Op: TZQuery;
    oStart: TButton;
    oCSV_Exporter: TCSVExporter;
    oDs_Z: TDataSource;
    oCnn_MySql: TZConnection;
    oExit: TButton;
    oQry_Z: TZQuery;
    ZSQLMonitor1: TZSQLMonitor;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure oExitClick(Sender: TObject);
    procedure oStartClick(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  oINI: TINIFile;
  cSql_ln: string;
  cSuc_id, cEst_Id, cZ, cZfecha: string;
  cSql_File: string;
  cCSV_File: string;

  cCTA_VTA_GENE: string;
  cCTA_VTA_EXEN: string;
  cCTA_VTA_GRAV: string;
  cCTA_VTA_IMP07: string;
  cCTA_VTA_IMP10: string;
  cCTA_VTA_IMP15: string;

  cCTA_CMP_GENE: string;
  cCTA_CMP_EXEN: string;
  cCTA_CMP_GRAV: string;
  cCTA_CMP_IMP07: string;
  cCTA_CMP_IMP10: string;
  cCTA_CMP_IMP15: string;
  iAutoRun: integer;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.oExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  cPath, cFile, cSrv_act: string;
begin
  cPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  cFile := cPath + 'cierre_conta.ini';
  cSql_File := cPath + 'SQL_SENTENSES.SQL';
  if fileexists(cFile) = True then
  begin
    oINI := TINIFile.Create(cFile);

    iAutoRun := oINI.ReadInteger('DBF-INFO', 'AUTORUN', 0);
    cCTA_VTA_GENE := oINI.ReadString('DBF-INFO', 'CTA_VTA_GENE', '');
    cCTA_VTA_EXEN := oINI.ReadString('DBF-INFO', 'CTA_VTA_EXEN', '');
    cCTA_VTA_GRAV := oINI.ReadString('DBF-INFO', 'CTA_VTA_GRAV', '');
    cCTA_VTA_IMP07 := oINI.ReadString('DBF-INFO', 'CTA_VTA_IMP07', '');
    cCTA_VTA_IMP10 := oINI.ReadString('DBF-INFO', 'CTA_VTA_IMP10', '');
    cCTA_VTA_IMP15 := oINI.ReadString('DBF-INFO', 'CTA_VTA_IMP15', '');

    cCTA_CMP_GENE := oINI.ReadString('DBF-INFO', 'CTA_CMP_GENE', '');
    cCTA_CMP_EXEN := oINI.ReadString('DBF-INFO', 'CTA_CMP_EXEN', '');
    cCTA_CMP_GRAV := oINI.ReadString('DBF-INFO', 'CTA_CMP_GRAV', '');
    cCTA_CMP_IMP07 := oINI.ReadString('DBF-INFO', 'CTA_CMP_IMP07', '');
    cCTA_CMP_IMP10 := oINI.ReadString('DBF-INFO', 'CTA_CMP_IMP1', '');
    cCTA_CMP_IMP15 := oINI.ReadString('DBF-INFO', 'CTA_CMP_IMP15', '');

    cCSV_File := cPath + FormatDateTime('yyyy-mm-dd_hhnnss', now()) + '-movto.CSV';
    self.oCSV_Exporter.FileName := cCSV_File;
    if (fileexists(cCSV_File) = True) then
    begin
      deletefile(cCSV_File);
    end;
    oINI.Free;

    cPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
    cFile := cPath + 'data\Config_estac.ini';
    oINI := TINIFile.Create(cFile);

    self.oCnn_MySql.Connected := False;

    cSrv_act := oINI.ReadString('GENERAL', 'SRV_ACTIV', 'RCTECH');
    cSuc_id := oINI.ReadString('GENERAL', 'SUC_ACTIV', '2');
    cEst_Id := oINI.ReadString('GENERAL', 'EST_ACTIV', '1');

    cSrv_act := trim(cSrv_act);
    cSuc_id := trim(cSuc_id);
    cEst_Id := trim(cEst_Id);

    self.oCnn_MySql.HostName := oINI.ReadString(cSrv_act, 'Servidor', 'localhost');
    self.oCnn_MySql.User := oINI.ReadString(cSrv_act, 'Usuario', 'root');
    self.oCnn_MySql.Password := oINI.ReadString(cSrv_act, 'Clave', '');
    self.oCnn_MySql.Port := oIni.ReadInteger(cSrv_act, 'Puerto', 3306);
    self.oCnn_MySql.Database := oINI.ReadString(cSrv_act, 'base', '');
    self.oCnn_MySql.Catalog := oINI.ReadString(cSrv_act, 'base', '');
    self.oCnn_MySql.Connected := True;
    oINI.Free;
  end;

end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  if iAutoRun = 1 then
  begin
    self.oStartClick(self);
    Close;
  end;

end;

procedure TfMain.oStartClick(Sender: TObject);
begin
  cSql_ln := '';
  cSql_ln := cSql_ln + 'SELECT ci_op_id,ci_op_fecha ';
  cSql_ln := cSql_ln + 'FROM cierres_gen_v2 ';
  cSql_ln := cSql_ln + 'WHERE suc_id=' + QuotedStr(cSuc_id) + ' ';
  cSql_ln := cSql_ln + 'AND ci_op_estacion=' + QuotedStr(cEst_Id) + ' ';
  cSql_ln := cSql_ln + 'AND tipo="Z" AND abierto="false" ';

  self.oQry_Z.Close;
  self.oQry_Z.SQL.Text := cSql_ln;
  self.oQry_Z.Open;
  cZ := trim(oQry_Z.FieldByName('ci_op_id').AsString);
  cZfecha := formatdatetime('yyyy-mm-dd', oQry_Z.FieldByName('ci_op_fecha').AsDateTime);


  if (fileexists(cSql_File) = True) then
  begin
    self.oQry_Op.Close;
    self.oQry_Op.Params.Clear;
    self.oQry_Op.SQL.Clear;
    self.oQry_Op.SQL.LoadFromFile(cSql_File);

    self.oQry_Op.ParamByName('cSUC_ID').AsString := (cSUC_ID);
    self.oQry_Op.ParamByName('cEST_ID').AsString := (cEST_ID);
    self.oQry_Op.ParamByName('cZET_ID').AsString := (cZ);
    self.oQry_Op.ParamByName('cZFECHA').AsString := (cZfecha);

    self.oQry_Op.ParamByName('cCTA_VTA_GENE').AsString := (cCTA_VTA_GENE);
    self.oQry_Op.ParamByName('cCTA_VTA_EXEN').AsString := (cCTA_VTA_EXEN);
    self.oQry_Op.ParamByName('cCTA_VTA_GRAV').AsString := (cCTA_VTA_GRAV);
    self.oQry_Op.ParamByName('cCTA_VTA_IMP07').AsString := (cCTA_VTA_IMP07);
    self.oQry_Op.ParamByName('cCTA_VTA_IMP10').AsString := (cCTA_VTA_IMP10);
    self.oQry_Op.ParamByName('cCTA_VTA_IMP15').AsString := (cCTA_VTA_IMP15);

    self.oQry_Op.ParamByName('cCTA_CMP_GENE').AsString := (cCTA_CMP_GENE);
    self.oQry_Op.ParamByName('cCTA_CMP_EXEN').AsString := (cCTA_CMP_EXEN);
    self.oQry_Op.ParamByName('cCTA_CMP_GRAV').AsString := (cCTA_CMP_GRAV);
    self.oQry_Op.ParamByName('cCTA_CMP_IMP07').AsString := (cCTA_CMP_IMP07);
    self.oQry_Op.ParamByName('cCTA_CMP_IMP10').AsString := (cCTA_CMP_IMP10);
    self.oQry_Op.ParamByName('cCTA_CMP_IMP15').AsString := (cCTA_CMP_IMP15);
    self.oQry_Op.Open;
    SELF.oCSV_Exporter.FormatSettings.RowDelimiter := #13#10;
    SELF.oCSV_Exporter.FormatSettings.QuoteChar := '"';
    SELF.oCSV_Exporter.FormatSettings.FieldDelimiter := ',';
    SELF.oCSV_Exporter.FileName := cCSV_File;
    SELF.oCSV_Exporter.Execute;
  end;
end;

end.
