import 'dart:async';
import 'package:Beautix/models/models.dart';
import 'package:Beautix/models/result.dart';
import 'package:Beautix/presentations/messages.dart';
import 'package:Beautix/presentations/user_type.dart';
import 'package:Beautix/redux/app_state.dart';
import 'package:Beautix/redux/user_repository.dart';
import 'package:Beautix/theme.dart';
import 'package:Beautix/utils/zigzag.dart';
import 'package:Beautix/widget/LoadingIndicator.dart';
import 'package:Beautix/widgets/app_button.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:Beautix/redux/actions.dart';

class TermsContainer extends StatelessWidget {
  final bool showBack;
  final bool showAccept;
  TermsContainer({this.showBack = false, this.showAccept: true});
  ZipZagItem item = ZipZagItem("Arc", "assets/nota.png", "The bottom edge of the above edge is arc-shaped", ClipType.arc);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, context);
      },
      builder: (context, vm) {
        return Material(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0.0,
                top: 75.0,
                child: Terms(vm: vm, showBack: showBack, showAccept: showAccept),
              ),
              ZigZag(
                clipType: item.clipType,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  color: AppTheme.TriadaPrimary,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 34.0,
                top: 28.0,
                child: Image.asset(
                  item.image,
                  height: 68.0,
                  width: 68.0,
                  // fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: 2.0,
                top: 16.0,
                child: this.showBack /* && vm.userCurrent.terms != null */
                    ? IconButton(
                        //icon: const Icon(FontAwesomeIcons.chevronLeft),
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          vm.back();
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Function({Function onResult, Function onError, bool accept}) acceptTerms;
  final Function({Function onResult, Function onError}) getTerms;
  final Function({ILogType logType, String message}) sendLogEvent;
  final User userCurrent;
  final Config config;
  final FirebaseUser currentUser;
  final Function back;
  final BuildContext context;

  _ViewModel({
    @required this.userCurrent,
    @required this.config,
    @required this.acceptTerms,
    @required this.getTerms,
    @required this.currentUser,
    @required this.sendLogEvent,
    @required this.back,
    @required this.context,
  });

  factory _ViewModel.fromStore(Store<AppState> store, BuildContext context) {
    return _ViewModel(
      context: context,
      currentUser: UserRepository().firebaseUser,
      config: store.state.config,
      userCurrent: store.state.userCurrent,
      acceptTerms: ({Function onResult, Function onError, bool accept}) {
        store.dispatch(TermsAction(onResult: onResult, onError: onError, type: accept ? TermType.accept : TermType.revoke));
      },
      getTerms: ({Function onResult, Function onError}) {
        store.dispatch(TermsAction(onResult: onResult, onError: onError, type: TermType.get));
      },
      back: () {
        Navigator.of(context).pop();
      },
      sendLogEvent: ({String message, ILogType logType = ILogType.logError}) {
        store.dispatch(SendLogEvent(log: Log(logtype: logType, message: message)));
      },
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is _ViewModel && runtimeType == other.runtimeType && userCurrent == other.userCurrent && currentUser == other.currentUser;

  @override
  int get hashCode => userCurrent.hashCode ^ currentUser.hashCode;
}

class Terms extends StatefulWidget {
  final _ViewModel vm;
  final bool showBack;
  final bool showAccept;
  Terms({this.vm, this.showBack, this.showAccept});
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  // with WidgetsBindingObserver {
  bool _processing = false;
  bool _isActive = false;
  String terms;
  bool _acceptTerms = false;
  // bool isBackButtonActivated = false;
  onError(ErrorCallback error) async {
    // Scaffold.of(context).hideCurrentSnackBar();

    await showMessageError(context: context, message: error.message);
    if (_isActive)
      setState(() {
        _processing = false;
      });
  }

  Future onResultGetTerms(Result result) async {
    _processing = false;
    if (result.status) {
      if (result.data != null) {
        if (_isActive)
          setState(() {
            this.terms = result.data;
          });
      }
    } else {
      //  Scaffold.of(context).hideCurrentSnackBar();
      showMessageError(context: context, message: result.message);
    }
  }

  Future onResultAccept(Result result) async {
    _processing = false;
    try {
      if (result.status) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              // return new NewUserPage();
              return new UserTypeContainer(
                showBack: true,
              );
              // return new Test();
            },
          ),
        );
      } else {
        showMessageError(context: context, message: result.message);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  setTerms(bool value) {
    if (_isActive)
      setState(() {
        _acceptTerms = value;
        _processing = false;
      });
    if (widget.vm.userCurrent == null || widget.vm.userCurrent.terms == null) {
      widget.vm.sendLogEvent(logType: ILogType.logAcceptTerm, message: ('none') + '\nAcceptTerminos: ' + widget.vm.config.terms + ' date:' + DateTime.now().toUtc().toString());

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            // return new NewUserPage();
            return new UserTypeContainer(
              showBack: true,
              terms: widget.vm.config.terms,
            );
            // return new Test();
          },
        ),
      );
    } else {
      widget.vm.acceptTerms(onResult: onResultAccept, onError: onError, accept: value);
    }
  }

/*
  setTerms(bool value) {
    if (_isActive)
      setState(() {
        _acceptTerms = value;
        _processing = false;
      });
    if (widget.vm.userCurrent.terms == null) {
      widget.vm.sendLogEvent(
          logType: ILogType.logAcceptTerm, message: (widget.vm.userCurrent.name ?? 'none') + '\nAcceptTerminos: ' + widget.vm.config.terms + ' date:' + DateTime.now().toUtc().toString());

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            // return new NewUserPage();
            return new UserTypeContainer(
              showBack: true,
              terms: widget.vm.config.terms,
            );
            // return new Test();
          },
        ),
      );
    } else {
      widget.vm.acceptTerms(onResult: onResultAccept, onError: onError, accept: value);
    }
  }
*/
  @override
  void initState() {
    super.initState();
    _isActive = true;
    _processing = false;
    widget.vm.getTerms(onResult: onResultGetTerms, onError: onError);
    //WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _isActive = false;
    _processing = false;
    super.dispose();
    //  WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 170.0,
          // color: Colors.red,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: terms != null
                    ? Html(
                        data: terms,
                        defaultTextStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: _isActive ? SpinKitRipple(color: AppTheme.TriadaPrimary) : Container(), //,
                      )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 8.0, bottom: 30.0),
          child: _processing
              ? AppButtonProgress()
              : widget.showAccept && terms != null
                  ? AppButtom(
                      context: context,
                      label: 'Aceptar y Registrarme',
                      customOnTap: () {
                        this.setTerms(true);
                      },
                    )
                  : Container(),
        ),
        /*
        widget.vm.userCurrent != null && widget.vm.userCurrent.terms != null
            ? Container(height: 0.0, width: 0.0)
            : new FlatButton(
                // color: EgoTheme.buttomSave,
                onPressed: () => exit(0),
                child: new Text('Salir'),
              ),

         */
      ],
    );
  }
}
