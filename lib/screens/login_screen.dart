import 'package:flutter/material.dart';
import 'package:votely/repository/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Votely", style: Theme.of(context).textTheme.headline),
            SizedBox(
              height: 35.0,
            ),
            RaisedButton(
              color: Colors.redAccent,
              onPressed: onSignIn,
              padding: EdgeInsets.symmetric(horizontal: 42.0,vertical: 16.0),
              child: Text(
                "Sign in with google",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSignIn() {
    AuthRepository().signInWithGoogle();
  }
}
