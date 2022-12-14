import 'package:chat/view/chat_page.dart';
import 'package:chat/view/create_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginUserEmail = '';
  String loginUserPassword = '';
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
        
      ),
      body: Column(
        children: [
          const SizedBox(height: 32,),
          TextFormField(
            decoration: const InputDecoration(labelText: 'メールアドレス'),
            onChanged: (String value){
              setState(() {
                loginUserEmail = value;
              });
            },
          ),
          const SizedBox(height: 8,),
          TextFormField(
            decoration: const InputDecoration(labelText: 'パスワード'),
            obscureText: true,
            onChanged: (String value){
              setState(() {
                loginUserPassword = value;
              });
            },
          ),
          const SizedBox(height: 8,),
          ElevatedButton(
              onPressed: () async {
                try {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final UserCredential result =
                      await auth.signInWithEmailAndPassword(
                        email: loginUserEmail,
                        password: loginUserPassword
                      );
                  final User user = result.user!;
                  setState(() {
                    infoText = 'ログインOK：${user.email}';
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatPage(user: user)));
                }
                on FirebaseAuthException catch  (e){
                  setState(() {
                    infoText = "ログインNG：${e.toString()}";
                  });
                }
              },
              child: const Text('ログイン')),
          const SizedBox(height: 8),
          Text(infoText),
          const SizedBox(height: 8,),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(text: 'アカウントを作成していない方は'),
                TextSpan(text: 'こちら',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
