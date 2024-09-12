import 'package:http/http.dart' as http ;

class ApiService {
  final String baseUrl = "http://localhost:8000";

  Future<http.Response> fetchReservations() async {
    return await http.get(Uri.parse("$baseUrl/fetch"));
  }
}