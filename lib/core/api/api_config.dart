import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl => dotenv.env["baseUrl"] ?? "";
  static bool get shouldMockResponse => dotenv.env["mockResponse"]?.toLowerCase() == 'true';
}
