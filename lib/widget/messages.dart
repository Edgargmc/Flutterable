import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

const double iconSize = 28.0;

Future<bool> showMessageError({@required BuildContext context, @required String message}) async {
  //vibrate(FeedbackType.error);
  // Scaffold.of(context).hideCurrentSnackBar();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(FontAwesomeIcons.flushed, size: iconSize),
              ),
              new Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            /*
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
            */
          ],
        );
      });
}

Future<bool> showMessage({@required BuildContext context, @required String message}) async {
  // vibrate(FeedbackType.impact);
  TextStyle _ts;
  int len = message.length;
  if (len > 50) {
    _ts = TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.white);
  } else if (len > 40) {
    _ts = TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white);
  } else if (len > 30) {
    _ts = TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.white);
  } else {
    _ts = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white);
  }
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(FontAwesomeIcons.smileBeam, size: iconSize),
              ),
              new Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            /*
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
            */
          ],
        );
      });
}

Future<bool> showCustomGeneralDialog({BuildContext context, String message}) {
  //vibrate(FeedbackType.selection);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.info_outline, size: iconSize),
              ),
              new Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Sí'),
              onPressed: () {
                //return false;
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                //return true;
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      });
}

Future<bool> showDeleteDialog({BuildContext context, String message}) {
  //vibrate(FeedbackType.warning);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.delete, size: iconSize),
              ),
              new Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Sí'),
              onPressed: () {
                //return false;
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                //return true;
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      });
}

Future<bool> showMailExistDialog({BuildContext context, String message}) {
  //vibrate(FeedbackType.selection);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(FontAwesomeIcons.laughWink, size: iconSize),
              ),
              new Text(message),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'No',
              ),
              onPressed: () {
                //return false;
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: new Text('Sí'),
              onPressed: () {
                //return true;
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
}

Future<bool> saveMatchDialog({BuildContext context, String message, String date, int goalsA, int goalsB}) {
  //vibrate(FeedbackType.warning);
  const TextStyle _tsl = TextStyle(fontSize: 12.0, color: Colors.white70);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(message),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Text(date, style: _tsl),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Equipo ', style: _tsl),
                      Text('Claro', style: _tsl),
                      Text(goalsA.toString()),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Equipo', style: _tsl),
                      Text('Oscuro', style: _tsl),
                      Text(goalsB.toString()),
                    ],
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('No'),
              onPressed: () {
                //return false;
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: new Text('Yes'),
              onPressed: () {
                //return true;
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
}

showSnackBarSave({BuildContext context, String msg = 'Espere... actualizando...'}) {
  // vibrate(FeedbackType.warning);

  try {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      key: Key('showSnackBar' + msg),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
          ),
          new Text(msg),
        ],
      ),
      duration: Duration(seconds: 20),
    ));
  } catch (onError) {
    print('onError ' + onError.toString());
  }
}

Future<bool> showSnackBarResult({BuildContext context}) async {
  try {
    Scaffold.of(context).hideCurrentSnackBar();

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Datos actualizados.'),
      duration: Duration(seconds: 4),
      action: new SnackBarAction(
          label: 'Ok',
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
            return true;
          }),
    ));
  } catch (onError) {
    print('onError ' + onError.toString());
  }
}

Future<bool> showSnackBarError({BuildContext context, String message}) async {
  TextStyle _ts;
  int len = message.length;
  if (len > 50) {
    _ts = TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.white);
  } else if (len > 40) {
    _ts = TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.white);
  } else if (len > 30) {
    _ts = TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white);
  } else {
    _ts = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white);
  }
  try {
    Scaffold.of(context).hideCurrentSnackBar();

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Icon(FontAwesomeIcons.flushed, size: iconSize),
          ),
          new Text(message, style: _ts),
        ],
      ),
      // duration: Duration(seconds: 20),
      action: new SnackBarAction(
          label: 'Ok',
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
            return true;
          }),
    ));
  } catch (onError) {
    print('onError ' + onError.toString());
    return true;
  }
}
