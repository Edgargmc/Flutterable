import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hack19/login/new_user_page.dart';
import 'package:hack19/models/parametros.dart';
import 'package:hack19/utils/validate.dart';
import 'package:hack19/widget/app_button.dart';
import 'package:hack19/widget/messages.dart';
import 'package:redux/redux.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final _snackLoginKey = GlobalKey<ScaffoldState>();
  final _formKeyLogin = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _loginEmailKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _loginPasswordKey = GlobalKey<FormFieldState<String>>();
  bool obscureText = true;

  final TextEditingController _loginEmailController = new TextEditingController();
  final TextEditingController _loginPasswordController = new TextEditingController();
  // String _controllerMailCount = controllerMailCount.toString();
  // String _controllerPasswordCount = controllerPassWordCount.toString();
  bool _enabled = true;
  bool _isActive = false;
  /*
  Future _choosePassword() async {
    setState(() {
      _controllerPasswordCount = (controllerPassWordCount - _loginPasswordController.value.text.length).toString();
    });
  }

  Future _chooseMail() async {
    setState(() {
      _controllerMailCount = (controllerMailCount - _loginEmailController.value.text.length).toString();
    });
  }
 */
  Future<bool> _onWillPop() async {
    if (_enabled) {
      Navigator.of(context).pop(true);
      return false;
    } else {
      return false;
    }
  }

/* ****************************************** */
  void onResultFc(FirebaseUser userEntity) {
    print('onResultFc OK');
    Navigator.of(context).pop();
    if (_isActive)
      setState(() {
        _enabled = true;
      });
  }

  void onResult(FirebaseUser userEntity) {
    print('onResult OK');
    Navigator.of(context).pop();
    if (_isActive)
      setState(() {
        _enabled = true;
      });
  }

/* ****************************************** */

/* ****************************************** */

  @override
  initState() {
    super.initState();

    _loginEmailController.text = '';
    _loginPasswordController.text = '';

    //   _loginEmailController.addListener(_chooseMail);
    //   _loginPasswordController.addListener(_choosePassword);
    // widget.vm.signOut(onResult: onResultSignOut, onError: onErrorSigOut);
    _isActive = true;
  }

  @override
  void dispose() {
    _isActive = false;
    super.dispose();

    // _loginEmailController.removeListener(_chooseMail);
    // _loginPasswordController.removeListener(_choosePassword);
  }

/* ****************************************** */
  @override
  Widget build(BuildContext context) {
    //  timeDilation = 0.4;
    try {
      final email = Padding(
        padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 10.0, bottom: 5.0),
        child: new TextFormField(
          key: _loginEmailKey,
          autofocus: false,
          controller: _loginEmailController,
          decoration: InputDecoration(
            //  border: customBorderInputText,
            icon: const Icon(Icons.email),
            hintText: 'Ingrese email *',
            labelText: 'Email *',
            enabled: _enabled,
            // counterText: _controllerMailCount,
          ),
          //  initialValue: widget.isEditing ? widget.userBasic.email : '',
          maxLength: 40,
          inputFormatters: [new LengthLimitingTextInputFormatter(40)],
          validator: (val) => validateMail(val),
          //onSaved: (val) => ub = ub.copyWitch(email: val.trim()),
          keyboardType: TextInputType.emailAddress,
        ),
      );

      final password = Padding(
        padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: TextFormField(
          key: _loginPasswordKey,
          autofocus: false,
          //  initialValue: 'thinkpad2',
          obscureText: obscureText,
          controller: _loginPasswordController,
          decoration: InputDecoration(
            //   border: customBorderInputText,
            icon: InkWell(
              child: obscureText
                  ? Icon(
                      FontAwesomeIcons.eyeSlash,
                    )
                  : Icon(FontAwesomeIcons.eye),
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            hintText: 'Password',
            labelText: 'Password *',
            enabled: _enabled,
            //counterText: _controllerPasswordCount,

            //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
          ),
          maxLength: controllerPassWordCount,
          inputFormatters: [new LengthLimitingTextInputFormatter(controllerPassWordCount)],
          validator: (val) => validatePassword(val),
          keyboardType: TextInputType.text,
        ),
      );

      Widget loginBtnAnimated() {
        if (_enabled) {
          return AppButtom(
            context: context,
            label: "Ingresar",
            customOnTap: () {
              if (_enabled && _formKeyLogin.currentState.validate()) {
                setState(() async {
                  if (_enabled) {
                    _enabled = false;
                    try {
                      String email = _loginEmailKey.currentState.value;
                      String password = _loginPasswordKey.currentState.value;
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((onValue) {
                        print('ok');
                      }).catchError((onError) {
                        showMessageError(context: context, message: onError.toString());
                        _enabled = true;
                        setState(() {});
                      });
                    } catch (onError) {
                      showMessageError(context: context, message: onError.toString());
                      _enabled = true;
                      setState(() {});
                    }
                  }
                });
              }
            },
          );
        } else {
          return AppButtonProgress();
        }
      }

      ;

      final newUser = AppButtom(
        context: context,
        label: 'Nueva  Cuenta',
        customOnTap: () {
          if (_enabled) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  // return new NewUserPage();
                  return new NewUserScreen();
                  // return new Test();
                },
              ),
            );
          }
        },
      );

      return new WillPopScope(
          onWillPop: _onWillPop,
          child: new Scaffold(
            key: _snackLoginKey,
            appBar: new PreferredSize(
              preferredSize: new Size(null, 50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Flutterable'),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Form(
                  key: _formKeyLogin,
                  autovalidate: true,
                  child: new ListView(
                    // padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            //children: <Widget>[new Tick(image: tick), Center(child: new FormContainer()), new SignUp()],
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                              ),
                              Text(
                                'Ingreso de Usuario',
                                //  style: AppTheme.TSTitulo20,
                                textAlign: TextAlign.center,
                              ),
                              email,
                              password,
                              loginBtnAnimated(),
                              newUser,
                            ],
                          ),
                          //  Padding(padding: const EdgeInsets.all(80.0), child: loginBtn),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    } catch (onError, stackTrace) {
      // widget.vm.sendLogError(message: "login_page.BuildContext: " + onError.toString() + ' stackTrace:' + stackTrace.toString());
    }
  }
}
