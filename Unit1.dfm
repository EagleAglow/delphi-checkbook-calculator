object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Checkbook Calculator'
  ClientHeight = 816
  ClientWidth = 700
  Color = clTomato
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnActivate = FormActivate
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object lblBalance: TLabel
    Left = 16
    Top = 48
    Width = 377
    Height = 81
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0 '
    Color = clPalegreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object lblDisplay: TLabel
    Left = 16
    Top = 183
    Width = 377
    Height = 82
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0 '
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object Label3: TLabel
    Left = 16
    Top = 16
    Width = 97
    Height = 33
    AutoSize = False
    Caption = 'Balance'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 151
    Width = 97
    Height = 33
    AutoSize = False
    Caption = 'Entry'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 440
    Top = 16
    Width = 97
    Height = 33
    AutoSize = False
    Caption = 'History'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
  end
  object btnSeven: TButton
    Left = 16
    Top = 312
    Width = 105
    Height = 97
    Caption = '7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnSevenClick
  end
  object btnEight: TButton
    Left = 152
    Top = 312
    Width = 105
    Height = 97
    Caption = '8'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnEightClick
  end
  object btnNine: TButton
    Left = 288
    Top = 312
    Width = 105
    Height = 97
    Caption = '9'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnNineClick
  end
  object btnZero: TButton
    Left = 16
    Top = 696
    Width = 105
    Height = 97
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = btnZeroClick
  end
  object btnDecimal: TButton
    Left = 152
    Top = 696
    Width = 105
    Height = 97
    Caption = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = btnDecimalClick
  end
  object btnBackSpace: TButton
    Left = 288
    Top = 696
    Width = 105
    Height = 97
    Caption = #213
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    WordWrap = True
    OnClick = btnBackSpaceClick
  end
  object btnDeposit: TButton
    Left = 440
    Top = 440
    Width = 241
    Height = 97
    Caption = 'Deposit'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    WordWrap = True
    OnClick = btnDepositClick
  end
  object btnCheck: TButton
    Left = 440
    Top = 568
    Width = 241
    Height = 97
    Caption = 'Check'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnClick = btnCheckClick
  end
  object btnSix: TButton
    Left = 288
    Top = 440
    Width = 105
    Height = 97
    Caption = '6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnSixClick
  end
  object btnFive: TButton
    Left = 152
    Top = 440
    Width = 105
    Height = 97
    Caption = '5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnFiveClick
  end
  object btnFour: TButton
    Left = 16
    Top = 440
    Width = 105
    Height = 97
    Caption = '4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnFourClick
  end
  object btnThree: TButton
    Left = 288
    Top = 568
    Width = 105
    Height = 97
    Caption = '3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btnThreeClick
  end
  object btnTwo: TButton
    Left = 152
    Top = 568
    Width = 105
    Height = 97
    Caption = '2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnTwoClick
  end
  object btnOne: TButton
    Left = 16
    Top = 568
    Width = 105
    Height = 97
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btnOneClick
  end
  object btnClearEntry: TButton
    Left = 440
    Top = 700
    Width = 105
    Height = 97
    Caption = 'Clear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnClearEntryClick
  end
  object btnQuit: TButton
    Left = 576
    Top = 700
    Width = 105
    Height = 97
    Caption = 'Quit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    OnClick = btnQuitClick
  end
  object lbHistory: TListBox
    Left = 440
    Top = 48
    Width = 241
    Height = 361
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    ItemHeight = 31
    ParentFont = False
    TabOrder = 16
  end
end
