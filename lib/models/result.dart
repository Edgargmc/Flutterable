import 'package:hack19/models/user.dart';
import 'package:hack19/utils/package_info.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';

class Result {
  bool status;
  String message;
  dynamic data;
  Result({this.status, this.message, this.data});

  @override
  String toString() {
    return 'Result{status: $status,message: $message}';
  }
}

/*
const String logError = 'logError';
const String logInfo = 'logInfo';
const String logAlert = 'logAlert';
const String logContact = 'logContact';
const String logAcceptTermIn = 'logAcceptTermIn';
const String logAcceptTermOut = 'logAcceptTermOut';
const String logAcceptPerfilPublic = 'logAcceptPerfilPublic';
const String logAcceptNotifications = 'logAcceptNotifications';
*/
enum ILogType { logError, logInfo, logAlert, logContact, logHelp, logAcceptTerm, logAcceptPerfilPublic, logAcceptNotifications, logRevokeTerm }

class ErrorCallback {
  final String classFunction;
  final String message;
  final ILogType logType;
  ErrorCallback(this.classFunction, this.message, this.logType);

  @override
  String toString() {
    return 'ErrorCallback{classFunction: $classFunction, message: $message, logType: $logType}';
  }
}

class Log {
  ILogType logtype;
  String type;
  User user;
  // UserEntity userEntity;
  // UserProfile userProfile;
  DateTime time; //firebase.firestore.FieldValue.serverTimestamp();
  String message;
  String language;
  String appVersion;
  dynamic deviceInfo;
  PackageInfo packageInfo;
  String acceptTerms;

  @override
  String toString() {
    return 'Log{logtype: $logtype, type: $type, userBasic: $user,   time: $time, message: $message, language: $language, appVersion: $appVersion, deviceInfo: $deviceInfo, packageInfo: $packageInfo, accepTerms: $acceptTerms}';
  }

  Log({@required this.logtype, @required this.message}) {
    this.type = this.logtype.toString().split('.')[1];
  }

  Map<String, Object> toJson() {
    if (logtype == ILogType.logError) {
      return {
        "type": type,
        "userBasic": user.toJson(),
        //    "userProfile": userProfile.toJson(),
        "time": time,
        "message": message + ' DEVICEINFO:' + deviceInfo.toString() + ' PACKAGEINFO:' + packageInfoToString(packageInfo).toString(),
        "language": language ?? 'none',
        "appVersion": appVersion,
        "deviceInfo": deviceInfo,
        // "packageInfo": packageInfo,
        "accepTerms": acceptTerms ?? 'none',
      };
    } else {
      return {
        "type": type,
        "userBasic": user.toJson(),
        "time": time,
        "message": message,
        "appVersion": appVersion ?? 'none',
        "accepTerms": acceptTerms ?? 'none',
      };
    }
  }
}

/* **************************************** */
class ResponseFunction {
  bool status;
  String message;
  dynamic data;
  ResponseFunction({this.status, this.message, this.data});

  factory ResponseFunction.fromJson(json) {
    try {
      if (json != null) {
        return ResponseFunction(
          status: json["status"],
          message: json["message"],
          data: json["data"] != null ? json["data"] : null,
        );
      } else {
        return ResponseFunction(status: false, message: "Upss, error de red.\nIntente más tarde.");
      }
    } catch (err) {
      return ResponseFunction(status: false, message: "Upss, error de red.\nIntente más tarde.");
    }
  }
  Result toResult() {
    return Result(status: this.status, message: this.message, data: this.data);
  }
}
