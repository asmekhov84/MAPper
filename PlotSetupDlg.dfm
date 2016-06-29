object dlgPlotSetup: TdlgPlotSetup
  Left = 0
  Top = 0
  AlphaBlend = True
  Caption = #1044#1080#1072#1083#1086#1075' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080' '#1095#1077#1088#1090#1077#1078#1072
  ClientHeight = 531
  ClientWidth = 984
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 970
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
  object pctPageControl: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 978
    Height = 478
    ActivePage = tabGraphs
    Align = alClient
    MultiLine = True
    TabOrder = 0
    ExplicitWidth = 954
    ExplicitHeight = 417
    object tabSheet: TTabSheet
      Caption = #1051#1080#1089#1090
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grpSheetSize: TGroupBox
        Left = 0
        Top = 3
        Width = 265
        Height = 54
        Caption = #1056#1072#1079#1084#1077#1088' '#1083#1080#1089#1090#1072':'
        TabOrder = 0
        object Label11: TLabel
          Left = 106
          Top = 22
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object Label12: TLabel
          Left = 227
          Top = 22
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object edtSheetWidth: TLabeledEdit
          Left = 59
          Top = 20
          Width = 41
          Height = 21
          EditLabel.Width = 44
          EditLabel.Height = 13
          EditLabel.Caption = #1064#1080#1088#1080#1085#1072':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtSheetWidthExit
        end
        object edtSheetHeight: TLabeledEdit
          Left = 180
          Top = 20
          Width = 41
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = #1042#1099#1089#1086#1090#1072':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 1
          OnExit = edtSheetHeightExit
        end
      end
      object grpMargins: TGroupBox
        Left = 3
        Top = 93
        Width = 494
        Height = 52
        Caption = #1054#1090#1089#1090#1091#1087#1099':'
        TabOrder = 2
        object Label13: TLabel
          Left = 103
          Top = 22
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object Label14: TLabel
          Left = 224
          Top = 22
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object Label15: TLabel
          Left = 343
          Top = 22
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object Label16: TLabel
          Left = 464
          Top = 22
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object edtBorderLeft: TLabeledEdit
          Left = 56
          Top = 20
          Width = 41
          Height = 21
          EditLabel.Width = 35
          EditLabel.Height = 13
          EditLabel.Caption = #1057#1083#1077#1074#1072':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtBorderLeftExit
        end
        object edtBorderRight: TLabeledEdit
          Left = 177
          Top = 20
          Width = 41
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = #1057#1087#1088#1072#1074#1072':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 1
          OnExit = edtBorderRightExit
        end
        object edtBorderTop: TLabeledEdit
          Left = 296
          Top = 20
          Width = 41
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = #1057#1074#1077#1088#1093#1091':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 2
          OnExit = edtBorderTopExit
        end
        object edtBorderBottom: TLabeledEdit
          Left = 417
          Top = 20
          Width = 41
          Height = 21
          EditLabel.Width = 34
          EditLabel.Height = 13
          EditLabel.Caption = #1057#1085#1080#1079#1091':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 3
          OnExit = edtBorderBottomExit
        end
      end
      object grpTable: TGroupBox
        Left = 3
        Top = 174
        Width = 494
        Height = 48
        Caption = #1064#1090#1072#1084#1087':'
        TabOrder = 4
        object edtTableSheetNum: TLabeledEdit
          Left = 80
          Top = 16
          Width = 41
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = #1053#1086#1084#1077#1088' '#1083#1080#1089#1090#1072':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtTableSheetNumExit
        end
        object edtTableDocNum: TLabeledEdit
          Left = 233
          Top = 16
          Width = 225
          Height = 21
          EditLabel.Width = 93
          EditLabel.Height = 13
          EditLabel.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
          LabelPosition = lpLeft
          TabOrder = 1
          OnExit = edtTableDocNumExit
        end
      end
      object chkBorderVisible: TCheckBox
        Left = 3
        Top = 70
        Width = 145
        Height = 17
        Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1075#1088#1072#1085#1080#1094#1099
        TabOrder = 1
        OnClick = chkBorderVisibleClick
      end
      object chkTableVisible: TCheckBox
        Left = 3
        Top = 151
        Width = 145
        Height = 17
        Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1096#1090#1072#1084#1087
        TabOrder = 3
        OnClick = chkTableVisibleClick
      end
      object grpPlotName: TGroupBox
        Left = 3
        Top = 236
        Width = 494
        Height = 109
        Caption = #1055#1086#1076#1087#1080#1089#1100' '#1088#1080#1089#1091#1085#1082#1072':'
        TabOrder = 5
        object Label17: TLabel
          Left = 175
          Top = 75
          Width = 25
          Height = 18
          AutoSize = False
          Caption = #1084#1084
        end
        object edtPlotNameText: TLabeledEdit
          Left = 12
          Top = 37
          Width = 446
          Height = 21
          EditLabel.Width = 78
          EditLabel.Height = 13
          EditLabel.Caption = #1058#1077#1082#1089#1090' '#1087#1086#1076#1087#1080#1089#1080':'
          TabOrder = 0
          OnExit = edtPlotNameTextExit
        end
        object edtPlotNameVPos: TLabeledEdit
          Left = 129
          Top = 72
          Width = 40
          Height = 21
          Hint = #1054#1090#1089#1090#1091#1087' '#1090#1077#1082#1089#1090#1072' '#1086#1090' '#1085#1080#1078#1085#1077#1081' '#1075#1088#1072#1085#1080#1094#1099' '#1083#1080#1089#1090#1072
          EditLabel.Width = 116
          EditLabel.Height = 13
          EditLabel.Caption = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1099#1081' '#1086#1090#1089#1090#1091#1087':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 1
          OnExit = edtPlotNameVPosExit
        end
      end
      object grpLegend: TGroupBox
        Left = 515
        Top = 93
        Width = 374
        Height = 52
        Caption = #1051#1077#1075#1077#1085#1076#1072
        TabOrder = 6
        object Label25: TLabel
          Left = 146
          Top = 23
          Width = 12
          Height = 13
          Caption = #1084#1084
        end
        object Label26: TLabel
          Left = 322
          Top = 23
          Width = 12
          Height = 13
          Caption = #1084#1084
        end
        object edtLegendLeft: TLabeledEdit
          Left = 80
          Top = 20
          Width = 60
          Height = 21
          EditLabel.Width = 70
          EditLabel.Height = 13
          EditLabel.Caption = #1043#1086#1088'. '#1087#1086#1079#1080#1094#1080#1103':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 0
          OnExit = edtLegendLeftExit
        end
        object edtLegendBottom: TLabeledEdit
          Left = 256
          Top = 20
          Width = 60
          Height = 21
          EditLabel.Width = 76
          EditLabel.Height = 13
          EditLabel.Caption = #1042#1077#1088#1090'. '#1087#1086#1079#1080#1094#1080#1103':'
          LabelPosition = lpLeft
          NumbersOnly = True
          TabOrder = 1
          OnExit = edtLegendBottomExit
        end
      end
      object chkLegendVisible: TCheckBox
        Left = 515
        Top = 67
        Width = 145
        Height = 20
        Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1083#1077#1075#1077#1085#1076#1091
        TabOrder = 7
        OnClick = chkLegendVisibleClick
      end
    end
    object tabFigure: TTabSheet
      Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 946
      ExplicitHeight = 389
      object grpYAxisList: TGroupBox
        AlignWithMargins = True
        Left = 374
        Top = 3
        Width = 593
        Height = 444
        Align = alClient
        Caption = #1057#1087#1080#1089#1086#1082' '#1086#1089#1077#1081':'
        Color = clBtnFace
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitWidth = 569
        ExplicitHeight = 383
        object sgrYAxisList: TStringGrid
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 583
          Height = 374
          TabStop = False
          Align = alClient
          Color = clWhite
          ColCount = 9
          DefaultColWidth = 55
          DefaultRowHeight = 21
          FixedCols = 0
          RowCount = 3
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
          TabOrder = 0
          OnClick = sgrYAxisListClick
          OnDrawCell = sgrYAxisListDrawCell
          ExplicitWidth = 559
          ExplicitHeight = 313
        end
        object pnlYAxisListButtons: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 398
          Width = 583
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitTop = 337
          ExplicitWidth = 559
          DesignSize = (
            583
            41)
          object lblYAxisCount: TLabel
            Left = 0
            Top = 12
            Width = 118
            Height = 21
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1089#1077#1081':'
          end
          object btnAddYAxis: TButton
            Left = 420
            Top = 8
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100
            TabOrder = 0
            OnClick = btnAddYAxisClick
            ExplicitLeft = 396
          end
          object btnDelYAxis: TButton
            Left = 508
            Top = 8
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #1059#1076#1072#1083#1080#1090#1100
            TabOrder = 1
            OnClick = btnDelYAxisClick
            ExplicitLeft = 484
          end
        end
      end
      object pnlProperties: TPanel
        Left = 0
        Top = 0
        Width = 371
        Height = 450
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 1
        ExplicitHeight = 389
        object grpGrid: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = -1
          Width = 358
          Height = 134
          Caption = #1057#1077#1090#1082#1072':'
          TabOrder = 0
          object Label1: TLabel
            Left = 21
            Top = 102
            Width = 63
            Height = 13
            Caption = #1062#1074#1077#1090' '#1083#1080#1085#1080#1080':'
          end
          object lblMM: TLabel
            Left = 153
            Top = 19
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label2: TLabel
            Left = 336
            Top = 19
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label3: TLabel
            Left = 153
            Top = 75
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label4: TLabel
            Left = 336
            Top = 75
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label5: TLabel
            Left = 336
            Top = 102
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label6: TLabel
            Left = 184
            Top = 102
            Width = 82
            Height = 13
            Caption = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1080':'
          end
          object edtGridWidth: TLabeledEdit
            Left = 88
            Top = 16
            Width = 60
            Height = 21
            EditLabel.Width = 44
            EditLabel.Height = 13
            EditLabel.Caption = #1064#1080#1088#1080#1085#1072':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 0
            OnExit = edtGridWidthExit
          end
          object edtGridHeight: TLabeledEdit
            Left = 270
            Top = 16
            Width = 60
            Height = 21
            EditLabel.Width = 41
            EditLabel.Height = 13
            EditLabel.Caption = #1042#1099#1089#1086#1090#1072':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 1
            OnExit = edtGridHeightExit
          end
          object edtGridXUnits: TLabeledEdit
            Left = 88
            Top = 44
            Width = 60
            Height = 21
            EditLabel.Width = 72
            EditLabel.Height = 13
            EditLabel.Caption = #1044#1077#1083#1077#1085#1080#1081' '#1087#1086' X:'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 2
            OnExit = edtGridXUnitsExit
          end
          object edtGridYUnits: TLabeledEdit
            Left = 270
            Top = 44
            Width = 60
            Height = 21
            EditLabel.Width = 72
            EditLabel.Height = 13
            EditLabel.Caption = #1044#1077#1083#1077#1085#1080#1081' '#1087#1086' Y:'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 3
            OnExit = edtGridYUnitsExit
          end
          object edtGridBottom: TLabeledEdit
            Left = 270
            Top = 72
            Width = 60
            Height = 21
            EditLabel.Width = 76
            EditLabel.Height = 13
            EditLabel.Caption = #1042#1077#1088#1090'. '#1087#1086#1079#1080#1094#1080#1103':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 5
            OnExit = edtGridBottomExit
          end
          object edtGridLeft: TLabeledEdit
            Left = 88
            Top = 72
            Width = 60
            Height = 21
            EditLabel.Width = 70
            EditLabel.Height = 13
            EditLabel.Caption = #1043#1086#1088'. '#1087#1086#1079#1080#1094#1080#1103':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 4
            OnExit = edtGridLeftExit
          end
          object pnlGridLineColor: TPanel
            Left = 88
            Top = 101
            Width = 60
            Height = 21
            ParentBackground = False
            TabOrder = 6
            OnClick = pnlGridLineColorClick
          end
          object cmbGridLineWidth: TComboBox
            Left = 270
            Top = 99
            Width = 60
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 7
            Text = '0.25'
            OnChange = cmbGridLineWidthChange
            Items.Strings = (
              '0.25'
              '0.5'
              '0.75'
              '1'
              '1.25'
              '1.5'
              '1.75'
              '2')
          end
        end
        object grpXAxis: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 139
          Width = 358
          Height = 147
          Caption = #1054#1089#1100' '#1072#1073#1089#1094#1080#1089#1089':'
          TabOrder = 1
          object Label7: TLabel
            Left = 21
            Top = 104
            Width = 63
            Height = 13
            Caption = #1062#1074#1077#1090' '#1083#1080#1085#1080#1080':'
          end
          object Label8: TLabel
            Left = 184
            Top = 104
            Width = 82
            Height = 13
            Caption = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1080':'
          end
          object Label9: TLabel
            Left = 336
            Top = 104
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label10: TLabel
            Left = 156
            Top = 77
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object edtXAxisMin: TLabeledEdit
            Left = 88
            Top = 44
            Width = 60
            Height = 21
            EditLabel.Width = 48
            EditLabel.Height = 13
            EditLabel.Caption = #1052#1080#1085#1080#1084#1091#1084':'
            LabelPosition = lpLeft
            TabOrder = 1
            OnExit = edtXAxisMinExit
          end
          object edtXAxisMax: TLabeledEdit
            Left = 270
            Top = 44
            Width = 60
            Height = 21
            EditLabel.Width = 53
            EditLabel.Height = 13
            EditLabel.Caption = #1052#1072#1082#1089#1080#1084#1091#1084':'
            LabelPosition = lpLeft
            TabOrder = 2
            OnExit = edtXAxisMaxExit
          end
          object edtXAxisName: TLabeledEdit
            Left = 88
            Top = 17
            Width = 204
            Height = 21
            EditLabel.Width = 52
            EditLabel.Height = 13
            EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
            LabelPosition = lpLeft
            TabOrder = 0
            OnExit = edtXAxisNameExit
          end
          object edtXAxisGap: TLabeledEdit
            Left = 88
            Top = 74
            Width = 60
            Height = 21
            EditLabel.Width = 41
            EditLabel.Height = 13
            EditLabel.Caption = #1054#1090#1089#1090#1091#1087':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 3
            OnExit = edtXAxisGapExit
          end
          object pnlXAxisLineColor: TPanel
            Left = 88
            Top = 101
            Width = 60
            Height = 21
            ParentBackground = False
            TabOrder = 4
            OnClick = pnlXAxisLineColorClick
          end
          object cmbXAxisLineWidth: TComboBox
            Left = 270
            Top = 101
            Width = 60
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 5
            Text = '0.25'
            OnChange = cmbXAxisLineWidthChange
            Items.Strings = (
              '0.25'
              '0.5'
              '0.75'
              '1'
              '1.25'
              '1.5'
              '1.75'
              '2')
          end
          object btnInsertCharToXAxisName: TButton
            Left = 298
            Top = 17
            Width = 32
            Height = 21
            Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1080#1084#1074#1086#1083
            Caption = #1057
            TabOrder = 6
            OnClick = btnInsertCharToXAxisNameClick
          end
        end
        object grpYAxis: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 292
          Width = 358
          Height = 157
          Caption = #1054#1089#1100' '#1086#1088#1076#1080#1085#1072#1090':'
          TabOrder = 2
          object Label18: TLabel
            Left = 21
            Top = 131
            Width = 63
            Height = 13
            Caption = #1062#1074#1077#1090' '#1083#1080#1085#1080#1080':'
          end
          object Label19: TLabel
            Left = 184
            Top = 131
            Width = 82
            Height = 13
            Caption = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1080':'
          end
          object Label20: TLabel
            Left = 336
            Top = 131
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label21: TLabel
            Left = 156
            Top = 104
            Width = 12
            Height = 13
            Caption = #1084#1084
          end
          object Label23: TLabel
            Left = 205
            Top = 77
            Width = 61
            Height = 13
            Caption = #1055#1086#1083#1086#1078#1077#1085#1080#1077':'
          end
          object Label27: TLabel
            Left = 32
            Top = 20
            Width = 52
            Height = 13
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
          end
          object edtYAxisMin: TLabeledEdit
            Left = 88
            Top = 44
            Width = 60
            Height = 21
            EditLabel.Width = 48
            EditLabel.Height = 13
            EditLabel.Caption = #1052#1080#1085#1080#1084#1091#1084':'
            LabelPosition = lpLeft
            TabOrder = 0
            OnKeyUp = edtYAxisMinKeyUp
          end
          object edtYAxisMax: TLabeledEdit
            Left = 270
            Top = 44
            Width = 60
            Height = 21
            EditLabel.Width = 53
            EditLabel.Height = 13
            EditLabel.Caption = #1052#1072#1082#1089#1080#1084#1091#1084':'
            LabelPosition = lpLeft
            TabOrder = 1
            OnKeyUp = edtYAxisMaxKeyUp
          end
          object edtYAxisGap: TLabeledEdit
            Left = 88
            Top = 100
            Width = 60
            Height = 21
            EditLabel.Width = 41
            EditLabel.Height = 13
            EditLabel.Caption = #1054#1090#1089#1090#1091#1087':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 2
            OnKeyUp = edtYAxisGapKeyUp
          end
          object pnlYAxisLineColor: TPanel
            Left = 88
            Top = 127
            Width = 60
            Height = 21
            ParentBackground = False
            TabOrder = 3
            OnClick = pnlYAxisLineColorClick
          end
          object cmbYAxisLineWidth: TComboBox
            Left = 270
            Top = 128
            Width = 60
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 4
            Text = '0.25'
            OnChange = cmbYAxisLineWidthChange
            Items.Strings = (
              '0.25'
              '0.5'
              '0.75'
              '1'
              '1.25'
              '1.5'
              '1.75'
              '2')
          end
          object edtYAxisIndent: TLabeledEdit
            Left = 270
            Top = 101
            Width = 60
            Height = 21
            EditLabel.Width = 56
            EditLabel.Height = 13
            EditLabel.Caption = #1057#1084#1077#1097#1077#1085#1080#1077':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 5
            OnKeyUp = edtYAxisIndentKeyUp
          end
          object edtYAxisUnits: TLabeledEdit
            Left = 88
            Top = 73
            Width = 60
            Height = 21
            EditLabel.Width = 36
            EditLabel.Height = 13
            EditLabel.Caption = #1044#1083#1080#1085#1072':'
            LabelPosition = lpLeft
            NumbersOnly = True
            TabOrder = 6
            OnKeyUp = edtYAxisUnitsKeyUp
          end
          object cmbYAxisSide: TComboBox
            Left = 270
            Top = 74
            Width = 60
            Height = 21
            Style = csDropDownList
            ItemIndex = 1
            TabOrder = 7
            Text = #1087#1088#1072#1074#1072#1103
            OnChange = cmbYAxisSideChange
            Items.Strings = (
              #1083#1077#1074#1072#1103
              #1087#1088#1072#1074#1072#1103)
          end
          object btnInsertCharToYAxisName: TButton
            Left = 298
            Top = 17
            Width = 32
            Height = 21
            Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1080#1084#1074#1086#1083
            Caption = #1057
            TabOrder = 8
            OnClick = btnInsertCharToYAxisNameClick
          end
          object edtYAxisName: TComboBox
            Left = 88
            Top = 17
            Width = 204
            Height = 21
            TabOrder = 9
            Text = 'edtYAxisName'
            OnKeyUp = edtYAxisNameKeyUp
          end
        end
      end
    end
    object tabGraphs: TTabSheet
      Caption = #1043#1088#1072#1092#1080#1082#1080
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 946
      ExplicitHeight = 389
      object lblGraphSeriesIsEmpty: TLabel
        Left = 404
        Top = 203
        Width = 158
        Height = 19
        Caption = #1053#1072#1073#1086#1088' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1087#1091#1089#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object sgrGraphsList: TStringGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 964
        Height = 444
        TabStop = False
        Align = alClient
        ColCount = 8
        Ctl3D = True
        DefaultColWidth = 120
        DefaultRowHeight = 21
        DoubleBuffered = False
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitWidth = 940
        ExplicitHeight = 342
      end
    end
    object tabGroups: TTabSheet
      Caption = #1043#1088#1091#1087#1087#1099
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 262
        Height = 444
        Align = alLeft
        Caption = #1057#1087#1080#1089#1086#1082' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1074' '#1075#1088#1091#1087#1087#1077':'
        TabOrder = 0
        object clbGraphsInGroup: TCheckListBox
          AlignWithMargins = True
          Left = 7
          Top = 18
          Width = 248
          Height = 380
          Margins.Left = 5
          Margins.Right = 5
          OnClickCheck = clbGraphsInGroupClickCheck
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
        object Panel2: TPanel
          Left = 2
          Top = 401
          Width = 258
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnDeselectAllGraphs: TButton
            Left = 178
            Top = 8
            Width = 75
            Height = 25
            Caption = #1053#1080' '#1086#1076#1085#1086#1075#1086
            TabOrder = 0
          end
          object btnSelectAllGraphs: TButton
            Left = 94
            Top = 8
            Width = 75
            Height = 25
            Caption = #1042#1089#1077
            TabOrder = 1
          end
        end
      end
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 271
        Top = 3
        Width = 696
        Height = 444
        Align = alClient
        TabOrder = 1
        object sgrGroupsList: TStringGrid
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 688
          Height = 335
          TabStop = False
          Align = alClient
          ColCount = 7
          Ctl3D = True
          DefaultColWidth = 120
          DefaultRowHeight = 21
          DoubleBuffered = False
          FixedCols = 0
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
          ParentCtl3D = False
          ParentDoubleBuffered = False
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnClick = sgrGroupsListClick
          OnDrawCell = sgrGroupsListDrawCell
        end
        object Panel3: TPanel
          Left = 1
          Top = 342
          Width = 694
          Height = 101
          Align = alBottom
          TabOrder = 1
          DesignSize = (
            694
            101)
          object grpGroupProperties: TGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 574
            Height = 95
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1075#1088#1091#1087#1087#1099
            TabOrder = 0
            object lblMarker: TLabel
              Left = 20
              Top = 61
              Width = 42
              Height = 13
              Caption = #1052#1072#1088#1082#1077#1088':'
            end
            object lblLineColor: TLabel
              Left = 209
              Top = 59
              Width = 63
              Height = 13
              Caption = #1062#1074#1077#1090' '#1083#1080#1085#1080#1080':'
            end
            object lblLineWidth: TLabel
              Left = 364
              Top = 59
              Width = 82
              Height = 13
              Caption = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1080':'
            end
            object Label22: TLabel
              Left = 518
              Top = 57
              Width = 12
              Height = 13
              Caption = #1084#1084
            end
            object edtGroupName: TLabeledEdit
              Left = 174
              Top = 18
              Width = 146
              Height = 21
              EditLabel.Width = 52
              EditLabel.Height = 13
              EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
              LabelPosition = lpLeft
              TabOrder = 0
              OnKeyUp = edtGroupNameKeyUp
            end
            object chkGroupVisible: TCheckBox
              Left = 20
              Top = 18
              Width = 76
              Height = 21
              Alignment = taLeftJustify
              Caption = #1042#1080#1076#1080#1084#1086#1089#1090#1100':'
              TabOrder = 3
              OnClick = chkGroupVisibleClick
            end
            object edtGroupNoteXPos: TLabeledEdit
              Left = 438
              Top = 18
              Width = 60
              Height = 21
              EditLabel.Width = 91
              EditLabel.Height = 13
              EditLabel.Caption = #1055#1086#1079#1080#1094#1080#1103' '#1087#1086#1076#1087#1080#1089#1080':'
              LabelPosition = lpLeft
              TabOrder = 1
              OnKeyUp = edtGroupNoteXPosKeyUp
            end
            object cmbGroupMarker: TComboBox
              Left = 68
              Top = 56
              Width = 118
              Height = 21
              Style = csDropDownList
              TabOrder = 2
              OnChange = cmbGroupMarkerChange
            end
            object pnlGroupLineColor: TPanel
              Left = 278
              Top = 56
              Width = 60
              Height = 21
              ParentBackground = False
              TabOrder = 5
              OnClick = pnlGroupLineColorClick
            end
            object cmbGroupLineWidth: TComboBox
              Left = 452
              Top = 56
              Width = 60
              Height = 21
              Style = csDropDownList
              TabOrder = 4
              OnChange = cmbGroupLineWidthChange
            end
          end
          object btnAddGroup: TButton
            Left = 607
            Top = 11
            Width = 75
            Height = 25
            Anchors = [akTop, akRight]
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100
            TabOrder = 1
            OnClick = btnAddGroupClick
          end
          object btnDeleteGroup: TButton
            Left = 608
            Top = 42
            Width = 75
            Height = 25
            Anchors = [akTop, akRight]
            Caption = #1059#1076#1072#1083#1080#1090#1100
            TabOrder = 2
            OnClick = btnDeleteGroupClick
          end
        end
      end
    end
  end
  object pnlBottom: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 487
    Width = 978
    Height = 41
    Align = alBottom
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 426
    ExplicitWidth = 954
    DesignSize = (
      978
      41)
    object Label24: TLabel
      Left = 4
      Top = 8
      Width = 102
      Height = 13
      Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100' '#1086#1082#1085#1072':'
    end
    object btnClose: TButton
      Left = 896
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = btnCloseClick
      ExplicitLeft = 872
    end
    object trbWindowOpacity: TTrackBar
      Left = 112
      Top = 3
      Width = 353
      Height = 30
      Max = 255
      Min = 100
      Position = 255
      ShowSelRange = False
      TabOrder = 0
      TabStop = False
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = trbWindowOpacityChange
    end
    object btnApply: TButton
      Left = 809
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = btnApplyClick
      ExplicitLeft = 785
    end
  end
  object dlgColor: TColorDialog
    Left = 920
    Top = 40
  end
end
