import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/regester_page.dart';
import 'package:scholar_chat/widgets/custam_textfield.dart';
import 'package:scholar_chat/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: ListView(
          children: [
            Image(
              image: AssetImage(
                'assets/images/scholar.png',
              ),
              height: 200,
            ),
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
            CustamTextField(
              labelText: "Enter your email",
              hintText: 'Your email',
            ),
            SizedBox(height: 20),
            // Password TextField
            CustamTextField(
              labelText: 'Enter your password',
              hintText: 'At least 8 characters',
            ),
            SizedBox(height: 20),
            /* ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 10,
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 20),
              ),
            ), */
            CustomButton(text: 'LOGIN'),
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
                      RegesterPage.id,
                    );
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
    );
  }
}
