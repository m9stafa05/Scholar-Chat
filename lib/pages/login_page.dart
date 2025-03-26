import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/regester_page.dart';
import 'package:scholar_chat/widgets/custam_form_textfield.dart';
import 'package:scholar_chat/widgets/custom_button.dart';

// m9stafa05@gmail.com
// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            kTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
            ),
          ),
        ),
        backgroundColor: Color(0xff274460),
      ),
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image(image: AssetImage(kLogo), height: 200),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Email TextField
                CustamFormTextField(
                  onChange: (data) {
                    email = data;
                  },
                  labelText: "Enter your email",
                  hintText: 'Your email',
                ),
                SizedBox(height: 20),
                // Password TextField
                CustamFormTextField(
                  onChange: (data) {
                    password = data;
                  },
                  labelText: 'Enter your password',
                  hintText: 'At least 8 characters',
                ),
                SizedBox(height: 20),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await LogInUser();
                        ShowSnackBar(
                          context,
                          message: 'Successfully Logged in',
                          color: Colors.green,
                        );
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == 'user-not-found') {
                          ShowSnackBar(
                            context,
                            message: 'User not found',
                          );
                        } else if (e.code == 'wrong-password') {
                          ShowSnackBar(
                            context,
                            message: 'Wrong password',
                          );
                        } else if (e.code == 'invalid-email') {
                          ShowSnackBar(
                            context,
                            message: 'Please enter a valid email',
                          );
                        } else if (e.code == 'too-many-requests') {
                          ShowSnackBar(
                            context,
                            message:
                                'Too many requests. Please try again later.',
                          );
                        }
                      } catch (e) {
                        ShowSnackBar(
                          context,
                          message: 'Oops! Something went wrong',
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegesterPage.id);
                      },
                      child: Text(
                        ' REGESTER',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> LogInUser() async {
    final auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email ?? 'Enter your email',
      password: password ?? 'Enter your password',
    );
  }
}
