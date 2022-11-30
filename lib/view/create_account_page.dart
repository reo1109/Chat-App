import 'package:chat/view/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String newUserEmail = "";
  String newUserPassword = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規作成'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                }
              ),
              const SizedBox(height: 8,),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード(６文字以上)'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8,),
              ElevatedButton(
                  onPressed: () async{
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result = await auth.createUserWithEmailAndPassword(
                          email: newUserEmail,
                          password: newUserPassword
                      );
                      final User user = result.user!;
                      setState(() {
                        infoText = '登録OK:${user.email}';
                      });
                    }
                    catch (e) {
                      setState(() {
                        infoText = '登録NG:${e.toString()}';
                      });
                    }
                  },
                  child: const Text('ユーザー登録')
              ),
              const SizedBox(height: 8,),
              Text(infoText),
            ],
          ),
        ),
      )
    );
  }
}
