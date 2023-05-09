import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/signup_page_controller.dart';
import '../../router/router.dart';
import '../../widgets/my_text_form_f.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupPageController>(
      create: (context) => SignupPageController(),
      builder: (context, _) {
        var watch = context.watch<SignupPageController>();
        var read = context.read<SignupPageController>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Signup'.toUpperCase()),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: !watch.isLoading
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: watch.formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/cinema_logo.png'),
                        ),
                        MyTextFormF(
                          hintText: 'Name',
                          icon: Icons.person,
                          controller: watch.nameController,
                          validation: read.nameValidation,
                        ),
                        const SizedBox(height: 16.0),
                        MyTextFormF(
                          hintText: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          controller: watch.emailController,
                          validation: read.emailValidation,
                        ),
                        const SizedBox(height: 16.0),
                        MyTextFormF(
                          hintText: 'Phone',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          controller: watch.phoneController,
                          validation: read.phoneValidation,
                        ),
                        const SizedBox(height: 16.0),
                        MyTextFormF(
                          isPassword: true,
                          hintText: 'Password',
                          icon: Icons.lock,
                          controller: watch.passwordController,
                          validation: read.passwordValidation,
                        ),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: () {
                            read.signup(Navigator.of(context));
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            fixedSize: const Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Text('SIGN UP'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRouter.loginPage,
                            );
                          },
                          child: Text(
                            'I already have an account'.toUpperCase(),
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
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
