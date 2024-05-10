import 'package:flutter/material.dart';
import 'package:checkpoint_/cadastro.dart';
import 'package:checkpoint_/cadastro_ponto.dart';
import 'package:checkpoint_/senha_esquecida.dart';

class LoginPage extends StatelessWidget {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('../assets/images/logo_no_background.png'), 
            const SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: emailController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              controller: senhaController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => logar(context, emailController.text, senhaController.text),
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, 
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8) 
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                );
              },
              child: const Text('Esqueci a senha'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Cadastrar'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logar(BuildContext context, String email, String senha) {
    
    if (email == 'eu@gmail.com' && senha == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TimeRecordPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Dados inválidos'),
            content: const Text('Usuário e/ou senha incorreto(a)'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
