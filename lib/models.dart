// Classe Dart para UsuarioParcial
class UsuarioParcial {
  String email;
  String senha;

  UsuarioParcial({required this.email, required this.senha});

  // Método para converter o objeto em um mapa
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
    };
  }
}

// Classe Dart para Usuario, que herda de UsuarioParcial
class Usuario extends UsuarioParcial {
  int? id;
  String? name;
  String? estado;
  int? idade;

  Usuario({
    this.id,
    this.name,
    this.estado,
    this.idade,
    required String email,
    required String senha,
  }) : super(email: email, senha: senha);

  // Método para converter o objeto em um mapa
  @override
  Map<String, dynamic> toMap() {
    final jsonMap = super.toMap();
    jsonMap.addAll({
      'id': id,
      'name': name,
      'estado': estado,
      'idade': idade,
    });
    return jsonMap;
  }
}
