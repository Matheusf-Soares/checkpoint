import 'package:checkpoint_/perfil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Cadastrar Ponto',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextFormField(
                            initialValue:
                                '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) async {
                              valorArmazenado(value);
                              setState(() {
                                selectedPonto = value;
                              });
                            },
                          ),
                        ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle, color: Colors.purple),
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
              ),
            ],
          ),
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

    void valorArmazenado(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('textFieldValue', value);
}
}
