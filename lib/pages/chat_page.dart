import 'package:chatinfirebase/components/components.dart';
import 'package:chatinfirebase/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverID;
  final String receiverEmail;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  FocusNode myfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myfocusNode.addListener(() {
      if(myfocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myfocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }


  void sendMessages() async {
    if(_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);

      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _MessageList()),
          _UserInput()
        ],
      ),
    );
  }

  Widget _MessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderId),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(child: Text('Ошибка'),);
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs.map((doc) => _MessageItem(doc)).toList(),
          );
        }
    );
  }

  Widget _MessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser,));
  }

  Widget _UserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
                focusNode: myfocusNode,
                obsureText: false,
                hintText: 'Введите сообщение',
                controller: _messageController,
              ) ,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: sendMessages, icon: Icon(Icons.send)),
          )
        ],
      ),
    );
  }
}
