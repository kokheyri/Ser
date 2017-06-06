unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit7: TEdit;
    Button5: TButton;
    ListBox1: TListBox;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
type
  TInf = ^TListik;
  TListik = Record
    ID:Integer;
    Material:String;
    Name: String;
    Temperature:Byte;
    �ontainer:Byte;
    Ship: String;
  End;
  List=^TList;  {��������� �� ������� ���� TList}
  TList=record {� ��� ������������ ������ ���� "������" ������ ������������ ��������� ����������� ����� ������}
    data:TInf;  {������, �������� � ��������}
    next:List;   {��������� �� ��������� ������� ������}
  end;

var
  Form1: TForm1;
  Element:TInf;
  First,Spis,el:List;
implementation

{$R *.dfm}
{��������� ���������� ������ �������� � ����������� ������}
procedure AddElem(var spis1:List;znach1:TInf);
var
  tmp:List;
begin
  if spis1=nil then {��������� �� ���� �� ������, ���� ����, �� }
  begin
    GetMem(spis1,sizeof(TList));  {������ ��� ������ �������}
    tmp:=spis1;
  end
  else {� ������ ���� ������ �� ����}
  begin
    tmp:=spis1;
    while tmp^.next<>nil do
      tmp:=tmp^.next; {������ tmp �� ��������� ������� ������}
    GetMem(tmp^.next,sizeof(TList)); {������ ��������� �������}
    tmp:=tmp^.next;   {��������� tmp �� ����� �������}
  end;
  tmp^.next:=nil; {�������� ���������}
  tmp^.data:=znach1; {������� ��������}
end;
{��������� ������ � ������}
Function SearchElemZnach(spis1:List;znach1:Integer):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data^.ID) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
{��������� �������� ������}
Procedure FreeStek(spis1:List);
var
  tmp:List;
begin
  while spis1<>nil do
  begin
    tmp:=spis1;
    spis1:=spis1^.next;
    FreeMem(tmp,SizeOf(Tlist));
  end;
end;
{��������� �������� ��������}
Procedure DelElem(var spis1:List;tmp:List);
var
  tmpi:List;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then
  begin
    spis1:=tmp^.next;
    FreeMem(tmp,SizeOf(TList));
  end
  else
  begin
    tmpi:=spis1;
    while tmpi^.next<>tmp do
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next;
    FreeMem(tmp,sizeof(TList));
  end;
end;
{��������� �������� �������� �� ��������}
procedure DelElemZnach(var Spis1:List;znach1:integer);
var
  tmp:List;
begin
  if Spis1=nil then
  begin
    MessageBox(0,'������ ����','������',MB_OK);
    exit;
  end;
  tmp:=SearchElemZnach(spis1,znach1);
  if tmp=nil then
  begin
   // writeln('������� � ������� ��������� ' ,znach1, ' ����������� � ������.');
    exit;
  end;
  DelElem(spis1,tmp);
  MessageBox(0,'������� ������','',MB_OK);
end;

//�����
procedure TForm1.Button2Click(Sender: TObject);
var
  pr:List;
begin
new(pr);
pr:=spis;
if (Edit7.Text<>'') then
begin
  el:=SearchElemZnach(pr,StrToInt(Edit7.Text));
  if el<>nil then
  begin
  MessageBox(0,PChar('ID - '+ IntToStr(el^.data^.ID)+#13#10+'����� - '+el^.data^.Material
              +#13#10+'����� - '+el^.data^.Name+#13#10+'����������� - '+IntToStr(el^.data^.Temperature)
              +#13#10+'��������� - '+IntToStr(el^.data^.�ontainer) +#13#10+'������� - '+el^.data^.Ship),'����������',MB_OK);
  Edit1.Text:=IntToStr(el^.data^.ID);
  Edit1.Enabled:=false;
  Edit2.Text:=el^.data^.Material;
  Edit3.Text:=el^.data^.Name;
  Edit4.Text:=IntToStr(el^.data^.Temperature);
  Edit5.Text:=IntToStr(el^.data^.�ontainer);
  Edit6.Text:=el^.data^.Ship;
  Button3.Enabled:=true;
  Button4.Enabled:=true;
  Button1.Enabled:=false;
  end else  MessageBox(0,'�������� � ������� ID �� ����������','������',MB_OK)
end else MessageBox(0,'��������� ���� ������','������',MB_OK)

end;
//���
procedure TForm1.Button3Click(Sender: TObject);
var
  spis1:List;
begin
  new(spis1);
  spis1:=Spis;
  el:=SearchElemZnach(spis1,StrToInt(Edit7.Text));
  el^.data^.ID:=StrToInt(Edit7.Text);
  El^.data^.Material := Edit2.Text;
  El^.data^.Name := Edit3.Text;
  El^.data^.Temperature :=StrToInt(Edit4.Text);
  El^.data^.�ontainer := StrToInt(Edit5.Text);
  El^.data^.Ship := Edit6.Text;
  button1.Enabled:=true;
  Edit1.Enabled:=true;
  //FreeStek(spis1);
end;
//��
procedure TForm1.Button4Click(Sender: TObject);
var
  spis1:List;
begin
  //new(spis1);
 // spis1:=Spis;
  DelElemZnach(First,StrToInt(Edit7.Text));
  //FreeStek(spis1);
  Button3.Enabled:=false;
  Button4.Enabled:=false;
  Edit1.Enabled:=true;
  Button1.Enabled:=true;
  Edit7.Text:='';
  Edit1.Text:='';
  Edit2.Text:='';
  Edit3.Text:='';
  Edit4.Text:='';
  Edit5.Text:='';
  Edit6.Text:='';
end;

//�����
procedure TForm1.Button5Click(Sender: TObject);
var
  pr:List;
begin
  ListBox1.Clear;
  pr:=First;
  while pr<>nil do
  begin
    ListBox1.Items.Add(IntToStr(pr^.data^.ID) + '  ' + pr^.data^.Material + '  ' +
    pr^.data^.Name + '  ' + IntToStr(pr^.data^.Temperature) + '  ' +
    IntToStr(pr^.data^.�ontainer) + '  ' + pr^.data^.Ship);
    pr:=pr^.next;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Button1.Enabled:=true;
  Edit1.Enabled:=true;
  Button3.Enabled:=false;
  Button4.Enabled:=false;
end;
//����
procedure TForm1.Button7Click(Sender: TObject);
var
  f:TextFile;
  FileDir:String;
  pr:List;
begin
  FileDir:='C:\Users\��\Downloads\������\File.txt';
  AssignFile(f,FileDir);
  Rewrite(f);
  pr:=First;
  while pr<>nil do
  begin
    Writeln(f,IntToStr(pr^.data^.ID) + '  ' + pr^.data^.Material + '  ' +
    pr^.data^.Name + '  ' + IntToStr(pr^.data^.Temperature) + '  ' +
    IntToStr(pr^.data^.�ontainer) + '  ' + pr^.data^.Ship);
    pr:=pr^.next;
  end;
  Flush(f);
  CloseFile(f);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
new(First);
new(el);
new(Spis);
Spis:=nil;
end;


//���
procedure TForm1.Button1Click(Sender: TObject);
begin
  if(Edit1.Text<>'') and (Edit2.Text<>'')and (Edit3.Text<>'') and (Edit4.Text<>'') and (Edit5.Text<>'') and (Edit6.Text<>'') then
  begin
    New(Element);
    Element^.Id := StrToInt(Edit1.Text);
    Element^.Material := Edit2.Text;
    Element^.Name := Edit3.Text;
    Element^.Temperature :=StrToInt(Edit4.Text);
    Element^.�ontainer := StrToInt(Edit5.Text);
    Element^.Ship := Edit6.Text;
    AddElem(Spis,Element);
    First:=Spis;
  end else MessageBox(0,'��������� ��� ����','������',MB_OK);
end;


end.
