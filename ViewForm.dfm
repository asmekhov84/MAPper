object wndViewForm: TwndViewForm
  Left = 0
  Top = 0
  HorzScrollBar.Smooth = True
  HorzScrollBar.Style = ssHotTrack
  HorzScrollBar.Tracking = True
  VertScrollBar.Smooth = True
  VertScrollBar.Style = ssHotTrack
  VertScrollBar.Tracking = True
  Caption = 'wndViewForm'
  ClientHeight = 404
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object imgView: TPaintBox
    Left = 304
    Top = 128
    Width = 105
    Height = 105
    OnPaint = imgViewPaint
  end
  object dlgSaveFile: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 32
    Top = 24
  end
  object dlgOpenFile: TOpenDialog
    InitialDir = 
      'D:\'#1044#1086#1082#1091#1084#1077#1085#1090#1099'\'#1056#1072#1073#1086#1090#1072'\'#1053#1058#1062' '#1050#1040#1052#1040#1047#1072'\'#1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1084#1085#1086#1075#1086#1086#1089#1085#1099#1093' '#1075#1088#1072#1092#1080#1082#1086#1074'\ma' +
      'pper\samples'
    Left = 32
    Top = 88
  end
  object dlgPrinter: TPrintDialog
    Left = 32
    Top = 152
  end
end
