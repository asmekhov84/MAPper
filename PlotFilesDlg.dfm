object dlgPlotFiles: TdlgPlotFiles
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1074#1099#1073#1086#1088#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080' '#1095#1077#1088#1090#1077#1078#1072
  ClientHeight = 474
  ClientWidth = 394
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnApply: TButton
    Left = 230
    Top = 441
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 311
    Top = 441
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object sgrPlotFilesList: TStringGrid
    Left = 8
    Top = 8
    Width = 378
    Height = 425
    ColCount = 2
    Ctl3D = True
    DefaultColWidth = 100
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 2
    ColWidths = (
      227
      118)
  end
end
