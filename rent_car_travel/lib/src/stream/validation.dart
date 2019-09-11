class Validation {
  static String validatePass(String password) {
    if (password == null) {
      return "Password Invalid.";
    }
    if (password.length <= 6) {
      return "Password Require minimum 6 character.";
    }
    return null;
  }
  static String validateUsername(String username){
    if(username == null){
      return "Username Invalid";
    }
    return null;
  }

}