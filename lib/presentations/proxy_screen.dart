import 'package:hack19/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class ProxyScreen extends StatelessWidget {
  ProxyScreen() : super(key: Key('ProxyScreenKey'));
  Widget getLoading(String message, BuildContext context) {
    return new Material(
        type: MaterialType.transparency,
        child: Container(
          //  color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Container(height: 120.0, width: 120.0, child: Image.asset('assets/icon.png')),
              ),
              // LoadingIndicatorLinear(),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bool _waiting = false;
    bool _toLogin = false;
    String _route = 'none';

    // FirebaseAuth.instance.signOut();
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getLoading('Authenticating..', context);
          } else if (snapshot.hasData) {
            print("====================> HomeScreen  StreamBuilder: " + snapshot.hasData.toString());
            if (FirebaseAuth.instance.currentUser() == null) {
              return LoginPageScreen();
            } else {
              return Home();
            }
          } else if (snapshot.error != null) {
            _waiting = true;
            _route = 'none';
            return getLoading('Error: ' + snapshot.error.toString(), context);
          } else {
            _waiting = false;
            return LoginPageScreen();
            //  return getLoading('Authenticating..', context);
            // Navigator.of(context).pushReplacementNamed(WelcomeContainer.router);
          }
        });
  }
}
