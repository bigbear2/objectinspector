unit ObjectInspector;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.ComCtrls, Vcl.StdCtrls,
  System.Types, Vcl.ExtCtrls, TypInfo;

type
  TObjectInspector = class(Tobject)
  private
    FLastitem: TListItem;
    FListview: TListView;
    FTask: TTimer;
    procedure DoSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure DoKeyPress(Sender: TObject; var Key: Char);
    procedure DoTask(Sender: TObject);
    procedure DoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    constructor Create(ListView: Tlistview);
    procedure AddText(Prop: string; Value: string; const Description: string = '');
    procedure AddComboBox(Prop: string; Value: string; List: TStringList);
    procedure AddComboBoxBoolean(Prop: string; Value: string; const Description: string = '');
  end;

implementation

procedure TObjectInspector.DoTask(Sender: TObject);
begin
  FTask.Enabled := False;

  if FLastitem = nil then
    exit;

  TEdit(FLastitem.Data).SetFocus;
  TEdit(FLastitem.Data).SelectAll;
end;

procedure TObjectInspector.DoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  if (Key = 38) and (FLastitem <> nil) then
  begin
    Key := 0;
    if FLastitem.Index > 0 then
    begin
      FLastitem.SubItems[0] := TEdit(FLastitem.Data).Text;
      i := FLastitem.Index;
      FListview.Selected := FListview.Items[i - 1];
    end;
  end;

  if (Key = 40) and (FLastitem <> nil) then
  begin
    Key := 0;
    if FLastitem.Index < (FListview.Items.Count - 1) then
    begin
      FLastitem.SubItems[0] := TEdit(FLastitem.Data).Text;
      i := FLastitem.Index;
      FListview.Selected := FListview.Items[i + 1];
    end;
  end;

end;

procedure TObjectInspector.DoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (FLastitem <> nil) then
  begin
    FLastitem.SubItems[0] := TEdit(FLastitem.Data).Text;
    TEdit(FLastitem.Data).SelectAll;
  end;

  if (Key = #27) and (FLastitem <> nil) then
  begin
    TEdit(FLastitem.Data).Text := FLastitem.SubItems[0];
    TEdit(FLastitem.Data).SelectAll;
  end;

end;

procedure TObjectInspector.DoSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  I: Integer;
  r: TRect;
begin
  //for I := 0 to FListview.Items.Count - 1 do
  if FLastitem <> nil then
    TControl(FLastitem.Data).Visible := False;

  if Item = nil then
    exit;

  r := Item.DisplayRect(drBounds);
  r.Left := r.Left + FListview.columns[0].Width;
  r.Right := r.Left + FListview.columns[1].Width;
  TControl(Item.Data).BoundsRect := r;

  TControl(Item.Data).Visible := True;
  TEdit(Item.Data).Text := Item.SubItems[0];

  FLastitem := Item;

  FTask.Enabled := True;
end;

procedure TObjectInspector.AddText(Prop: string; Value: string; const Description: string = '');
var
  Edit: TEdit;
  Item: TListItem;
  r: TRect;
begin
  Item := FListview.Items.Add;
  Item.Caption := Prop;
  Item.SubItems.Add(Value);
  Item.SubItems.Add(Description);

  r := Item.DisplayRect(drBounds);
  r.Left := r.Left + FListview.columns[0].Width;
  r.Right := r.Left + FListview.columns[1].Width;

  Edit := TEdit.Create(FListview);
  Edit.Parent := FListview;
  Edit.BoundsRect := r;
  Edit.Visible := False;
  Edit.OnKeyPress := DoKeyPress;
  Edit.OnKeyDown := DoKeyDown;
  Edit.Hint := Description;
  Edit.ShowHint := True;
  Item.Data := Edit;

end;

procedure TObjectInspector.AddComboBox(Prop: string; Value: string; List: TStringList);
var
  Combo: TComboBox;
  Item: TListItem;
  r: TRect;
begin
  Item := FListview.Items.Add;
  Item.Caption := Prop;
  Item.SubItems.Add(Value);

  r := Item.DisplayRect(drBounds);
  r.Left := r.Left + FListview.columns[0].Width;
  r.Right := r.Left + FListview.columns[1].Width;

  Combo := TComboBox.Create(FListview);
  Combo.Parent := FListview;
  Combo.BoundsRect := r;
  Combo.Visible := False;
  Combo.Items.Assign(List);
  Combo.OnKeyPress := DoKeyPress;
  Combo.OnKeyDown := DoKeyDown;
  Item.Data := Combo;

end;

procedure TObjectInspector.AddComboBoxBoolean(Prop: string; Value: string; const Description: string = '');
var
  Combo: TComboBox;
  Item: TListItem;
  r: TRect;
begin
  Item := FListview.Items.Add;
  Item.Caption := Prop;
  Item.SubItems.Add(Value);

  r := Item.DisplayRect(drBounds);
  r.Left := r.Left + FListview.columns[0].Width;
  r.Right := r.Left + FListview.columns[1].Width;

  Combo := TComboBox.Create(FListview);
  Combo.Parent := FListview;
  Combo.BoundsRect := r;
  Combo.Visible := False;
  Combo.Items.Add('false');
  Combo.Items.Add('true');
 // Combo.Style := csDropDownList;
  Combo.Text := Value;

  Combo.OnKeyPress := DoKeyPress;
  Combo.OnKeyDown := DoKeyDown;
  Combo.Tag := 0;

  Item.Data := Combo;

end;

constructor TObjectInspector.Create(ListView: Tlistview);
begin
  FLastitem := nil;
  FListview := ListView;

  FTask := TTimer.Create(nil);
  with FTask do
  begin
    Enabled := False;
    Interval := 100;
    OnTimer := DoTask;
  end;

  with FListview do
  begin
    Columns.Add.Width := 100;
    Columns.Add.Width := 200;
    ViewStyle := vsReport;
    GridLines := True;
    ShowColumnHeaders := False;
    RowSelect := True;
    ReadOnly := True;
    HideSelection := False;
    OnSelectItem := DoSelectItem;
  end;

end;

end.

