import 'package:chat/view/add_post_page.dart';
import 'package:chat/view/create_account_page.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: [
          IconButton(onPressed: () async{
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage()));
          },
              icon: const Icon(Icons.close))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage()));
        },
        child: Icon(Icons.add),

      ),
    );
  }
}
