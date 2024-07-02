import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/usuario.dart';
import 'services/usuario.service.dart';
import 'inicio.dart';
import 'cadastro.dart';
import 'senha_esquecida.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final UsuarioService usuarioService = UsuarioService();

  @override
  void initState() {
    super.initState();
    _recuperaDados();
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
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              controller: controladorSenha,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () =>
                  logar(context, controladorEmail.text, controladorSenha.text),
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage()),
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
                  MaterialPageRoute(builder: (context) => RegisterPage()),
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

  void logar(BuildContext context, String email, String senha) async {
    UsuarioParcial usuarioParcial = UsuarioParcial(email: email, senha: senha);
    try {
      final response = await usuarioService.verificaUsuario(usuarioParcial);
      if (response['message'] == 'Usuário encontrado') {
        // Salvar dados do usuário nas preferências compartilhadas
        final preferencias = await SharedPreferences.getInstance();
        preferencias.setString('email', email);
        preferencias.setString('senha', senha);

        Usuario usuario = Usuario.fromJson(response['user']);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InicioPage(usuario: usuario),
          ),
        );
      } else {
        _showMessage(context, response['message']);
      }
    } catch (e) {
      _showMessage(context, 'Erro ao autenticar usuário: $e');
    }
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensagem'),
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

  Future<void> _recuperaDados() async {
    final preferencias = await SharedPreferences.getInstance();
    setState(() {
      controladorEmail.text = preferencias.getString('email') ?? '';
      controladorSenha.text = preferencias.getString('senha') ?? '';
    });
  }
}