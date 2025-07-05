import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/widgets/custom_form_text_field.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import '../controllers/auth_cubit/auth_cubit.dart';
import '../controllers/chat_cubit/cubit/chat_cubit.dart';

// m9stafa05@gmail.com
// mer@gmail.com
//12345678
// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const String id = 'LoginPage';
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
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              isLoading = true;
            } else if (state is LoginSuccess) {
              BlocProvider.of<ChatCubit>(context).getMessages();
              isLoading = false;
              Navigator.pushNamed(
                context,
                ChatPage.id,
                arguments: email,
              );
            } else if (state is LoginFailure) {
              isLoading = false;
              ShowSnackBar(context, message: state.errorMessage);
            }
          },
          builder:
              (context, state) => ModalProgressHUD(
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
                      CustomFormTextField(
                        onChange: (data) {
                          email = data;
                        },
                        labelText: "Enter your email",
                        hintText: 'Your email',
                      ),
                      SizedBox(height: 20),
                      // Password TextField
                      CustomFormTextField(
                        onChange: (data) {
                          password = data;
                        },
                        isPassword: true,
                        labelText: 'Enter your password',
                        hintText: 'At least 8 characters',
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(
                              context,
                            ).logInUser(
                              email: email!,
                              password: password!,
                            );
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
                              Navigator.pushNamed(
                                context,
                                RegisterPage.id,
                              );
                            },
                            child: Text(
                              ' REGISTER',
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
      ),
    );
  }
}
