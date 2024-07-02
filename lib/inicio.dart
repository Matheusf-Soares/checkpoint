import 'package:checkpoint_/cadastro.dart';
import 'package:checkpoint_/perfil.dart';
import 'package:flutter/material.dart';

import 'cadastro_ponto.dart';
import 'models/usuario.dart';

class InicioPage extends StatefulWidget {
  final Usuario usuario;

  InicioPage({required this.usuario});

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int indexAtivo = 0;

  final List<BottomNavigationBarItem> listaItens = [
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time),
      label: 'Registro',
    ),
  ];

  final List<Widget> listaPaginas = [ProfilePage(), TimeRecordPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaPaginas[indexAtivo],
      bottomNavigationBar: BottomNavigationBar(
        items: listaItens,
        selectedItemColor: Colors.purple,
        currentIndex: indexAtivo,
        onTap: (index) {
          setState(() {
            indexAtivo = index;
          });
        },
      ),
    );
  }
}
