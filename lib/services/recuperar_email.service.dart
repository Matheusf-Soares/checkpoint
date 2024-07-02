import 'dart:convert';
import 'package:http/http.dart' as http;

class RecuperarEmailService {
  final String baseUrl = 'http://127.0.0.1:8000';

  Future<String> recuperarSenha(String email) async {
    final Uri url = Uri.parse('$baseUrl/recuperar_senha?email=$email');
    
    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
        return responseData['message'];
      } else {
        return 'Erro: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro ao enviar o email: $e';
    }
  }
}
