import 'package:flutter_infnet/providers/usuario_provider.dart';
import 'package:flutter_infnet/services/usuario_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/usuario_list_item.dart';
import '../models/usuario.dart';

class UsuarioListScreen extends StatefulWidget {
  const UsuarioListScreen({Key? key}) : super(key: key);

  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    List<Widget> _generateListUsuarios(List<Usuario> usuariosList) {
      usuariosList.asMap().forEach((key, value) {
      });
      return usuariosList
          .map<Widget>(
            (usuario) => UsuarioListItem(
              usuario: usuario,
            ),
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Lista de usuários")),
      body: FutureBuilder(
        future: usuarioProvider.listarUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao consultar dados: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final list = snapshot.data;
            if (list != null && list.isNotEmpty) {
              return ListView(
                children: _generateListUsuarios(list),
              );
            } else {
              return const Center(
                child: Text("Nenhum usuario localizado."),
              );
            }
          } else {
            return const Center(
              child: Text("Nenhum usuario localizado."),
            );
          }
        },
      ),
    );
  }
}
