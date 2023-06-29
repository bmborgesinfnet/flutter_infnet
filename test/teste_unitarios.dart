//Testes unitários
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_infnet_pkg/flutter_infnet_pkg.dart';
import 'package:flutter_infnet_pkg/models/album.dart';

void main() {
  int idAleatorio = Random().nextInt(100);
  group('Pacotes', () {
    test('Testar se um álbum é gerado a partir da biblioteca de geração', () {
      Album albumGerado = GeradorAlbuns.gerarAlbum(idAleatorio);
      expect(albumGerado, isA<Album>());
    });

    test('Testar se o id gerado é realmente implementado no álbum gerado', () {
      Album albumGerado = GeradorAlbuns.gerarAlbum(idAleatorio);
      expect(albumGerado.id, idAleatorio);
    });

    test('Testar se a imagem gerada é uma imagem válida', () async {
      Album albumGerado = GeradorAlbuns.gerarAlbum(idAleatorio);
      final response = await http.get(Uri.parse(albumGerado.thumbnailUrl));
      expect(response.statusCode, equals(200));
      String? contentType = response.headers['content-type'];
      expect(contentType, startsWith('image/'));
    });
  });
  group('Testes models', () {
    test('Testar se é criado um álbum através de um JSON', () {
      final albumCriado = Album.fromJson({
        "id": idAleatorio,
        "title": "Álbum teste",
        "url": "https://google.com.br",
        "thumbnailUrl": "https://google.com.br/image"
      });
      expect(albumCriado, isA<Album>());
    });
    test('Testar se é criado uma lista albuns através de um JSON', () {
      List<Album> albumCriado = Album.listFromJson([
        {
          "id": idAleatorio,
          "title": "Álbum teste",
          "url": "https://google.com.br",
          "thumbnailUrl": "https://google.com.br/image"
        },
        {
          "id": idAleatorio + 1,
          "title": "Álbum teste 2",
          "url": "https://google.com.br",
          "thumbnailUrl": "https://google.com.br/image"
        }
      ]);
      expect(albumCriado, isA<List<Album>>());
    });
    test('Testar se o favorito é alternado e setado', () {
      Album albumTeste = Album(idAleatorio, "Album teste",
          "https://google.com.br", "https://google.com.br");

      expect(albumTeste.favorite, false);
      albumTeste.toggleFavorite();
      expect(albumTeste.favorite, true);
      albumTeste.setFavorite(false);
      expect(albumTeste.favorite, false);
    });
  });
}
