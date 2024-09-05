import 'package:chatinfirebase/services/services.dart';
import 'package:chatinfirebase/components/components.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async{
    final authService = AuthService();

    try{
      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    }catch(e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text(e.toString()),);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50,),

            Text('Добро пожаловать', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 25),),

            const SizedBox(height: 50,),

            MyTextfield(
              controller: _emailController,
              obsureText: false,
              hintText: 'Email',
            ),
            const SizedBox(height: 10,),
            MyTextfield(
              controller: _passwordController,
              obsureText: true,
              hintText: 'Password',
            ),

            const SizedBox(height: 25,),

            MyButton(
              text: 'Войти',
              onTap: () => login(context),
            ),

            const SizedBox(height: 25,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Нет аккаунта?", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                SizedBox(width: 5,),
                GestureDetector(
                    onTap: onTap,
                    child: Text("Зарегистрироваться", style: TextStyle(fontWeight: FontWeight.bold),)),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
