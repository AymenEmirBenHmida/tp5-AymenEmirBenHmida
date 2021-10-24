import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp5/util/dbuse.dart';
import 'package:provider/provider.dart';

import 'UI/scol_list_dialogue.dart';
import 'UI/students_screen.dart';
import 'models/scol_list.dart';

void main() => runApp(MyApp1());
class MyApp1 extends StatelessWidget {
@override
Widget build(BuildContext context) {
dbuse helper = dbuse();
helper.testDb();
return
MultiProvider(
  providers: [
    Provider<dbuse>(create: (_) => dbuse()),

  ],
  child: MyApp(),
);
}}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
dbuse helper = dbuse();
helper.testDb();
return MaterialApp(
title: 'classes List',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: ShList());
}
}

class ShList extends StatefulWidget {
@override
_ShListState createState() => _ShListState();
}
class _ShListState extends State<ShList> {
List<ScolList>? scolList;
dbuse helper = dbuse();
ScolListDialog? dialog = ScolListDialog();
int num = 0;
@override
void initState() {
dialog = ScolListDialog();
scolList = [];
super.initState();
}
@override
Widget build(BuildContext context) {
  ScolListDialog? dialog = ScolListDialog();

showData();
num=(scolList != null) ? scolList!.length : 0;
return Scaffold(
appBar: AppBar(
title: Text(' Classes list'),
),
body: ListView.builder(
  
itemCount: (scolList != null) ? scolList!.length : 0,
itemBuilder: (BuildContext context, int index) {
   
return Dismissible(
  
key: Key(scolList![index].nomClass),
onDismissed: (direction) {
  num = num-1;
String strName = scolList![index].nomClass;
helper.deleteList(scolList![index]);
setState(() {
scolList!.removeAt(index);
});
Scaffold.of(context).showSnackBar(
SnackBar(content: Text("$strName deleted")));
},
child: ListTile(
  onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => StudentsScreen(scolList![index])),
);
},
title: Text(scolList![index].nomClass),
leading: CircleAvatar(
child: Text(scolList![index].codClass.toString()),
),
trailing: IconButton(
icon: Icon(Icons.edit),
onPressed: () {
    print(index.toString());
   

showDialog(
context: context,
builder: (BuildContext context) =>
dialog.buildDialog(context, scolList![index], false));
},
)));
}),
floatingActionButton: FloatingActionButton(
onPressed: () {
  var id;
  if(num == 0)
  id=0;
  else
  id=num+1;
showDialog(
context: context,
builder: (BuildContext context) =>
dialog.buildDialog(context, ScolList(num+1, '', 0), true),
);
},
child: Icon(Icons.add),
backgroundColor: Colors.pink,
));




}

Future showData() async {
await helper.openDb();
scolList = await helper.getClasses();
setState(() {
scolList = scolList;
});
}}