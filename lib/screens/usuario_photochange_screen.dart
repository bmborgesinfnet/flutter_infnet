import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../providers/usuario_provider.dart';
import 'package:image_picker/image_picker.dart';

class PhotoChangeScreen extends StatefulWidget {
  const PhotoChangeScreen({Key? key}) : super(key: key);
  @override
  State<PhotoChangeScreen> createState() => _PhotoChangeScreenState();
}

class _PhotoChangeScreenState extends State<PhotoChangeScreen> {
  File? image;
  @override
  Widget build(BuildContext context) {

    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuarioSelecionado = usuarioProvider.getUsuarioSelecionado();

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

    void salvarImagem() {
      final firebaseStorage = FirebaseStorage.instance;
      final reference = firebaseStorage.ref("user/${usuarioSelecionado.id}.jpg");
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
      appBar: AppBar(title: const Text("Informações Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text("id ${usuarioSelecionado.id}"),
              SizedBox(
                height: 400,
                width: 400,
                child: 
                  image == null?
                  Image.network(
                    "https://source.unsplash.com/random",
                    loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ) : 
                  Image.file(image!),
              ),
              Text("Nome ${usuarioSelecionado.name}"),
              Text("Email ${usuarioSelecionado.email}"),
              Text("Telefone ${usuarioSelecionado.phone}"),
              Center(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ElevatedButton(onPressed: () => alterarImagem(), child: const Text("Alterar")),
              ],)
              )
            ],
          ),
        ),
      ),
    );
  }
}
