unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  scControls, scStyleManager, System.ImageList, Vcl.ImgList, MmSystem, Registry;

type
  TForm1 = class(TForm)
    btnSeven: TButton;
    btnEight: TButton;
    btnNine: TButton;
    btnZero: TButton;
    btnDecimal: TButton;
    btnBackSpace: TButton;
    btnDeposit: TButton;
    btnCheck: TButton;
    btnSix: TButton;
    btnFive: TButton;
    btnFour: TButton;
    btnThree: TButton;
    btnTwo: TButton;
    btnOne: TButton;
    lblDisplay: TLabel;
    Label3: TLabel;
    lblBalance: TLabel;
    btnClearEntry: TButton;
    btnQuit: TButton;
    lbHistory: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure AppendDecimal;
    procedure AppendDigit(which: Integer);
    procedure RemoveLastDigit;
    procedure ClearDisplay;
    procedure AddToHistory(sign: String; value: Int64);

    procedure btnZeroClick(Sender: TObject);
    procedure btnOneClick(Sender: TObject);
    procedure btnTwoClick(Sender: TObject);
    procedure btnThreeClick(Sender: TObject);
    procedure btnFourClick(Sender: TObject);
    procedure btnFiveClick(Sender: TObject);
    procedure btnSixClick(Sender: TObject);
    procedure btnSevenClick(Sender: TObject);
    procedure btnEightClick(Sender: TObject);
    procedure btnNineClick(Sender: TObject);
    procedure btnDecimalClick(Sender: TObject);
    procedure btnBackSpaceClick(Sender: TObject);

    function CentsToDollars(pennies: Int64): String; // for balance
    procedure SaveBalance(const amount: Int64);
    function RecallBalance: Int64;
    procedure ProcessDeposit;
    procedure ProcessCheck;
    // procedure btnBalanceClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnClearEntryClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  const
  registryId: String = 'EagleAglow';

var
  Form1: TForm1;
  centsBalance: Int64;
  centsDisplay: Int64;
  textBalance: String;
  textDisplay: String;
  balance: Int64;
  // cents, stored in registry

implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
  centsBalance := RecallBalance;
  textBalance := CentsToDollars(centsBalance);
  lblBalance.caption := textBalance + ' ';
  textDisplay := '0';
  centsDisplay := 0;
  lblDisplay.caption := textDisplay + ' ';
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
// note that Form has KeyPreview enabled
begin
  case Key of
      '.':   AppendDecimal;
      '0':   AppendDigit(0);
      '1':   AppendDigit(1);
      '2':   AppendDigit(2);
      '3':   AppendDigit(3);
      '4':   AppendDigit(4);
      '5':   AppendDigit(5);
      '6':   AppendDigit(6);
      '7':   AppendDigit(7);
      '8':   AppendDigit(8);
      '9':   AppendDigit(9);
      Char(8):   RemoveLastDigit;
      '+':         if pos('.',textDisplay) > 0 then ProcessDeposit;
      '-':         if pos('.',textDisplay) > 0 then ProcessCheck;
      'd':         if pos('.',textDisplay) > 0 then ProcessDeposit;
      'c':         if pos('.',textDisplay) > 0 then ProcessCheck;

  end;
end;

procedure TForm1.AddToHistory(sign: String; value: Int64);
// sign is 'B' for balance
var
  temp: String;
begin
  if lbHistory.Count = 0 then // show starting balance in history
  begin
    temp := StringOfChar(' ', 14 - textBalance.Length) + textBalance;
    lbHistory.AddItem(temp, nil);
  end;
  if sign = 'B' then // balance
  begin
    temp := CentsToDollars(value);
    temp := StringOfChar(' ', 14 - temp.Length) + temp;
    lbHistory.AddItem(temp, nil);
  end
  else
  begin
    temp := sign + CentsToDollars(value);
    temp := StringOfChar(' ', 14 - temp.Length) + temp;
    lbHistory.AddItem(temp, nil);
  end;
  // limit visible list
  if lbHistory.Count > 11 then // remove top two lines
  begin
    lbHistory.Selected[0] := true;
    lbHistory.DeleteSelected;
    lbHistory.Selected[0] := true;
    lbHistory.DeleteSelected;
    lbHistory.Refresh;
  end;
end;

function TForm1.CentsToDollars(pennies: Int64): String; // for balance
var
  temp: String;
  value: Int64;
  positive: Boolean;
begin
  Result := 'ERROR'; // default return
  try
    begin
      positive := (pennies >= 0);
      value := abs(pennies);
      // convert to dallars
      if value < 10 then
      begin
        temp := '0.0' + inttostr(value);
      end
      else
      begin
        if value < 100 then
        begin
          temp := '0.' + inttostr(value);
        end
        else
        begin
          temp := inttostr(value);
          insert('.', temp, Length(temp) - 1);
        end;
      end;

      if positive then
      begin
        Result := temp;
      end
      else
      begin
        Result := '-' + temp;
      end;
    end;
  finally

  end;

end;

function TForm1.RecallBalance: Int64;
var
  reg: TRegistry;
begin
  Result := 0;
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    // CreateKey does nothing if already present
    reg.CreateKey('\Software\' + registryId + '\CheckBook');
    if reg.OpenKey('\Software\' + registryId + '\CheckBook', true) then
    begin
      if reg.ValueExists('Balance') then
      begin
        Result := reg.ReadInt64('Balance');
        reg.CloseKey;
      end
      else // first time use, set zero
      begin
        reg.WriteInt64('Balance', 0);
        reg.CloseKey;
        Result := 0;
      end;
    end;
  finally
    reg.Free;
  end;
end;

procedure TForm1.SaveBalance(const amount: Int64);
begin
  var
    reg: TRegistry;
  begin
    reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_CURRENT_USER;
      if reg.OpenKey('\Software\' + registryId + '\CheckBook', true) then
      begin
        reg.WriteInt64('Balance', amount);
        reg.CloseKey;
      end;
    finally
      reg.Free;
    end;
  end;
end;

procedure TForm1.AppendDecimal;
begin

  // https://stackoverflow.com/questions/10576312/use-wave-file-from-project/47960211#47960211
  PlaySound('Click', 0, SND_RESOURCE or SND_ASYNC);
  // only set a decimal once
  if pos('.', textDisplay) = 0 then
  begin
    // multiply current value by 100
    centsDisplay := centsDisplay * 100;
    textDisplay := textDisplay + '.';
    lblDisplay.caption := textDisplay + ' ';

    // enable check / deposit buttons
    btnCheck.Enabled := true;
    btnDeposit.Enabled := true;
  end;
end;

procedure TForm1.AppendDigit(which: Integer);
begin
  // https://stackoverflow.com/questions/10576312/use-wave-file-from-project/47960211#47960211
  PlaySound('Click', 0, SND_RESOURCE or SND_ASYNC);

  if textDisplay = '0' then
  begin
    centsDisplay := which;
    textDisplay := inttostr(which);
    lblDisplay.caption := textDisplay + ' ';
  end
  else
  begin
    if pos('.', textDisplay) = 0 then
    begin
      centsDisplay := (10 * centsDisplay) + which;
      textDisplay := textDisplay + inttostr(which);
      lblDisplay.caption := textDisplay + ' ';
    end
    else
    begin
      if pos('.', textDisplay) = textDisplay.Length then
      begin
        centsDisplay := centsDisplay + 10 * which;
        textDisplay := textDisplay + inttostr(which);
        lblDisplay.caption := textDisplay + ' ';
      end
      else
      begin
        if pos('.', textDisplay) = textDisplay.Length - 1 then
        begin
          centsDisplay := centsDisplay + which;
          textDisplay := textDisplay + inttostr(which);
          lblDisplay.caption := textDisplay + ' ';
        end
        else
        begin
          // already have two decimal places, do nothing
        end;
      end;
    end;

  end;

end;

procedure TForm1.RemoveLastDigit;
begin
  // https://stackoverflow.com/questions/10576312/use-wave-file-from-project/47960211#47960211
  PlaySound('Click', 0, SND_RESOURCE or SND_ASYNC);

  if textDisplay = '0' then
  begin
    // do nothing
  end
  else
  begin
    if pos('.', textDisplay) = 0 then
    begin
      if textDisplay.Length = 1 then // replace with zero
      begin
        centsDisplay := 0;
        textDisplay := '0';
        lblDisplay.caption := textDisplay + ' ';
      end
      else // remove a digit
      begin
        centsDisplay := centsDisplay div 10;
        SetLength(textDisplay, textDisplay.Length - 1);
        lblDisplay.caption := textDisplay + ' ';
      end;
    end
    else // there is a decimal point
    begin
      if pos('.', textDisplay) = textDisplay.Length then
      begin
        centsDisplay := centsDisplay div 100;
        SetLength(textDisplay, textDisplay.Length - 1);
        // remove decimal character
        lblDisplay.caption := textDisplay + ' ';
        // disable check / deposit buttons
        btnCheck.Enabled := false;
        btnDeposit.Enabled := false;
      end
      else
      begin
        if pos('.', textDisplay) = textDisplay.Length - 1 then
        begin
          centsDisplay := 100 * (centsDisplay div 100);
          SetLength(textDisplay, textDisplay.Length - 1);
          lblDisplay.caption := textDisplay + ' ';
        end
        else // have two decimal places
        begin
          centsDisplay := 10 * (centsDisplay div 10);
          SetLength(textDisplay, textDisplay.Length - 1);
          lblDisplay.caption := textDisplay + ' ';
        end;
      end;
    end;
  end;
end;

procedure TForm1.ClearDisplay;
begin
  // https://stackoverflow.com/questions/10576312/use-wave-file-from-project/47960211#47960211
  PlaySound('Click', 0, SND_RESOURCE or SND_ASYNC);
  centsDisplay := 0;
  textDisplay := '0';
  lblDisplay.caption := textDisplay + ' ';
  lbHistory.Clear;

  // disable buttons - enabled later if display has a decimal
  btnCheck.Enabled := false;
  btnDeposit.Enabled := false;
end;

procedure TForm1.ProcessCheck;
begin
   AddToHistory('-', centsDisplay);
  centsBalance := centsBalance - centsDisplay;
  SaveBalance(centsBalance);

  textBalance := CentsToDollars(centsBalance);
  AddToHistory('B', centsBalance); // show balance in history

  lblBalance.caption := textBalance + ' ';
  centsDisplay := 0;
  textDisplay := '0';
  lblDisplay.caption := textDisplay + ' ';

  // disable buttons - enabled later if display has a decimal

  btnCheck.Enabled := false;
  btnDeposit.Enabled := false;
end;

procedure TForm1.btnCheckClick(Sender: TObject);
begin
  ProcessCheck;
end;

procedure TForm1.btnClearEntryClick(Sender: TObject);
begin
  ClearDisplay;

  // disable buttons - enabled later if display has a decimal

  btnCheck.Enabled := false;
  btnDeposit.Enabled := false;

end;

procedure TForm1.btnDecimalClick(Sender: TObject);
begin
  AppendDecimal;
end;


procedure TForm1.ProcessDeposit;
   begin
       AddToHistory('+', centsDisplay);
  centsBalance := centsBalance + centsDisplay;
  SaveBalance(centsBalance);

  textBalance := CentsToDollars(centsBalance);
  AddToHistory('B', centsBalance); // show balance in history

  lblBalance.caption := textBalance + ' ';
  centsDisplay := 0;
  textDisplay := '0';
  lblDisplay.caption := textDisplay + ' ';
  // disable buttons - enabled later if display has a decimal

  btnCheck.Enabled := false;
  btnDeposit.Enabled := false;
   end;

procedure TForm1.btnDepositClick(Sender: TObject);
begin
   ProcessDeposit;

end;

procedure TForm1.btnZeroClick(Sender: TObject);
begin
  AppendDigit(0);
end;

procedure TForm1.btnOneClick(Sender: TObject);
begin
  AppendDigit(1);
end;

procedure TForm1.btnQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.btnTwoClick(Sender: TObject);
begin
  AppendDigit(2);
end;

procedure TForm1.btnThreeClick(Sender: TObject);
begin
  AppendDigit(3);
end;

procedure TForm1.btnFourClick(Sender: TObject);
begin
  AppendDigit(4);
end;

procedure TForm1.btnFiveClick(Sender: TObject);
begin
  AppendDigit(5);
end;

procedure TForm1.btnSixClick(Sender: TObject);
begin
  AppendDigit(6);
end;

procedure TForm1.btnSevenClick(Sender: TObject);
begin
  AppendDigit(7);
end;

procedure TForm1.btnEightClick(Sender: TObject);
begin
  AppendDigit(8);
end;

procedure TForm1.btnNineClick(Sender: TObject);
begin
  AppendDigit(9);
end;

procedure TForm1.btnBackSpaceClick(Sender: TObject);
begin
  RemoveLastDigit;
end;

end.
