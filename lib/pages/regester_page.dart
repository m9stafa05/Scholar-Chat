import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/widgets/custam_form_textfield.dart';
import 'package:scholar_chat/widgets/custom_button.dart';

// ignore: must_be_immutable
class RegesterPage extends StatefulWidget {
  const RegesterPage({super.key});
  static String id = 'RegesterPage';

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: kPrimaryColor,
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Scholar Caht',
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
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image(
                  image: AssetImage('assets/images/scholar.png'),
                  height: 200,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'REGESTER',
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
                        await RegesterUser();
                        ShowSnackBar(
                          // ignore: use_build_context_synchronously
                          context,
                          message: 'Successfully regestered',
                          color: Colors.green,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          ShowSnackBar(
                            // ignore: use_build_context_synchronously
                            context,
                            message: 'This email is already exists',
                          );
                        } else if (e.code == 'weak-password') {
                          ShowSnackBar(
                            // ignore: use_build_context_synchronously
                            context,
                            message:
                                'Your password is too weak, at least 8 characters',
                          );
                        } else if (e.code == 'invalid-email') {
                          ShowSnackBar(
                            // ignore: use_build_context_synchronously
                            context,
                            message: 'Please enter a valid email',
                          );
                        }
                      } catch (e) {
                        ShowSnackBar(
                          // ignore: use_build_context_synchronously
                          context,
                          message: 'opps! something went wrong',
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {}
                  },
                  text: 'REGESTER',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        ' LOGIN',
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

  // ignore: non_constant_identifier_names
  Future<void> RegesterUser() async {
    final auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email ?? 'Enter your email',
      password: password ?? 'Enter your password',
    );
  }
}
