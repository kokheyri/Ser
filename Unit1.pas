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
    Сontainer:Byte;
    Ship: String;
  End;
  List=^TList;  {Указатель на элемент типа TList}
  TList=record {А это наименование нашего типа "запись" обычно динамические структуры описываются через запись}
    data:TInf;  {данные, хранимые в элементе}
    next:List;   {указатель на следующий элемент списка}
  end;

var
  Form1: TForm1;
  Element:TInf;
  First,Spis,el:List;
implementation

{$R *.dfm}
{Процедура добавления нового элемента в односвязный список}
procedure AddElem(var spis1:List;znach1:TInf);
var
  tmp:List;
begin
  if spis1=nil then {Проверяем не пуст ли список, если пуст, то }
  begin
    GetMem(spis1,sizeof(TList));  {создаём его первый элемент}
    tmp:=spis1;
  end
  else {в случае если список не пуст}
  begin
    tmp:=spis1;
    while tmp^.next<>nil do
      tmp:=tmp^.next; {ставим tmp на последний элемент списка}
    GetMem(tmp^.next,sizeof(TList)); {создаём следующий элемент}
    tmp:=tmp^.next;   {переносим tmp на новый элемент}
  end;
  tmp^.next:=nil; {зануляем указатель}
  tmp^.data:=znach1; {заносим значение}
end;
{процедура поиска в списке}
Function SearchElemZnach(spis1:List;znach1:Integer):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data^.ID) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
{процедура удаления списка}
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
{процедура удаления элемента}
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
{процедура удаления элемента по значению}
procedure DelElemZnach(var Spis1:List;znach1:integer);
var
  tmp:List;
begin
  if Spis1=nil then
  begin
    MessageBox(0,'Список пуст','Ошибка',MB_OK);
    exit;
  end;
  tmp:=SearchElemZnach(spis1,znach1);
  if tmp=nil then
  begin
   // writeln('Элемент с искомым значением ' ,znach1, ' отсутствует в списке.');
    exit;
  end;
  DelElem(spis1,tmp);
  MessageBox(0,'Элемент удален','',MB_OK);
end;

//поиск
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
  MessageBox(0,PChar('ID - '+ IntToStr(el^.data^.ID)+#13#10+'Сырье - '+el^.data^.Material
              +#13#10+'Марка - '+el^.data^.Name+#13#10+'Температура - '+IntToStr(el^.data^.Temperature)
              +#13#10+'Резервуар - '+IntToStr(el^.data^.Сontainer) +#13#10+'Корабль - '+el^.data^.Ship),'Информация',MB_OK);
  Edit1.Text:=IntToStr(el^.data^.ID);
  Edit1.Enabled:=false;
  Edit2.Text:=el^.data^.Material;
  Edit3.Text:=el^.data^.Name;
  Edit4.Text:=IntToStr(el^.data^.Temperature);
  Edit5.Text:=IntToStr(el^.data^.Сontainer);
  Edit6.Text:=el^.data^.Ship;
  Button3.Enabled:=true;
  Button4.Enabled:=true;
  Button1.Enabled:=false;
  end else  MessageBox(0,'Элемента с искомым ID не существует','Ошибка',MB_OK)
end else MessageBox(0,'Заполните поле поиска','Ошибка',MB_OK)

end;
//Изм
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
  El^.data^.Сontainer := StrToInt(Edit5.Text);
  El^.data^.Ship := Edit6.Text;
  button1.Enabled:=true;
  Edit1.Enabled:=true;
  //FreeStek(spis1);
end;
//уд
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

//вывод
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
    IntToStr(pr^.data^.Сontainer) + '  ' + pr^.data^.Ship);
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
//сохр
procedure TForm1.Button7Click(Sender: TObject);
var
  f:TextFile;
  FileDir:String;
  pr:List;
begin
  FileDir:='C:\Users\Яр\Downloads\Серега\File.txt';
  AssignFile(f,FileDir);
  Rewrite(f);
  pr:=First;
  while pr<>nil do
  begin
    Writeln(f,IntToStr(pr^.data^.ID) + '  ' + pr^.data^.Material + '  ' +
    pr^.data^.Name + '  ' + IntToStr(pr^.data^.Temperature) + '  ' +
    IntToStr(pr^.data^.Сontainer) + '  ' + pr^.data^.Ship);
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


//доб
procedure TForm1.Button1Click(Sender: TObject);
begin
  if(Edit1.Text<>'') and (Edit2.Text<>'')and (Edit3.Text<>'') and (Edit4.Text<>'') and (Edit5.Text<>'') and (Edit6.Text<>'') then
  begin
    New(Element);
    Element^.Id := StrToInt(Edit1.Text);
    Element^.Material := Edit2.Text;
    Element^.Name := Edit3.Text;
    Element^.Temperature :=StrToInt(Edit4.Text);
    Element^.Сontainer := StrToInt(Edit5.Text);
    Element^.Ship := Edit6.Text;
    AddElem(Spis,Element);
    First:=Spis;
  end else MessageBox(0,'Заполните все поля','Ошибка',MB_OK);
end;


end.
