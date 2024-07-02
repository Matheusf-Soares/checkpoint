import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  final String baseUrl = 'http://127.0.0.1:8000';

  Future<Map<String, dynamic>> addUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuario'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao adicionar usuário');
    }
  }

  Future<Map<String, dynamic>> deleteUsuario(int usuarioId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/usuario/$usuarioId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao deletar usuário');
    }
  }

  Future<Map<String, dynamic>> verificaUsuario(UsuarioParcial usuarioParcial) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuario/autenticar'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(usuarioParcial.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Falha ao autenticar usuário');
    }
  }
}
