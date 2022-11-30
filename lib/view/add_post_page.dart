import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  final User user;

  const AddPostPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String messageText = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット投稿'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: '投稿メッセージ'),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onChanged: (String value){
                setState(() {
                  messageText = value;
                });
              },
            ),
            const SizedBox(height: 8,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('投稿'),
                onPressed: () async {
                  final date = DateTime.now().toLocal().toIso8601String();
                  final email = widget.user.email;

                  await FirebaseFirestore.instance
                      .collection('posts')
                      .doc()
                      .set({
                    'text': messageText,
                    'email': email,
                    'date': date
                  });
                  Navigator.pop(context);
                },
              )
            )
          ],
        ),
      )
    );
  }
}
