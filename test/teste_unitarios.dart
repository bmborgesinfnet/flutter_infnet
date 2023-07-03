//Testes unitários
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_infnet_pkg/flutter_infnet_pkg.dart';

void main() {
  group('Pacotes', () {
    test('Testar se a imagem gerada é uma imagem válida', () async {
      final urlImage = ImageCat().getImage();
      final response = await http.get(urlImage as Uri);
      expect(response.statusCode, equals(200));
      String? contentType = response.headers['content-type'];
      expect(contentType, startsWith('image/'));
    });
  });
}
