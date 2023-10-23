import 'package:http/http.dart' as http;

// El ApiProvider se encarga de realizar las peticiones a la API
// y devolver la respuesta.
class ApiProvider {
  final String baseUrl = 'postgres://fl0user:Kj7obcqEh3LZ@ep-holy-breeze-83855958.eu-central-1.aws.neon.fl0.io:5432/database?sslmode=requir';

  Future<http.Response> registerUser(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: userData,
    );
    return response;
  }
}
