bool IsValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string == null || string.isEmpty || string == "") {
    print("false");
    return false;
  }

  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

bool IsValidEmail(String string) {
  // Null or empty string is invalid
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

String? Validatephone(String phone) {
  print("caled");
  if (!IsValidPhoneNumber(phone)) {
    print("44");
    return 'Invalid Phone Number';
  }
  return null;
}

String? validateEmail(String enteredEmail) {
  if (!IsValidEmail(enteredEmail)) {
    return 'Invalid Email';
  }
  return null;
}

String? LengthValidator(String text, int length) {
  if (!(text.length > length) && text.isNotEmpty) {
    return "Too Short Value";
  }
  return null;
}
