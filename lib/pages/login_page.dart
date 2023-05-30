import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s/pages/register_page.dart';
import '../helper/show_snak_bar.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? email, password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Image.asset(
                'assets/images/scholar.png',
                height: 150,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFormTextField(
                hintField: 'Email',
                onChanged: (data) {
                  email = data;
                },
              ),
              CustomFormTextField(
                hintField: 'Password',
                onChanged: (data) {
                  password = data;
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await loginUser();
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: email);
                    } on FirebaseException catch (ex) {
                      if (ex.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email');
                      } else if (ex.code == 'wrong-password') {
                        showSnackBar(
                            context, 'Wrong password provided for that user');
                      } else {
                        showSnackBar(
                            context, 'Please enter the email correctly');
                      }
                    }
                  } else {}

                  isLoading = false;
                  setState(() {});
                },
                text: 'LOGIN',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'don\'t have an account? ',
                    style: TextStyle(
                      color: Color(0xffC7EDE6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
