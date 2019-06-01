String capitalizeName(String input) {
  if (input == null) {
    return '';
  }
  if (input.length == 0) {
    return input;
  }
  String result = '';
  List<String> ar = input.split(' ');

  ar.forEach((value) {
    value = value.trim();
    if (value != '') {
      if (value.length > 0) {
        result = result + value[0].toUpperCase() + value.substring(1).toLowerCase() + ' ';
      } else {
        result = result + value[0].toUpperCase();
      }
    }
  });

  return result.trim();
}

String capitalizeMail(String input) {
  if (input == null) {
    return '';
  }
  if (input.length == 0) {
    return input;
  }
  String result = input.toLowerCase();

  return result.trim();
}

String capitalize(String input) {
  if (input == null) {
    return '';
  }
  if (input.length == 0) {
    return input;
  }
  String result = input;

  return result.trim();
}
