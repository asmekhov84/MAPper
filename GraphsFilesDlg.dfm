object dlgGraphsFiles: TdlgGraphsFiles
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1074#1099#1073#1086#1088#1072' '#1085#1072#1073#1086#1088#1072' '#1075#1088#1072#1092#1080#1082#1086#1074
  ClientHeight = 474
  ClientWidth = 391
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object sgrGraphsFilesList: TStringGrid
    Left = 8
    Top = 8
    Width = 378
    Height = 427
    Hint = #1054#1090#1084#1077#1090#1100#1090#1077' '#1086#1076#1080#1085' '#1080#1083#1080' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1092#1072#1081#1083#1086#1074' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1076#1083#1103' '#1079#1072#1075#1088#1091#1079#1082#1080
    ColCount = 2
    DefaultColWidth = 150
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 0
    OnDrawCell = sgrGraphsFilesListDrawCell
    OnTopLeftChanged = sgrGraphsFilesListTopLeftChanged
    ColWidths = (
      223
      119)
  end
  object btnOK: TButton
    Left = 230
    Top = 441
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object btnClose: TButton
    Left = 311
    Top = 441
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 8
    TabOrder = 2
  end
end
