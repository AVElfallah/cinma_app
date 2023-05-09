import 'package:cinma_app/api/firebase_signup.dart';
import 'package:cinma_app/router/router.dart';
import 'package:flutter/material.dart';

class SignupPageController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  //SECTION - Validation
  String? emailValidation(val) {
    if (emailController.text.contains('@')) {
      return null;
    } else {
      return 'Invalid Email';
    }
  }

  String? passwordValidation(val) {
    if (passwordController.text.isNotEmpty ||
        passwordController.text.length > 6) {
      return null;
    } else {
      return 'Invalid Password';
    }
  }

  String? phoneValidation(val) {
    if (phoneController.text.isNotEmpty || phoneController.text.length > 12) {
      return null;
    } else {
      return 'Invalid Phone';
    }
  }

  String? nameValidation(val) {
    if (nameController.text.isNotEmpty || nameController.text.length > 3) {
      return null;
    } else {
      return 'Invalid Name';
    }
  }

  //SECTION - method
  void signup(NavigatorState state) async {
    isLoading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      bool isSigned = await FirebaseSignup.i.signup(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
      );
      if (isSigned) {
        state.pushNamedAndRemoveUntil(AppRouter.landingPage, (route) => false);
      } else {
        debugPrint('Error');
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
