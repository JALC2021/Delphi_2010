unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, GridsEh, DBGridEh, StdCtrls, Mask,
  DBCtrlsEh, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxCurrencyEdit, ComCtrls, dxCore,
  cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    CONEXION_ORACLE: TOraSession;
    Q_PERSONAS: TOraQuery;
    ButtonCrete: TButton;
    ButtonRead: TButton;
    ButtonUpdate: TButton;
    ButtonDelete: TButton;
    EditNombre: TDBEditEh;
    EditEdad: TDBEditEh;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditFecha: TcxDateEdit;
    Label4: TLabel;
    EditDni: TDBEditEh;
    DBGridEh1: TDBGridEh;
    procedure ButtonCreteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonReadClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);

  private
    { Private declarations }
    contador: Integer;
    procedure RefrescarConsulta;
    procedure LimpiarDatos;
  public
    { Public declarations }

end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   Q_PERSONAS.Close;
   Q_PERSONAS.SQL.Text := 'SELECT * FROM PRUEBA_PERSONAS_DELPHI_TBL';
   Q_PERSONAS.Open;
end;

procedure TForm1.ButtonCreteClick(Sender: TObject);
begin
   try
      Q_PERSONAS.SQL.Text := 'INSERT INTO PRUEBA_PERSONAS_DELPHI_TBL (DNI, NOMBRE, EDAD, FECHA) VALUES (:DNI, :NOMBRE, :EDAD, :FECHA)';

      if Trim(UpperCase(EditDni.Text)) = '' then
         raise Exception.Create('El campo Dni debe estar informado.')
      else
      begin
         if Length(Trim(UpperCase(EditDni.Text))) <> 9 then
          raise Exception.Create('El campo Dni debe estar formado por 8 digitos y una letra final.')
         else
            Q_PERSONAS.ParamByName('DNI').AsString := Trim(UpperCase(EditDni.Text));
      end;

      if Trim(UpperCase(EditNombre.Text)) = '' then
         raise Exception.Create('El campo Nombre debe estar informado.')
      else
         Q_PERSONAS.ParamByName('NOMBRE').AsString := UpperCase(EditNombre.Text);

      if EditEdad.Value <= 0 then
         raise Exception.Create('El campo Edad debe ser mayor que 0.')
      else
         Q_PERSONAS.ParamByName('EDAD').AsInteger := EditEdad.Value;

      if EditFecha.Text = '' then
         Q_PERSONAS.ParamByName('FECHA').AsDate := Date
      else
         Q_PERSONAS.ParamByName('FECHA').AsDate := EditFecha.Date;

      Q_PERSONAS.ExecSQL;

      RefrescarConsulta;

      MessageDlg('DNI: ' + Trim(UpperCase(EditDni.Text)) + ' - Persona: ' + UpperCase(EditNombre.Text) + ' creado correctamente.', mtInformation, [mbOK], 0);

      Inc(contador);

      LimpiarDatos;
   except
     on E: Exception do
     begin
       // Maneja cualquier excepción o error que ocurra durante la eliminación
       ShowMessage('Error al crear la persona: ' + E.Message);
     end;
   end;
end;

procedure TForm1.ButtonReadClick(Sender: TObject);
begin
   RefrescarConsulta;
end;

procedure TForm1.ButtonUpdateClick(Sender: TObject);
begin
   try
      Q_PERSONAS.SQL.Text := 'UPDATE PRUEBA_PERSONAS_DELPHI_TBL SET NOMBRE = :NOMBRE, EDAD = :EDAD, FECHA = :FECHA WHERE DNI = :DNI';

      if Trim(UpperCase(EditDni.Text)) = '' then
         raise Exception.Create('El campo Dni debe estar informado.')
      else
      begin
         if Length(Trim(UpperCase(EditDni.Text))) <> 9 then
          raise Exception.Create('El campo Dni debe estar formado por 8 digitos y una letra final.')
         else
            Q_PERSONAS.ParamByName('DNI').AsString := Trim(UpperCase(EditDni.Text));
      end;

      if Trim(UpperCase(EditNombre.Text)) = '' then
         raise Exception.Create('El campo Nombre debe estar informado.')
      else
         Q_PERSONAS.ParamByName('NOMBRE').AsString := UpperCase(EditNombre.Text);

      if EditEdad.Value <= 0 then
         raise Exception.Create('El campo Edad debe ser mayor que 0.')
      else
         Q_PERSONAS.ParamByName('EDAD').AsInteger := EditEdad.Value;

      if EditFecha.Text = '' then
         Q_PERSONAS.ParamByName('FECHA').AsDate := Date
      else
         Q_PERSONAS.ParamByName('FECHA').AsDate := EditFecha.Date;

      Q_PERSONAS.ExecSQL;

      RefrescarConsulta;

      MessageDlg('DNI: ' + Trim(UpperCase(EditDni.Text)) + ' - Persona: ' + UpperCase(EditNombre.Text) + ' actualizado correctamente.', mtInformation, [mbOK], 0);

      Inc(contador);

      LimpiarDatos;
   except
     on E: Exception do
     begin
       // Maneja cualquier excepción o error que ocurra durante la eliminación
       ShowMessage('Error al actualizar la persona: ' + E.Message);
     end;
   end;
end;

procedure TForm1.ButtonDeleteClick(Sender: TObject);
   var DniDelRegistroSeleccionado : String;
begin
    // Verifica si el conjunto de datos no está vacío
   if not Q_PERSONAS.IsEmpty then
   begin
    if MessageDlg('¿Está segur@ de que desea eliminar la persona seleccionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
         DniDelRegistroSeleccionado := Q_PERSONAS.FieldByName('DNI').AsString;;

         Q_PERSONAS.SQL.Text := 'DELETE FROM PRUEBA_PERSONAS_DELPHI_TBL WHERE DNI = :DNI';
         Q_PERSONAS.ParamByName('DNI').AsString := DniDelRegistroSeleccionado;
         Q_PERSONAS.ExecSQL;

         RefrescarConsulta;

         MessageDlg('Dni: ' + DniDelRegistroSeleccionado + ' - Persona: ' + UpperCase(EditNombre.Text) + ' eliminado correctamente.', mtInformation, [mbOK], 0);
      except
        on E: Exception do
        begin
          // Maneja cualquier excepción o error que ocurra durante la eliminación
          ShowMessage('Error al eliminar el registro: ' + E.Message);
        end;
      end;
    end;
   end
   else
    ShowMessage('No hay registros para eliminar.');
end;

procedure TForm1.RefrescarConsulta;
begin
   Q_PERSONAS.Close;
   Q_PERSONAS.SQL.Text := 'SELECT * FROM PRUEBA_PERSONAS_DELPHI_TBL';
   Q_PERSONAS.Open;
end;

procedure TForm1.LimpiarDatos;
begin
   EditDni.Clear;
   EditNombre.Clear;
   EditEdad.Clear;
   EditFecha.Clear;
end;

end.
