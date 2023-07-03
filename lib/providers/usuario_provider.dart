

import 'package:flutter_infnet/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../services/usuario_service.dart';

class UsuarioProvider with ChangeNotifier {
 final usuarioList = [];
 List<int> likeList = [];
 final uid = FirebaseAuth.instance.currentUser?.uid;
 final _usuarioService = UsuarioService();
 late Usuario usuarioSelecionado;

 setUsuarioSelecionado(Usuario usuario) {
  usuarioSelecionado = usuario;
 }

 Usuario getUsuarioSelecionado() {
  return usuarioSelecionado;
 }

 UsuarioProvider() {
  listarfavoritos().then((value) {
   try {
    likeList = List<int>.from(value);
   } catch (error) {
    likeList = [];
   }
  });
 }

 Future<List<Usuario>> listarUsuarios() async {
  return _usuarioService.list();
 }

 Future<List<dynamic>> listarfavoritos() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/like");
  List<dynamic> likeList = [];
  try {
   DataSnapshot snapshot = await ref.get();

   if (snapshot.value != null) {
    likeList = snapshot.value as List<dynamic>;

    print("Lista de likes: $likeList");
    return likeList;
   } else {
    print("Lista de likes não encontrada.");
   }
  } catch (error) {
   print("Erro ao ler lista de likes: $error");
  }
  return likeList;
 }

 Future<bool> adicionarNovoFavorito(int idFavorito) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/like");

  try {
   DataSnapshot snapshot = await ref.get();
   List<dynamic> likeList = [];

   if (snapshot.value != null) {
    if (snapshot.value is List) {
     likeList = List<dynamic>.from(snapshot.value as List<dynamic>);
    } else {
     likeList.add(snapshot.value);
    }
   }

   likeList.add(idFavorito);

   await ref.set(likeList);

   print("Novo likes adicionado com sucesso.");
   return true;
  } catch (error) {
   print("Erro ao adicionar likes: $error");
   return false;
  }
 }

 Future<bool> removerFavorito(int idFavorito) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/like");

  try {
   DataSnapshot snapshot = await ref.get();
   List<dynamic> likeList = [];

   if (snapshot.value != null) {
    if (snapshot.value is List) {
     likeList = List<dynamic>.from(snapshot.value as List<dynamic>);
    } else {
     likeList.add(snapshot.value);
    }
   }

   likeList.remove(idFavorito);

   await ref.set(likeList);

   print("like removido com sucesso.");
   return true;
  } catch (error) {
   print("Erro ao remover like: $error");
   return false;
  }
 }
}