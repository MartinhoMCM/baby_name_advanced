
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'insertdata.dart';

class MyHomePage  extends StatefulWidget{

  FirebaseUser user;
  @override
  State<StatefulWidget> createState() {

    return  _MyHomePageState(user);
  }

  MyHomePage(this.user);

}

class _MyHomePageState extends State<MyHomePage>
{

  FirebaseUser user;

  _MyHomePageState(this.user):assert(user!=null);


  void moveNextScreen()
  {

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => InsertData()
    ));
  }

  @override
  Widget build(BuildContext context) {

      var _select =choices[0];

    setChoice(Choice choice)
    {
        _select=choice ;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello ${user.displayName.substring(0, user.displayName.indexOf(' '))}'),

        actions: <Widget>[
          PopupMenuButton(
            onSelected: setChoice,
            itemBuilder: (BuildContext context)
            {
              return choices.map((Choice choice){
               return  PopupMenuItem<Choice>(
                   value: choice,
                 child: ListTile(
                   title: Text(choice.title),
                   onTap: ()=>moveNextScreen() ,
                 )
                 );
              }).toList();
            },

          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context)
  {
    // TODO: get actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot)
      {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return  _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot)
  {
    return ListView(

      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data)=>_buildListItem(context, data)).toList(),

    );

  }

  Widget _buildListItem(BuildContext context,DocumentSnapshot data)
  {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding:  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)
        ),

        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => print(record),
        ),
      ),
    );
  }

}

class Record
{
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference}):
        assert(map['name']!=null), assert(map['votes']!=null),
        name =map['name'],
        votes =map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot) :
        this.fromMap(snapshot.data, reference:snapshot.reference);


  @override
  String toString() => "Record<$name:$votes>";

}


class Choice
{

  const Choice({this.title});

  final String title;


}

const List<Choice> choices = const <Choice>[
   const Choice(title: 'Insert New Baby Data'), const Choice(title: 'Other')
];

