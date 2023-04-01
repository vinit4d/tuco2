import 'package:get/get.dart';

class ValidatorAuth {
  static email(String value) {
    String? message;

    if (value.trim().isEmpty) message = 'Please enter email';

    if (value.trim().isNotEmpty && !GetUtils.isEmail(value)) {
      message = 'Please enter valid email';
    }
    return message;
  }

  static password(String value) {
    String? message;

    RegExp passwordPattern = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

    if (value.trim().isEmpty) {
      message = 'Please enter password';
    } else {
      if (!passwordPattern.hasMatch(value)) {
        message =
            'Please enter One Uppercase, Lowercase, Number and Special character \nPassword must have min 8 Characters';
        // 'Password must have at least 8 characters \nPassword must have one uppercase \nPassword must have one lowercase  \nPassword must have one number \nPassword must have one special character';
      }

      if (value.length < 8) {
        'Please enter One Uppercase, Lowercase, Number and Special character \nPassword must have min 8 Characters';
        // 'Password must have at least 8 characters \nPassword must have one uppercase \nPassword must have one lowercase  \nPassword must have one number \nPassword must have one special character';
      }
    }

    return message;
  }

  static firstName(String value) {
    String? message;
    if (value.trim().isEmpty) {
      message = 'First name must enter';
    } else if (value.trim().length < 2) {
      message = 'First name must be greater than 2 characters';
    }
    return message;
  }

  static lastName(String value) {
    String? message;
    if (value.trim().isEmpty) {
      message = 'Last name must enter';
    } else if (value.trim().length < 2) {
      message = 'Last name must be greater than 2 characters';
    }
    return message;
  }

  static phoneNumber(String value) {
    String? message;
    if (value.trim().isEmpty) message = 'Phone number must enter';
    if (value.length < 10) {
      message = 'Phone number digits must be between in 10 - 15';
    }
    if (value.length > 15) {
      message = 'Phone number digits must be between in 10 - 15';
    }
    return message;
  }

  static messageDescription(String value) {
    String? message;
    if (value.trim().isEmpty) {
      message = 'First enter message';
    } else if (value.trim().length < 2) {
      message = 'Message must be greater than 2 characters';
    }
    return message;
  }
}

class ValidatorTransportation {
  static isValid(String errorMessage, String value) {
    String? message;
    if (value.trim().isEmpty) message = errorMessage;
    return message;
  }

  static isValidCompare(String errorMessage, String value) {
    String? message;
    if (value.toLowerCase() == errorMessage.toLowerCase()) return message;
  }
}

 checkEmptyValidation(String value,String? message){
    if (value.trim().isEmpty) {
      message = message;
    } 
    return message;
  
}

