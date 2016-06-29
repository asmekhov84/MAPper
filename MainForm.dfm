object wndMainForm: TwndMainForm
  Left = 400
  Top = 190
  Caption = 'MAPper - '#1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1084#1085#1086#1075#1086#1086#1089#1085#1099#1093' '#1075#1088#1072#1092#1080#1082#1086#1074
  ClientHeight = 434
  ClientWidth = 799
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmMainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ctbControlBar: TControlBar
    Left = 0
    Top = 0
    Width = 799
    Height = 57
    Align = alTop
    BevelEdges = [beBottom]
    TabOrder = 0
    object pnlScaleView: TPanel
      Left = 11
      Top = 2
      Width = 353
      Height = 48
      Align = alLeft
      Anchors = [akTop, akRight]
      Enabled = False
      TabOrder = 0
      object lblScaleView: TLabel
        Left = 265
        Top = 1
        Width = 87
        Height = 46
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = '100%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 80
        ExplicitHeight = 35
      end
      object trbScaleView: TTrackBar
        Left = 1
        Top = 1
        Width = 264
        Height = 46
        Align = alLeft
        Ctl3D = True
        LineSize = 25
        Max = 200
        Min = 50
        ParentCtl3D = False
        Frequency = 25
        Position = 50
        TabOrder = 0
        TickMarks = tmBoth
        OnChange = trbScaleViewChange
      end
    end
    object Panel1: TPanel
      Left = 377
      Top = 2
      Width = 213
      Height = 48
      TabOrder = 1
      object cmbFreqList: TComboBox
        Left = 22
        Top = 14
        Width = 179
        Height = 21
        TabOrder = 0
        OnChange = cmbFreqListChange
      end
    end
  end
  object sbStatusBar: TStatusBar
    Left = 0
    Top = 410
    Width = 799
    Height = 24
    Panels = <
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1095#1077#1088#1090#1077#1078#1072': <'#1085#1077#1090'>'
        Width = 300
      end
      item
        Text = #1053#1072#1073#1086#1088' '#1075#1088#1072#1092#1080#1082#1086#1074': <'#1085#1077#1090'>'
        Width = 300
      end>
  end
  object mmMainMenu: TMainMenu
    Left = 24
    Top = 72
    object mmFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mmFilePlot: TMenuItem
        Caption = #1063#1077#1088#1090#1077#1078
        object mmFilePlotCreate: TMenuItem
          Caption = #1057#1086#1079#1076#1072#1090#1100
          OnClick = mmFilePlotCreateClick
        end
        object mmFilePlotLoad: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          object mmFilePlotLoadFromFile: TMenuItem
            Caption = #1048#1079' '#1092#1072#1081#1083#1072
            OnClick = mmFilePlotLoadFromFileClick
          end
          object mmFilePlotLoadFromWorkspace: TMenuItem
            Caption = #1048#1079' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
            OnClick = mmFilePlotLoadFromWorkspaceClick
          end
        end
        object mmFilePlotSave: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          Enabled = False
          OnClick = mmFilePlotSaveClick
        end
        object mmFilePlotSaveAs: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
          Enabled = False
          OnClick = mmFilePlotSaveAsClick
        end
      end
      object mmFileGraphs: TMenuItem
        Caption = #1043#1088#1072#1092#1080#1082#1080
        Enabled = False
        object mmFileGraphsLoadFromFile: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
          OnClick = mmFileGraphsLoadFromFileClick
        end
        object mmFileGraphsLoadFromWorkspace: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1072
          OnClick = mmFileGraphsLoadFromWorkspaceClick
        end
      end
      object mmFilePrint: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        Enabled = False
        OnClick = mmFilePrintClick
      end
      object mmFileExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = mmFileExitClick
      end
    end
    object mmSetup: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object mmSetupPlot: TMenuItem
        Caption = #1063#1077#1088#1090#1077#1078
        Enabled = False
        OnClick = mmSetupPlotClick
      end
      object mmSetupWorkspace: TMenuItem
        Caption = #1056#1072#1073#1086#1095#1077#1077' '#1087#1088#1086#1089#1090#1088#1072#1085#1089#1090#1074#1086
        OnClick = mmSetupWorkspaceClick
      end
    end
    object mmAbout: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = mmAboutClick
    end
  end
end
