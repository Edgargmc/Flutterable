import 'package:Beautix/models/parametros.dart';
import 'package:Beautix/models/result.dart';
import 'package:Beautix/redux/actions.dart' as actions;
import 'package:Beautix/redux/app_state.dart';
import 'package:Beautix/theme.dart';
import 'package:Beautix/widget/customs.dart';
import 'package:Beautix/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:Beautix/utils/validate.dart';
import './../messages.dart';

class RescueUserPage extends StatelessWidget {
  final String email;
  RescueUserPage({this.email});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModelRescueUserPage>(
      converter: (Store<AppState> store) {
        return _ViewModelRescueUserPage.from(store, context);
      },
      builder: (context, vm) {
        return NewRescueScreen(rescuePassword: vm.rescuePassword, email: this.email);
      },
    );
  }
}

/* **************************************************************************************** */
class _ViewModelRescueUserPage {
  final Function({Function onResult, Function onError, String email}) rescuePassword;

  _ViewModelRescueUserPage({
    @required this.rescuePassword,
  });

  factory _ViewModelRescueUserPage.from(Store<AppState> store, BuildContext context) {
    return _ViewModelRescueUserPage(
      rescuePassword: ({Function onResult, Function onError, String email, String password}) async {
        email = email.trim();

        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((onValue) async {
          Result result = new Result(status: true, message: 'Se envío a \n' + email + '\nel link para recuperar el password.');
          onResult(result);
        }).catchError((/*PlatformException */ onErrorPlatform) {
          String msg;
          if (onErrorPlatform.details != null) {
            msg = onErrorPlatform.details;
          } else {
            msg = onErrorPlatform.toString();
          }
          ErrorCallback errorCallback = new ErrorCallback('_ViewModelLoginPage.FirebasecreateUserWithEmailAndPassword1', msg, ILogType.logError);
          onError(errorCallback);
          // showMessageError(context: context, message: error.message);
        }).catchError((onError) {
          ErrorCallback errorCallback = new ErrorCallback('_ViewModelLoginPage.FirebasecreateUserWithEmailAndPassword2', onError.toString(), ILogType.logError);
          store.dispatch(actions.SendLogEvent(log: Log(logtype: ILogType.logError, message: '_ViewModelLoginPage.FirebasecreateUserWithEmailAndPassword2 ' + onError.toString())));
          onError(errorCallback);
          print(onError.toString());
        });
      },
    );
  }
}

/* **************************************************************************************** */
class NewRescueScreen extends StatefulWidget {
  final Function({Function onResult, Function onError, String email}) rescuePassword;
  final String email;

  NewRescueScreen({
    @required this.rescuePassword,
    @required this.email,
  });
  @override
  _NewRescueScreenState createState() => _NewRescueScreenState();
}

/* **************************************************************************************** */
class _NewRescueScreenState extends State<NewRescueScreen> {
  final _snackRescuePasswordKey = GlobalKey<ScaffoldState>();
  final _formKeyRescue = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _loginEmailKey3 = GlobalKey<FormFieldState<String>>();

  var animationStatus = 0;
  final TextEditingController _loginEmailController3 = new TextEditingController();

  //String _controllerMailCount = controllerMailCount.toString();

  bool _enabled = true;
  //final prefs = await SharedPreferences.getInstance();
  //String email = prefs.getString('firebaseUser.email');

  /*
  Future _chooseMail() async {
    setState(() {
      _controllerMailCount = (controllerMailCount - _loginEmailController3.value.text.length).toString();
    });
  }

   */

  @override
  initState() {
    super.initState();

    _loginEmailController3.text = widget.email != null ? widget.email : '';
    //  _loginEmailController3.addListener(_chooseMail);
  }

  @override
  void dispose() {
    super.dispose();
    //  _loginEmailController3.removeListener(_chooseMail);
  }

  Future<bool> _onWillPop() async {
    if (_enabled) {
      Navigator.of(context).pop(true);
      return false;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //  timeDilation = 0.4;

    final email = Padding(
      padding: EdgeInsets.only(left: 16.0, right: 20.0, top: 10.0, bottom: 5.0),
      child: new TextFormField(
        key: _loginEmailKey3,
        autofocus: true,
        // initialValue: widget.email,
        controller: _loginEmailController3,
        decoration: InputDecoration(
          //  border: customBorderInputText,
          icon: const Icon(Icons.email),
          hintText: 'Ingrese email *',
          labelText: 'Email *',
          enabled: _enabled,
          //counterText: _controllerMailCount,
        ),
        //  initialValue: widget.isEditing ? widget.userBasic.email : '',
        maxLength: controllerMailCount,
        inputFormatters: [new LengthLimitingTextInputFormatter(40)],
        validator: (val) => validateMail(val),
        //onSaved: (val) => ub = ub.copyWitch(email: val.trim()),
        keyboardType: TextInputType.emailAddress,
      ),
    );

    void onError(ErrorCallback error) {
      setState(() {
        _enabled = true;
      });
      TextStyle _ts = TextStyle(fontSize: 14.0, color: Colors.white);

      _snackRescuePasswordKey.currentState.showSnackBar(new SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Icon(FontAwesomeIcons.flushed, size: iconSize),
            ),
            new Text(error.message, style: _ts),
          ],
        ),
        duration: Duration(seconds: 6),
        action: new SnackBarAction(
            label: 'Ok',
            onPressed: () {
              _snackRescuePasswordKey.currentState.hideCurrentSnackBar();
              return true;
            }),
      ));
    }

    Future onResult(Result result) async {
      setState(() {
        _enabled = true;
      });
      if (result.status) {
        await showMessage(context: context, message: result.message);
        Navigator.pop(context);
      } else {
        showMessageError(context: context, message: result.message).then((value) {
          print('Value is $value');
        });
      }
    }

    Widget rescueBtnAnimated() {
      if (_enabled) {
        return AppButtom(
          context: context,
          label: "Recuperar Password",
          customOnTap: () {
            if (_enabled && _formKeyRescue.currentState.validate()) {
              setState(() {
                if (_enabled) {
                  _enabled = false;
                  _snackRescuePasswordKey.currentState.hideCurrentSnackBar();
                  widget.rescuePassword(onResult: onResult, onError: onError, email: _loginEmailKey3.currentState.value);
                }
              });
            }
          },
        );
      } else {
        return AppButtonProgress();
      }
    }

    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: _snackRescuePasswordKey,
          appBar: new PreferredSize(
            preferredSize: new Size(null, 50.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: AppTheme.logoAppSolo,
              leading: IconButton(
                //icon: const Icon(FontAwesomeIcons.chevronLeft),
                icon: AppTheme.iconBack,
                onPressed: () {
                  if (_enabled) {
                    _onWillPop();
                  }
                },
              ),
            ),
          ),
          body: Form(
            key: _formKeyRescue,
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.all(0.0),
              children: <Widget>[
                new Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //children: <Widget>[new Tick(image: tick), Center(child: new FormContainer()), new SignUp()],
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                        ),
                        Text(
                          'Recuperar password',
                          style: AppTheme.TSTitulo20,
                          textAlign: TextAlign.center,
                        ),
                        email,
                        rescueBtnAnimated()
                      ],
                    ),
                    //  Padding(padding: const EdgeInsets.all(80.0), child: loginBtn),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
