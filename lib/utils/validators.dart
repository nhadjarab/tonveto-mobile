String? validatePassword(String? value, String isEmptyText, String errorText) {
  RegExp regex = RegExp(r'^(?=.*?[0-9]).{7,}$');
  if (value == null || value.isEmpty) {
    return errorText;
  } else {
    if (!regex.hasMatch(value)) {
      return errorText;
    } else {
      return null;
    }
  }
}

String? validateEmail(String? value, String isEmptyText, String errorText) {
  RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty) {
    return isEmptyText;
  } else {
    if (!regex.hasMatch(value)) {
      return errorText;
    } else {
      return null;
    }
  }
}

String? validateName(String? value, String isEmptyText, String errorText) {
  RegExp regex = RegExp(r"^[a-zA-Z]*$");
  if (value == null || value.isEmpty || value.length < 3) {
    return isEmptyText;
  } else {
    if (!regex.hasMatch(value)) {
      return errorText;
    } else {
      return null;
    }
  }
}
