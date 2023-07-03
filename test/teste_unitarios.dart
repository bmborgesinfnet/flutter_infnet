//Testes unitários
import 'dart:math';

import 'package:flutter_infnet/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_infnet_pkg/flutter_infnet_pkg.dart';

void main() {
  group('Pacotes', () {
    test('Testar se a imagem url enviada pelo package', () async {
      final urlImage = ImageCat().getImage();
      final response = await http.get(urlImage as Uri);
      expect(response.statusCode, equals(200));
      String? contentType = response.headers['content-type'];
      expect(contentType, startsWith('image/'));
    });
    test('Testar acesso api externa', () async {
      final _baseUrl = "https://jsonplaceholder.typicode.com";
      final _resource = "users";
      final uri = Uri.parse("$_baseUrl/$_resource");
      final response = await http.get(uri);
      expect(response.statusCode, equals(200));
    });
    test('Teste Criação de um Usuario com JSON', () {
      int id = Random().nextInt(100);
      final newUsuario = Usuario.fromJson({
        "id": id,
        "name": "Joao da Silva",
        "username": "josilva",
        "email": "josilva@josilva.com.br"
      });
      expect(newUsuario, isA<Usuario>());
    });

  });
}
