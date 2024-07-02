import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorConfirmarEmail =
      TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final TextEditingController controladorConfirmarSenha =
      TextEditingController();

  RegisterPage({Key? key}) : super(key: key) {
  }

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
              controller: controladorEmail,
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Confirme o Email',
                border: OutlineInputBorder(),
              ),
              controller: controladorConfirmarEmail,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              controller: controladorSenha,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirme a senha',
                border: OutlineInputBorder(),
              ),
              controller: controladorConfirmarSenha,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => registrar(context),
              child: const Text('Cadastrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }

  void registrar(BuildContext context) async {
    if (controladorEmail.text == controladorConfirmarEmail.text &&
        controladorSenha.text == controladorConfirmarSenha.text) {
      final preferencias = await SharedPreferences.getInstance();
      preferencias.setString('email', controladorEmail.text);
      preferencias.setString('senha', controladorSenha.text);

      print(controladorEmail.text);
      print(controladorSenha.text);

      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Dados inválidos'),
            content:
                const Text('Os campos de email e/ou senha não correspondem'),
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