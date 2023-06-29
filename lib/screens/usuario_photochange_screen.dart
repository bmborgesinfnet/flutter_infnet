import 'dart:io';

import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_provider.dart';

class PhotoChangeScreen extends StatefulWidget {
  const PhotoChangeScreen({Key? key}) : super(key: key);
  @override
  State<PhotoChangeScreen> createState() => _PhotoChangeScreenState();
}

class _PhotoChangeScreenState extends State<PhotoChangeScreen> {
  File? image;
  @override
  Widget build(BuildContext context) {
    void alterarImagem() async {
      final picker = ImagePicker();

      final pickImage = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 200,
      );

      if (pickImage != null) {
        setState(() {
          image = File(pickImage.path);
        });
      }
    }

    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuarioSelecionado = usuarioProvider.getUsuarioSelecionado();

    void salvarImagem() {
      final firebaseStorage = FirebaseStorage.instance;
      final reference = firebaseStorage.ref("usuario/${usuarioSelecionado.id}.jpg");
      final upload = reference.putFile(image!);
      upload.whenComplete(() {
        print("Upload realizado com sucesso.");
        Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.USUARIO_LIST_SCREEN, (route) => false);
      });
      upload.catchError((error, stackTrace) {
        print("Upload falhou: $error");
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Alteração de imagem de álbum")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text("Alterando imagem do id ${usuarioSelecionado.id}"),
              image == null?
              Image.network(usuarioSelecionado.photoUrl):
              Image.file(image!),
              const Text("Imagem atual"),
              Center(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                const SizedBox(width: 5,),
                ElevatedButton(onPressed: () => alterarImagem(), child: const Text("Alterar")),
                const SizedBox(width: 5,),
                ElevatedButton(onPressed: () => salvarImagem(), child: const Text("Salvar"))
              ],)
              )
            ],
          ),
        ),
      ),
    );
  }
}
