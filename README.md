# Object Ispector #
Questo è un componente non visuale per la creazione di una custom Object Ispector in delphi

## Setup ##
- Aggiungere il file **ObjectInspector.pas** al tuo progetto.
- Inserire una TListView nella tua Form.
- Nel codice creare un oggetto di tipo **TObjectInspector** e alla sua creazione assegnare la listview inserita in precedenza.

## Esempio ##

```delphi
var
  OI: TObjectInspector;
  List:TStringList;
begin
  List := TStringList.Create;
  List.Add('Mela');
  List.Add('Pera');
  List.Add('Pera');
  
  OI := TObjectInspector.Create(listview);
  OI.AddText('Text1', 'Prova');
  OI.AddText('Text2', 'Prova');
  OI.AddComboBox('Text3', 'Prova',List);
  OI.AddText('Text4', 'Prova');
  
  List.free;
```
