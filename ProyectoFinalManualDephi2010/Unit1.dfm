object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 609
  ClientWidth = 1248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 97
    Width = 42
    Height = 11
    Caption = 'NOMBRE'
  end
  object Label2: TLabel
    Left = 16
    Top = 131
    Width = 27
    Height = 13
    Caption = 'EDAD'
  end
  object Label3: TLabel
    Left = 16
    Top = 163
    Width = 33
    Height = 13
    Caption = 'FECHA'
  end
  object Label4: TLabel
    Left = 16
    Top = 65
    Width = 18
    Height = 13
    Caption = 'DNI'
  end
  object ButtonCrete: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Crear'
    TabOrder = 0
    OnClick = ButtonCreteClick
  end
  object ButtonRead: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ver'
    TabOrder = 1
    OnClick = ButtonReadClick
  end
  object ButtonUpdate: TButton
    Left = 170
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Actualizar'
    TabOrder = 2
    OnClick = ButtonUpdateClick
  end
  object ButtonDelete: TButton
    Left = 251
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Eliminar'
    TabOrder = 3
    OnClick = ButtonDeleteClick
  end
  object EditNombre: TDBEditEh
    Left = 112
    Top = 94
    Width = 214
    Height = 21
    EditButtons = <>
    TabOrder = 4
    Visible = True
  end
  object EditEdad: TDBEditEh
    Left = 112
    Top = 128
    Width = 73
    Height = 21
    EditButtons = <>
    TabOrder = 5
    Visible = True
  end
  object EditFecha: TcxDateEdit
    Left = 112
    Top = 160
    TabOrder = 6
    Width = 214
  end
  object EditDni: TDBEditEh
    Left = 112
    Top = 62
    Width = 214
    Height = 21
    EditButtons = <>
    TabOrder = 7
    Visible = True
  end
  object DBGridEh1: TDBGridEh
    Left = 352
    Top = 8
    Width = 888
    Height = 593
    AutoFitColWidths = True
    DataSource = DataSource1
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = Q_PERSONAS
    Left = 112
    Top = 336
  end
  object CONEXION_ORACLE: TOraSession
    Username = 'AT_TIER1'
    Password = 'fuego'
    Server = 'NCLIENTES'
    Connected = True
    Left = 200
    Top = 336
  end
  object Q_PERSONAS: TOraQuery
    Session = CONEXION_ORACLE
    CachedUpdates = True
    Left = 32
    Top = 336
  end
end
