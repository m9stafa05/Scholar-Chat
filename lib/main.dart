import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/pages/regester_page.dart';

// flutter build web --release && firebase init hosting && firebase deploy --only hosting -m 'V 1.0.0'
// firebase deploy --only hosting -m ' V 1.0.1'
//flutter build web --release && firebase deploy --only hosting -m 'V 1.0.1'
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegesterPage.id: (context) => RegesterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
    );
  }
}
