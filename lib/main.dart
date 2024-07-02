import 'package:checkpoint_/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'models.dart'; // Adicionado
import 'api_service.dart'; // Adicionado

class TelaTemporaria extends StatefulWidget {
  const TelaTemporaria({Key? key}) : super(key: key);

  @override
  _TelaTemporariaState createState() => _TelaTemporariaState();
}

class _TelaTemporariaState extends State<TelaTemporaria> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('../assets/images/logo_no_background.png'),
              const SizedBox(height: 24),
              const Text(
                "CheckPoint",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("MEU APP - LOGIN"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necessário para inicialização assíncrona
  final apiService = ApiService();

  // Exemplo de uso para UsuarioParcial
  final usuarioParcial = UsuarioParcial(email: 'exemplo@email.com', senha: '123456');
  final dataParcial = usuarioParcial.toMap();

  // Chamada da API para adicionar um novo usuário (parcial)
  final responseParcial = await apiService.post(dataParcial);
  print(responseParcial);

  // Exemplo de uso para Usuario
  final usuario = Usuario(
    id: 1,
    name: 'John Doe',
    estado: 'SP',
    idade: 30,
    email: 'exemplo@email.com',
    senha: '123456',
  );
  final dataCompleto = usuario.toMap();

  // Chamada da API para adicionar um novo usuário (completo)
  final responseCompleto = await apiService.post(dataCompleto);
  print(responseCompleto);

  runApp(const MaterialApp(
    home: TelaTemporaria(),
    debugShowCheckedModeBanner: false,
  ));
}