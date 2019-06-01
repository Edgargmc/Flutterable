import 'package:hack19/models/parametros.dart';
import 'package:intl/intl.dart';

String validateName(String value) {
  if (value == null || value.isEmpty) return 'Nombre completo es requerido.';
  value = value.trim();
  // final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
  if (value.length < 4) return 'Debe ser mayor a 3 caracteres.';
  if (value.length > controllerNameCount) return 'No puede superara los ' + controllerNameCount.toString() + ' caracteres.';

  //if (!nameExp.hasMatch(value)) return 'Por favor ingrese caracteres no numéricos';
  return null;
}
/*
String validateNameProvider(String value) {
  value = value.trim();
  if (value.isEmpty) return null;
  // final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
  if (value.length < 4) return 'Nombre cancha debe ser mayor a 3 caracteres';
  if (value.length > 14) return 'Nombre cancha no puede superara los 14 caracteres';

  //if (!nameExp.hasMatch(value)) return 'Por favor ingrese caracteres no numéricos';
  return null;
}
*/

/*
   String _validatePhoneNumber(String value) {

    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '(###) ###-#### - Enter a US phone number.';
    return null;
  }
  */
String validateMessage(String value) {
  if (value == null || value.isEmpty) return 'Mensaje es requerido.';
  value = value.trim();

  if (value.length < 10) return 'Debe ser mayor a 10 caracteres.';
  if (value.length > 500) return 'No puede superar los 500 caracteres.';

  return null;
}

String validateMail(String value) {
  if (value == null || value.isEmpty) return 'Mail es requerido.';
  value = value.trim();

  if (value.length < 8) return 'Debe ser mayor a 8 caracteres.';
  if (value.length > controllerMailCount) return 'No puede superar los ' + controllerMailCount.toString() + ' caracteres.';

  if (!isValidEmail(value)) return 'Por favor ingrese mail válido.';
  return null;
}

String validatePassword(String value) {
  if (value == null || value.isEmpty) return 'Password es requerido.';
  value = value.trim();
  if (value.length < 6) return 'Debe ser mayor a 5 caracteres.';
  if (value.length > controllerPassWordCount) return 'No puede superar los ' + controllerPassWordCount.toString() + ' caracteres.';

  return null;
}

String validatePassword2(String value, String value2) {
  String res = validatePassword(value2);
  if (res != null) {
    if (value != value2) {
      return 'Las claves no son iguales.';
    }
  }
  return null;
}

String validatePhone(String value) {
  if (value == null || value.isEmpty) return null;
  value = value.trim();

  if (value.length < 8) return 'Debe ser mayor a 8 caracteres.';
  if (value.length > controllerPhoneCount) return 'No puede superar los ' + controllerPhoneCount.toString() + ' caracteres.';

  //if (!isValidPhoneNumber(value))
  // return 'Por favor ingrese numero válido';
  return null;
}

bool isValidEmail(String value) {
  if (value == null || value.isEmpty) return null;
  value = value.trim();
  final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return regex.hasMatch(value);
}

bool isValidPhoneNumber(String value) {
  if (value == null || value.isEmpty) return null;
  final RegExp regex = new RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
  return regex.hasMatch(value);
}

DateTime convertToDate(String input) {
  try {
    var d = new DateFormat.yMd().parseStrict(input);
    return d;
  } catch (e) {
    return null;
  }
}

bool isValidDob(String dob) {
  if (dob.isEmpty) return true;
  var d = convertToDate(dob);
  return d != null && d.isBefore(new DateTime.now());
}
