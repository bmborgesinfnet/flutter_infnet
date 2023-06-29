import 'dart:convert';

import 'package:flutter_infnet/models/usuario.dart';
import 'package:flutter_infnet/repository/usuario/usuario_repository.dart';
import 'package:http/http.dart';

class UsuarioService{
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  Future<List<Usuario>> list() async {
    try {
      Response response = await _usuarioRepository.list();
      final json = jsonDecode(response.body);
      return Usuario.listFromJson(json);
    } catch (err) {
      throw Exception("Problemas ao listar");
    }
  }
}