import 'package:http/http.dart' as http;

class ApiService {
  static Future<dynamic> getMethod(String url) async {
    var parsedUrl = Uri.parse(url);
    return await http.get(parsedUrl);
  }
}
