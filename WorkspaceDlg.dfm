object wndWorkspaceDlg: TwndWorkspaceDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
  ClientHeight = 344
  ClientWidth = 714
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblDriveName: TLabel
    Left = 8
    Top = 8
    Width = 29
    Height = 13
    Caption = #1044#1080#1089#1082':'
  end
  object btnApply: TButton
    Left = 552
    Top = 312
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 632
    Top = 312
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object lstWorkspace: TListBox
    Left = 400
    Top = 33
    Width = 305
    Height = 259
    ItemHeight = 13
    ParentShowHint = False
    ScrollWidth = 1000
    ShowHint = True
    TabOrder = 2
  end
  object btnAdd: TButton
    Left = 319
    Top = 33
    Width = 75
    Height = 25
    Caption = ' '#1044#1086#1073#1072#1074#1080#1090#1100' >'
    TabOrder = 3
    OnClick = btnAddClick
  end
  object dlbDirectories: TDirectoryListBox
    Left = 8
    Top = 33
    Width = 305
    Height = 259
    TabOrder = 4
  end
  object dcbDrives: TDriveComboBox
    Left = 43
    Top = 8
    Width = 270
    Height = 19
    DirList = dlbDirectories
    TabOrder = 5
  end
  object btnDelete: TButton
    Left = 319
    Top = 73
    Width = 75
    Height = 25
    Caption = '< '#1059#1076#1072#1083#1080#1090#1100
    TabOrder = 6
    OnClick = btnDeleteClick
  end
  object btnClear: TButton
    Left = 319
    Top = 113
    Width = 75
    Height = 25
    Caption = '<< '#1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 7
    OnClick = btnClearClick
  end
end
