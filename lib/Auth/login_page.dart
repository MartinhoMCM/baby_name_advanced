
import 'package:baby_names/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


final GoogleSignIn _googleSignIn =GoogleSignIn();
final FirebaseAuth _auth =FirebaseAuth.instance;
var  msg='';

Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
  return user;
}

class LoginPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: Container(
         color: Colors.white,
         child: Center(
           child: Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               FlutterLogo(size: 150),
               SizedBox(height: 50),
               _signInButton(),
             ],
           ),
         ),
       )
    );
  }

  Widget _signInButton() {

    return OutlineButton(
      splashColor: Colors.grey,
      onPressed:(){
        _handleSignIn().then( (FirebaseUser  user)=>moveNextScreen(user)).
        catchError((e) => debugPrint(' Message $msg \n'
            '$e \n'));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey,),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('images/google_logo.png'), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void moveNextScreen( FirebaseUser user)
  {

    debugPrint('Confirm user ${user.displayName}');
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MyHomePage(user)
    ));
  }

}