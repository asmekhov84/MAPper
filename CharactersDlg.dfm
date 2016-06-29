object dlgCharacters: TdlgCharacters
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1074#1089#1090#1072#1074#1082#1080' '#1089#1080#1084#1074#1086#1083#1072
  ClientHeight = 255
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object sgrCharacters: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 531
    Height = 208
    TabStop = False
    Align = alClient
    ColCount = 16
    Ctl3D = True
    DefaultColWidth = 30
    DefaultRowHeight = 21
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
    ParentCtl3D = False
    TabOrder = 0
    OnMouseMove = sgrCharactersMouseMove
    ExplicitWidth = 527
    ExplicitHeight = 204
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 214
    Width = 537
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 340
    ExplicitTop = 208
    ExplicitWidth = 185
    object lblCurChar: TLabel
      Left = 3
      Top = 3
      Width = 125
      Height = 23
      Caption = 'current symbol'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnApply: TButton
      Left = 459
      Top = 3
      Width = 75
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 0
      OnClick = btnApplyClick
    end
  end
end
