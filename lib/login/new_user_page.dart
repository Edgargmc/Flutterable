import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hack19/models/parametros.dart';
import 'package:hack19/models/result.dart';
import 'package:hack19/models/user.dart';
import 'package:hack19/utils/string_util.dart';
import 'package:hack19/utils/uuid.dart';
import 'package:hack19/utils/validate.dart';
import 'package:hack19/widget/app_button.dart';

import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:hack19/widget/messages.dart';

/* *********************************************************************** */
class NewUserScreen extends StatefulWidget {
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _snackCreateUserKey = GlobalKey<ScaffoldState>();
  final _formKeyNewUser = GlobalKey<FormState>();
  bool obscureText = true;
  static final GlobalKey<FormFieldState<String>> _nameKey = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _loginEmailKey1 = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _loginPasswordKey1 = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _loginPasswordKey2 = GlobalKey<FormFieldState<String>>();

  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _loginEmailController1 = new TextEditingController();
  final TextEditingController _loginPasswordController1 = new TextEditingController();
  final TextEditingController _loginPasswordController2 = new TextEditingController();
//  String _controllerNameCount = controllerNameCount.toString();
//  String _controllerMailCount = controllerMailCount.toString();
//  String _controllerPasswordCount = controllerPassWordCount.toString();
//  String _controllerPasswordCount2 = controllerPassWordCount.toString();
  bool _enabled = true;
  bool _isActive = true;
  //final prefs = await SharedPreferences.getInstance();
  //String email = prefs.getString('firebaseUser.email');

  EdgeInsets _contentPadding = EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);
  @override
  initState() {
    super.initState();

    //final prefs = await SharedPreferences.getInstance();
    //String email = prefs.getString('firebaseUser.email');
    _controllerName.text = '';
    _loginEmailController1.text = '';
    _loginPasswordController1.text = '';
    _loginPasswordController2.text = '';
    _isActive = true;
    // _controllerName.addListener(_chooseName);
    // _loginEmailController1.addListener(_chooseMail);
    // _loginPasswordController1.addListener(_choosePassword);
    // _loginPasswordController2.addListener(_choosePassword2);
  }

  @override
  void dispose() {
    super.dispose();
    _isActive = true;
  }

  Future<bool> _onWillPop() async {
    if (_enabled) {
      Navigator.of(context).pop(true);
      return false;
    } else {
      return false;
    }
  }

  TextStyle _ts = TextStyle(fontSize: 14.0, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    try {
      final name = Padding(
          padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 10.0, bottom: 5.0),
          child: TextFormField(
            key: _nameKey,
            controller: _controllerName,
            decoration: InputDecoration(
              // border: customBorderInputText,
              contentPadding: _contentPadding,
              icon: const Icon(Icons.person),
              hintText: 'Ingrese su nombre completo *',
              labelText: 'Nombre completo *',
              //  counterText: _controllerNameCount,
              //  enabled: widget.isEditingMode,
            ),
            inputFormatters: [new LengthLimitingTextInputFormatter(controllerNameCount)],
            validator: (val) => validateName(val),
            maxLength: controllerNameCount,
            keyboardType: TextInputType.text,
          ) // onSaved: (val) => ub = ub.copyWitch(name: val.trim()),
          );
      final email = Padding(
        padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 10.0, bottom: 5.0),
        child: new TextFormField(
          key: _loginEmailKey1,
          autofocus: false,
          controller: _loginEmailController1,
          decoration: InputDecoration(
            // border: customBorderInputText,
            contentPadding: _contentPadding,
            icon: const Icon(Icons.email),
            hintText: 'Ingrese email *',
            labelText: 'Email *',
            enabled: _enabled,
            //  counterText: _controllerMailCount,
          ),
          //  initialValue: widget.isEditing ? widget.userBasic.email : '',
          maxLength: controllerMailCount,
          inputFormatters: [new LengthLimitingTextInputFormatter(controllerMailCount)],
          validator: (val) => validateMail(val),
          //onSaved: (val) => ub = ub.copyWitch(email: val.trim()),
          keyboardType: TextInputType.emailAddress,
        ),
      );

      final password = Padding(
        padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: TextFormField(
          key: _loginPasswordKey1,
          autofocus: false,
          obscureText: obscureText,
          controller: _loginPasswordController1,
          decoration: InputDecoration(
            //  border: customBorderInputText,
            contentPadding: _contentPadding,
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
            //   counterText: _controllerPasswordCount,
          ),
          maxLength: controllerPassWordCount,
          inputFormatters: [new LengthLimitingTextInputFormatter(controllerPassWordCount)],
          validator: (val) => validatePassword(val),
          keyboardType: TextInputType.text,
        ),
      );
      final password2 = Padding(
        padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 5.0, bottom: 5.0),
        child: TextFormField(
          key: _loginPasswordKey2,
          autofocus: false,
          obscureText: obscureText,
          controller: _loginPasswordController2,
          decoration: InputDecoration(
            contentPadding: _contentPadding,
            //  border: customBorderInputText,
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
            hintText: 'Repite password',
            labelText: 'Repite password *',
            enabled: _enabled,
            //  counterText: _controllerPasswordCount2,

            //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
          ),
          maxLength: controllerPassWordCount,
          validator: (val) => validatePassword2(_loginPasswordKey1.currentState.value, val),
          keyboardType: TextInputType.text,
        ),
      );
      Widget setUpButtonChild() {
        if (_enabled) {
          return Center(
            child: Text(
              "Crear Cuenta",
              //style: AppTheme.TSButton,
            ),
          );
        } else if (!_enabled) {
          return Container(
            height: 20.0,
            width: 20.0,
            child: SpinKitRipple(color: Colors.white),
          );
        } else {
          return Icon(Icons.check, color: Colors.white);
        }
      }

      void onErrorSingIn(ErrorCallback error) {
        if (_isActive) {
          setState(() {});
        }
      }

      void onErrorNewUser(ErrorCallback error) {
        if (_isActive) {
          setState(() {});
        }

        _snackCreateUserKey.currentState.showSnackBar(new SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Icon(FontAwesomeIcons.flushed, size: 14),
              ),
              //new Text(error.message, style: _ts),
            ],
          ),
          duration: Duration(seconds: 6),
          action: new SnackBarAction(
              label: 'Ok',
              onPressed: () {
                _snackCreateUserKey.currentState.hideCurrentSnackBar();
                return true;
              }),
        ));
        //  widget.vm.sendLogError(message: 'new_user_page onErrorNewUser: ' + error.message);
      }

      void onResultSingIn(FirebaseUser userEntity) {
        _enabled = true;
        // widget.vm.acceptTerms(onResult: null, onError: null, accept: true);

        if (_isActive) {
          setState(() {});
        }

        //  Navigator.pop(context);
      }

/* ****************************************** */
/* ****************************************** */

/* ****************************************** */

/* ****************************************** */
/* ****************************************** */
      Widget loginBtnAnimated() {
        if (_enabled) {
          return AppButtom(
            context: context,
            label: "Crear Cuenta",
            customOnTap: () async {
              if (_enabled && _formKeyNewUser.currentState.validate()) {
                if (_enabled) {
                  _enabled = false;
                  if (_isActive) {
                    setState(() {});
                  }
                  _snackCreateUserKey.currentState.hideCurrentSnackBar();
                  _controllerName.text = capitalizeName(_nameKey.currentState.value);
                  _loginEmailController1.text = capitalizeMail(_loginEmailKey1.currentState.value);

                  User user = User(id: Uuid().generateV4(), name: _nameKey.currentState.value, email: _loginEmailKey1.currentState.value);

                  try {
                    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 'addUser')..timeout = const Duration(seconds: 90);

                    String pass = _loginPasswordKey1.currentState.value;
                    pass = pass.trim();
                    HttpsCallableResult res = await callable.call(
                      <String, dynamic>{
                        "user": user.toJson(),
                        'password': pass,
                      },
                    );
                    ResponseFunction response = ResponseFunction.fromJson(res.data);
                    if (response.status == true) {
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: pass);
                    } else {
                      showMessage(context: context, message: response.message);
                    }
                  } on CloudFunctionsException catch (e) {
                    print(e.toString());
                    showMessage(context: context, message: e.code + ' ' + e.message);
                    _enabled = true;
                    if (_isActive) {
                      setState(() {});
                    }
                  }
                }
              }
            },
          );
        } else {
          return AppButtonProgress();
        }
      }

      return (WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            key: _snackCreateUserKey,
            appBar: new PreferredSize(
              preferredSize: new Size(null, 50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Flutterable'),
                leading: IconButton(
                  //icon: const Icon(FontAwesomeIcons.chevronLeft),
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_enabled) {
                      _onWillPop();
                    }
                  },
                ),
              ),
            ),
            body: Form(
              key: _formKeyNewUser,
              autovalidate: true,
              child: new ListView(
                //padding: const EdgeInsets.all(0.0),
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
                          //   widget.vm.userCurrent.isPrestador ? Text('Cuenta Prestador de Servicios') : Text('Cuenta Prestador de Servicios'),

                          name,
                          email,
                          password,
                          password2,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 18.0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Ver password',
                                    // style: TextStyle(fontSize: 12.0, color: Colors.white70),
                                  ),
                                  new Checkbox(
                                      value: !obscureText,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (bool value) {
                                        setState(() {
                                          obscureText = !value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                          loginBtnAnimated(),
                        ],
                      ),
                      //  Padding(padding: const EdgeInsets.all(80.0), child: loginBtn),
                    ],
                  ),
                ],
              ),
            ),
          )));
    } catch (error) {
      return Container(
        width: 200.0,
        height: 200.0,
        child: Center(
          child: Text(error.toString()),
        ),
      );
    }
  }
}

class ErrorCallback {}
