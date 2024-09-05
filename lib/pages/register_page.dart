import 'package:chatinfirebase/services/services.dart';
import 'package:chatinfirebase/components/components.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  void register(BuildContext context) async{
    final authService = AuthService();

    if(_passwordController.text == _confirmController.text) {
      try {
        await authService.signUpWithEmailAndPassword(
          _emailController.text,
          _passwordController.text
        );
      } catch (e) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text(e.toString()),
          );
        });
      }
    } else {
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          title: Text('Пароли не совпадают'),
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
          
              const SizedBox(height: 50,),
          
              Text('Давайте зарегистрируемся', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 25),),
          
              const SizedBox(height: 50,),
          
              MyTextfield(
                controller: _emailController,
                obsureText: false,
                hintText: 'Email',
              ),
          
              const SizedBox(height: 10,),
              MyTextfield(
                controller: _passwordController,
                obsureText: false,
                hintText: 'Password',
              ),
          
              const SizedBox(height: 10,),
          
              MyTextfield(
                controller: _confirmController,
                obsureText: false,
                hintText: 'Подтверждение пароля',
              ),
          
              const SizedBox(height: 25,),
          
              MyButton(
                text: 'Зарегистрироваться',
                onTap: () => register(context),
              ),
          
              const SizedBox(height: 25,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Есть аккаунт?", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  SizedBox(width: 5,),
                  GestureDetector(
                      onTap: onTap,
                      child: Text("Войти сейчас", style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              )
          
            ],
          ),
        ),
      ),
    );;
  }
}
