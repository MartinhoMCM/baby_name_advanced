
import 'package:baby_names/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class InsertData extends StatefulWidget
{

  InsertData({Key key, this.choice}):super(key:key);

  final Choice choice;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InsertDataState();
  }

}

class InsertDataState extends State<InsertData>
{

  Firestore db =Firestore.instance;

  TextEditingController _nameController =TextEditingController();
  TextEditingController _voteController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right:8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _voteController,
                decoration: InputDecoration(
                    labelText: 'Votes',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),

            RaisedButton(
              onPressed: () async{
                if(_nameController.text!=null && _nameController.text.length!=0 )
                await db.collection('baby').add({'name': _nameController.text, 'votes':int.parse(_voteController.text)});
                _nameController.text='';
                _voteController.text='';

              },
              child: Text('Enter', style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),

            )


          ],
        ),
      ),
    );
  }



}





