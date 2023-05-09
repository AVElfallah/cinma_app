import 'package:cinma_app/controllers/login_page_controller.dart';
import 'package:cinma_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_text_form_f.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageController>(
      create: (context) => LoginPageController(),
      builder: (context, _) {
        var watch = context.watch<LoginPageController>();
        var read = context.read<LoginPageController>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Login'.toUpperCase()),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: !watch.isLoading
              ? Center(
                  child: Form(
                    key: watch.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Image.asset('assets/images/cinema_logo.png'),
                          ),
                          MyTextFormF(
                            hintText: 'Email',
                            icon: Icons.email,
                            controller: watch.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validation: read.emailValidation,
                          ),
                          const SizedBox(height: 26),
                          MyTextFormF(
                            hintText: 'Password',
                            icon: Icons.lock,
                            isPassword: true,
                            controller: watch.passwordController,
                          ),
                          const SizedBox(height: 56),
                          ElevatedButton(
                            onPressed: () {
                              read.login(Navigator.of(context));
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              fixedSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text('Login'.toUpperCase()),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                AppRouter.signupPage,
                              );
                            },
                            child: Text(
                              'I Don\'t Have An Account :('.toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
