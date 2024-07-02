import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "http://127.0.0.1:8000";

  // Obter usuário pelo ID
  Future<dynamic> get(String usuarioId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/usuario/$usuarioId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao carregar dados do servidor');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }

  // Adicionar um novo usuário
  Future<dynamic> post(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/usuario'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao enviar dados para o servidor');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }

  // Deletar usuário pelo ID
  Future<dynamic> delete(String usuarioId) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/usuario/$usuarioId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao deletar usuário');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }

  // Autenticar usuário
  Future<dynamic> authenticateUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/usuario/autenticar'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ao autenticar usuário');
      }
    } catch (e) {
      throw Exception('Erro ao conectar ao servidor: $e');
    }
  }
}
