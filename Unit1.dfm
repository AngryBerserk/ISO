object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 763
  ClientWidth = 934
  Color = clBtnFace
  TransparentColorValue = clDefault
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 193
    Top = 0
    Width = 2
    Height = 763
    ExplicitLeft = 150
    ExplicitHeight = 622
  end
  object Panel2: TPanel
    Left = 195
    Top = 0
    Width = 739
    Height = 763
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 536
    ExplicitHeight = 622
    DesignSize = (
      739
      763)
    object Label3: TLabel
      Left = 9
      Top = 8
      Width = 209
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Z'
      ExplicitWidth = 6
    end
    object Label1: TLabel
      Left = 725
      Top = 31
      Width = 6
      Height = 154
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Y'
      ExplicitLeft = 522
      ExplicitHeight = 13
    end
    object Label2: TLabel
      Left = 9
      Top = 742
      Width = 209
      Height = 13
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'X'
      ExplicitTop = 601
      ExplicitWidth = 6
    end
    object PaintBox1: TPaintBox
      Left = 6
      Top = 30
      Width = 702
      Height = 702
      Anchors = [akLeft, akTop, akRight, akBottom]
      OnMouseDown = PaintBox1MouseDown
      OnMouseLeave = PaintBox1MouseLeave
      OnMouseMove = PaintBox1MouseMove
    end
    object Scroll_l: TScrollBar
      Left = 24
      Top = 8
      Width = 707
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Max = 10
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 0
      OnChange = Scroll_lChange
      ExplicitWidth = 504
    end
    object Scroll_h: TScrollBar
      Left = 714
      Top = 47
      Width = 17
      Height = 708
      Anchors = [akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      Kind = sbVertical
      Max = 10
      Min = 1
      PageSize = 0
      ParentBiDiMode = False
      Position = 1
      TabOrder = 1
      OnChange = Scroll_lChange
      ExplicitLeft = 511
      ExplicitHeight = 567
    end
    object Scroll_w: TScrollBar
      Left = 24
      Top = 738
      Width = 684
      Height = 17
      Anchors = [akLeft, akRight, akBottom]
      Max = 10
      Min = 1
      PageSize = 0
      Position = 10
      TabOrder = 2
      OnChange = Scroll_lChange
      ExplicitTop = 597
      ExplicitWidth = 481
    end
    object Edit1: TEdit
      Left = 4
      Top = 686
      Width = 83
      Height = 21
      TabOrder = 3
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 88
      Top = 686
      Width = 83
      Height = 21
      TabOrder = 4
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 6
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Edit3: TEdit
      Left = 170
      Top = 686
      Width = 83
      Height = 21
      TabOrder = 6
      Text = 'Edit1'
    end
  end
  object TileList: TListBox
    Left = 0
    Top = 0
    Width = 193
    Height = 763
    Style = lbOwnerDrawFixed
    Align = alLeft
    ItemHeight = 45
    TabOrder = 1
    OnDrawItem = TileListDrawItem
    ExplicitHeight = 622
  end
  object Memo1: TMemo
    Left = 2
    Top = 636
    Width = 185
    Height = 102
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 613
    Width = 97
    Height = 17
    Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100
    TabOrder = 3
    OnClick = Scroll_lChange
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 56
    Top = 488
  end
  object SaveDialog1: TSaveDialog
    Left = 120
    Top = 488
  end
  object OpenDialog1: TOpenDialog
    Left = 88
    Top = 488
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 488
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = N3Click
      end
    end
  end
end
