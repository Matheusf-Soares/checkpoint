class UsuarioParcial {
  String email;
  String senha;

  UsuarioParcial({required this.email, required this.senha});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'senha': senha,
    };
  }

  factory UsuarioParcial.fromJson(Map<String, dynamic> json) {
    return UsuarioParcial(
      email: json['email'],
      senha: json['senha'],
    );
  }
}

class Usuario extends UsuarioParcial {
  int? id;
  String? name;
  String? estado;
  int? idade;

  Usuario({
    this.id,
    required String email,
    required String senha,
    this.name,
    this.estado,
    this.idade,
  }) : super(email: email, senha: senha);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'id': id,
      'name': name,
      'estado': estado,
      'idade': idade,
    });
    return data;
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      email: json['email'],
      senha: json['senha'],
      name: json['name'],
      estado: json['estado'],
      idade: json['idade'],
    );
  }
}
