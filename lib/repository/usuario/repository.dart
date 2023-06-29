import 'package:http/http.dart' as http;

abstract class Repository {
  final _baseUrl = "https://jsonplaceholder.typicode.com";
  final String _resource;
  Repository(this._resource);

  list() {
    final uri = Uri.parse("$_baseUrl/$_resource");
       return http.get(uri);
  }
}