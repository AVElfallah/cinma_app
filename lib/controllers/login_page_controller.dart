import 'package:cinma_app/api/firebase_login.dart';
import 'package:cinma_app/router/router.dart';
import 'package:flutter/widgets.dart';

class LoginPageController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? emailValidation(val) {
    if (emailController.text.contains('@')) {
      return null;
    } else {
      return 'Invalid Email';
    }
  }

  String? passwordValidation(val) {
    if (passwordController.text.isNotEmpty) {
      return null;
    } else {
      return 'Invalid Password';
    }
  }

  void login(NavigatorState state) async {
    isLoading = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      var back = await FirebaseLogin.i
          .login(emailController.text, passwordController.text);
      if (back.runtimeType == bool) {
        if (back) {
          state.pushNamedAndRemoveUntil(
              AppRouter.landingPage, (route) => false);
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
