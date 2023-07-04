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

  late String imageUrl = "";
  late bool imageFirestore = false;

  @override
  void initState() {
    super.initState();
  }


  
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
        setState(() {
          image = null;
        });
        print("Upload realizado com sucesso.");
        //Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.USUARIO_LIST_SCREEN, (route) => false);
      });
      upload.catchError((error, stackTrace) {
        print("Upload falhou: $error");
      });
    }

    void deletarImagem() {
      final firebaseStorage = FirebaseStorage.instance;
      final reference = firebaseStorage.ref("user/${usuarioSelecionado.id}.jpg");
      final delete = reference.delete();
      delete.whenComplete(() {
        print("Delete realizado com sucesso.");
        //Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.USUARIO_LIST_SCREEN, (route) => false);
      });
      delete.catchError((error, stackTrace) {
        print("Delete falhou: $error");
      });
    }

    void fetchImageUrl() async {
      try {
        final firebaseStorage = FirebaseStorage.instance;
        final reference = firebaseStorage.ref("user/${usuarioSelecionado.id}.jpg");
        await reference.getDownloadURL().then((value) => {
          setState(() {
            imageUrl = value;
            imageFirestore = true;
          })
        });
        print(imageUrl);
      } catch (ignored) {
        setState(() {
            imageUrl = "https://cataas.com/cat";
            imageFirestore = false;
        });
      }
    }


    fetchImageUrl();

    return Scaffold(
      appBar: AppBar(title: const Text("Informações Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text("id ${usuarioSelecionado.id}"),
              if(!imageFirestore) const Text("Imagem Temporaria"),
              if(imageUrl.length > 0) SizedBox(
                height: 400,
                width: 400,
                child: 
                  image == null?
                  Image.network(
                    imageUrl,
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
                const SizedBox(width: 5,),
                if (image != null) ElevatedButton(onPressed: () => salvarImagem(), child: const Text("Salvar"), style :  ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                  )),
                if (imageFirestore) ElevatedButton(onPressed: () => deletarImagem(), child: const Text("Deletar"), style :  ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color
                  ),)
              ],)
              )
            ],
          ),
        ),
      ),
    );
  }
}
