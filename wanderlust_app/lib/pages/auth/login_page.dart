import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust_app/custom_theme.dart';
import 'package:wanderlust_app/services/auth_service.dart';
import 'package:wanderlust_app/services/database_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MyLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FormWidget());
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService fbAuthService = AuthService();
  final DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CustomTheme.lightTheme.colorScheme.primary,
                      CustomTheme.lightTheme.colorScheme.primaryVariant,
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        top: 85, left: 30, right: 30.0, bottom: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                              controller: emailController,
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                hintText: 'Email',
                                contentPadding: const EdgeInsets.all(20),
                                prefixIcon: const Icon(Icons.email_outlined),
                                filled: true,
                                fillColor: const Color(0xffF4edf8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              validator: (value) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = RegExp(pattern.toString());
                                if (!regex.hasMatch(value.toString())) {
                                  return 'Enter a valid email';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {}),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                contentPadding: const EdgeInsets.all(20),
                                prefixIcon:
                                    const Icon(Icons.lock_outline_rounded),
                                filled: true,
                                fillColor: const Color(0xffF4edf8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              validator: (value) {},
                              onSaved: (value) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: CustomTheme
                                      .lightTheme.colorScheme.secondary,
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    fbAuthService
                                        .signInEmailPassword(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then(
                                          (value) => {
                                            if (value != 'Signed In')
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      value.toString(),
                                                    ),
                                                  ),
                                                ),
                                              }
                                            else
                                              {
                                                if (FirebaseAuth.instance
                                                    .currentUser!.emailVerified)
                                                  {
                                                    Navigator.pushNamed(context,
                                                        '/account_verified')
                                                  }
                                                else
                                                  {
                                                    Navigator.pushNamed(context,
                                                        '/login_successful')
                                                  }
                                              }
                                          },
                                        );
                                  }
                                },
                                child: const Text("Login"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextButton(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: CustomTheme
                                      .lightTheme.colorScheme.secondaryVariant,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/reset_password');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 55),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                              MaterialCommunityIcons.facebook),
                                        ),
                                        Text('Sign In'),
                                      ],
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                            MaterialCommunityIcons.google_plus),
                                      ),
                                      Text('Sign In'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Dont have an account?',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: CustomTheme.lightTheme.colorScheme
                                        .secondaryVariant,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/create_account');
                                  },
                                  child: const Text("Sign Up"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
