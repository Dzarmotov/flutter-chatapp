import 'package:chatinfirebase/components/components.dart';
import 'package:chatinfirebase/pages/pages.dart';
import 'package:chatinfirebase/services/services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        centerTitle: true,
        title: Text('Home'),),
      drawer: MyDrawer(),
      body: _UsersList(),
    );
  }

  Widget _UsersList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Text('Ошибка');
            }
            
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            
            return ListView(
              children: snapshot.data!.map<Widget>((userData) => _UsersListItem(userData, context)).toList()
            );
            
        });
  }

  Widget _UsersListItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(text: userData['email'], onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(receiverEmail: userData['email'], receiverID: userData['uid'],)));
      });
    } else {
      return Container();
    }
  }

}
