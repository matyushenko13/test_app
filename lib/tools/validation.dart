class Validation{
  static bool latitude(String value) {
    Pattern pattern =
        r'^(\+|-)?((\d((\.)|\.\d{1,6})?)|(0*?[0-8]\d((\.)|\.\d{1,6})?)|(0*?90((\.)|\.0{1,6})?))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  static bool longitude(String value) {
    Pattern pattern =
        r'^(\+|-)?((\d((\.)|\.\d{1,6})?)|(0*?\d\d((\.)|\.\d{1,6})?)|(0*?1[0-7]\d((\.)|\.\d{1,6})?)|(0*?180((\.)|\.0{1,6})?))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}