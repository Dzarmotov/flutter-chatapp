import 'package:chatinfirebase/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:chatinfirebase/services/services.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logOut() {
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                    child: Icon(Icons.message, size: 40, color: color,),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    title: Text('H O M E', style: TextStyle(color: color),),
                    leading: Icon(Icons.home, color: color,),
                    onTap: () {
                    },
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('S E T T I N G S', style: TextStyle(color: color),),
                  leading: Icon(Icons.settings, color: color,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('L O G O U T', style: TextStyle(color: color),),
              leading: Icon(Icons.logout, color: color,),
              onTap: logOut,
            ),
          ),
        ],
      ),
    );
  }
}
