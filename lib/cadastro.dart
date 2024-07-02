import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/usuario.dart';
import 'services/usuario.service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorConfirmarEmail = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final TextEditingController controladorConfirmarSenha = TextEditingController();
  final UsuarioService usuarioService = UsuarioService();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuário"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
      try {
        Usuario novoUsuario = Usuario(
          id: null, // Pode ser null na criação
          email: controladorEmail.text,
          senha: controladorSenha.text,
          name: '',
          estado: '',
          idade: null,
        );

        final response = await usuarioService.addUsuario(novoUsuario);

        if (response['message'] == 'Usuário criado') {
          final preferencias = await SharedPreferences.getInstance();
          preferencias.setString('email', controladorEmail.text);
          preferencias.setString('senha', controladorSenha.text);

          print(controladorEmail.text);
          print(controladorSenha.text);

          _showSuccess(context, 'Usuário criado com sucesso');
        } else {
          _showError(context, response['message']);
        }
      } catch (e) {
        _showError(context, e.toString());
      }
    } else {
      _showError(context, 'Os campos de email e/ou senha não correspondem');
    }
  }

  void _showSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Fecha a tela de cadastro e retorna para a tela anterior
              },
            ),
          ],
        );
      },
    );
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
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
