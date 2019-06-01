import 'dart:io';
import 'dart:async';

Future<bool> _initConnectivityGoogle() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');

      return true;
    }
  } on SocketException catch (_) {
    print('not connected');

    return false;
  }
}

const String isConnectivityError = 'Upss, necesita conexión de red.';

Future<bool> isConnectivity() async {
  var result = false;
  result = await _initConnectivityGoogle();
  /*
  if (result == false) {
    await new Future.delayed(new Duration(milliseconds: 500), () async {
      result = await _initConnectivityGoogle();
    });
  }
  if (result == false) {
    await new Future.delayed(new Duration(milliseconds: 500), () async {
      result = await _initConnectivityGoogle();
    });
  }
  if (result == false) {
    await new Future.delayed(new Duration(milliseconds: 500), () async {
      result = await _initConnectivityGoogle();
    });
  }
  */

  return result;
}
