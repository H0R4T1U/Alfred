import 'package:http/http.dart' as http ;

class ApiService {
  final String apiUrl = "https://localhost:8080";

  Future<http.Response> fetchReservations() async {
    return await http.get(Uri.parse(apiUrl));
  }
}