import 'package:flutter/material.dart';
import 'package:tp5/UI/scol_list_dialogue.dart';
import 'package:tp5/UI/scol_list_dialogue_etudiant.dart';
import '../models/list_etudiants.dart';
import '../models/scol_list.dart';
import '../models/const.dart';

import 'package:provider/provider.dart';

import '../util/dbuse.dart';
class StudentsScreen extends StatefulWidget {
final ScolList scolList;
StudentsScreen(this.scolList);
@override
_StudentsScreenState createState() =>
_StudentsScreenState(this.scolList);
}
class _StudentsScreenState extends State<StudentsScreen> {
final ScolList scolList;
_StudentsScreenState(this.scolList);
dbuse? helper;
List<ListEtudiants>? students;
@override
Widget build(BuildContext context) {
helper =  context.read<dbuse>();

int num=0;
ScolListDialog1? dialog = ScolListDialog1();
showData(this.scolList.codClass);
num=(students != null) ? students!.length : 0;
return Scaffold(
appBar: AppBar(
title: Text(scolList.nomClass),
),
body: ListView.builder(
itemCount: (students != null) ? students!.length : 0,
itemBuilder: (BuildContext context, int index) {
   
return Dismissible(
  
key: Key(students![index].prenom),
onDismissed: (direction) {
  num = num-1;
String strName = students![index].prenom;
context.read<dbuse>().deleteList1(students![index]);
setState(() {
students!.removeAt(index);
});
Scaffold.of(context).showSnackBar(
SnackBar(content: Text("$strName deleted")));
},
child:ListTile(
title: Text(students![index].nom),
subtitle: Text(
'Prenom: ${students![index].prenom} - Date Nais:'
+'${students![index].datNais}'),
onTap: () {},
trailing: IconButton(
icon: Icon(Icons.edit),
onPressed: () {
  showDialog(
context: context,
builder: (BuildContext context) =>
dialog.buildDialog1(context, students![index], false));
},
),
)
);}),
floatingActionButton: FloatingActionButton(
onPressed: () {
  constints.id = constints.id+1;
 
  showDialog(
context: context,
builder: (BuildContext context) =>
dialog.buildDialog1(context,ListEtudiants(
 constints.id , widget.scolList.codClass, "nom", "prenom", "datNais"), true),
);
},
child: Icon(Icons.add),
backgroundColor: Colors.pink,
));
}
Future showData(int idList) async {
await context.read<dbuse>().openDb();
students = await context.read<dbuse>().getEtudiants(idList);
setState(() {
students = students;
});
}
}