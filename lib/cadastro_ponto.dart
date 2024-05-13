import 'package:checkpoint_/perfil.dart';
import 'package:flutter/material.dart';

class TimeRecordPage extends StatefulWidget {
  const TimeRecordPage({Key? key}) : super(key: key);

  @override
  _TimeRecordPageState createState() => _TimeRecordPageState();
}

class _TimeRecordPageState extends State<TimeRecordPage> {
  List<String> pontos = [];
  TextEditingController tempoController = TextEditingController();
  int indexSelecionado = 1;
  String selectedPonto = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Ponto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              'Bem-vindo(a)!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: tempoController,
              decoration: const InputDecoration(
                labelText: 'Cadastrar Ponto',
                hintText: '00:00:00',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: adicionarPonto,
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pontos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pontos[index]),
                    onTap: () {
                      setState(() {
                        selectedPonto = pontos[index];
                      });
                    },
                    tileColor: selectedPonto == pontos[index]
                        ? Colors.grey.withOpacity(0.5)
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.grey),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              color: Colors.purple,
            ),
            label: 'Registro',
          ),
        ],
        currentIndex: indexSelecionado,
        onTap: itemPressionado,
      ),
    );
  }

  void adicionarPonto() {
    if (tempoController.text.isNotEmpty) {
      setState(() {
        pontos.add("${DateTime.now().toString()} - ${tempoController.text}");
        tempoController.clear();
      });
    }
  }

  void itemPressionado(int index) {
    setState(() {
      indexSelecionado = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
          break;
        case 1:
          break;
      }
    });
  }
}
