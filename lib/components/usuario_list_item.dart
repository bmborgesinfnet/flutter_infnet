import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_infnet/models/usuario.dart';
import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infnet_pkg/flutter_infnet_pkg.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_provider.dart';

class UsuarioListItem extends StatefulWidget {
  const UsuarioListItem({Key? key, required this.usuario}) : super(key: key);
  final Usuario usuario;

  @override
  State<UsuarioListItem> createState() => _UsuarioListItemState();
}

class _UsuarioListItemState extends State<UsuarioListItem> {
  late String imageUrl;

  @override
  void initState() {
    super.initState();

    setState(() {
      imageUrl = "https://cataas.com/cat";
    });

  }

  Future<void> imagemLogin() async {
    var url = ImageCat().getImage();
    setState(() {
      imageUrl = url;
    });
  }


  void fetchImageUrl() async {
      try {
        final firebaseStorage = FirebaseStorage.instance;
        final reference = firebaseStorage.ref("user/${widget.usuario.id}.jpg");
        await reference.getDownloadURL().then((value) => {
          setState(() {
            imageUrl = value;
          })
        });
      } catch (ignored) {
        imagemLogin();
      }
    }

  @override
  Widget build(BuildContext context) {
    //fetchImageUrl();
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    return ListTile(
      leading: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(
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
        ),
      ),
      title: Text(widget.usuario.name),
      subtitle: Text(widget.usuario.email),
      trailing: Column(
        children: [
          Wrap(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(4),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    disabledForegroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    usuarioProvider.setUsuarioSelecionado(widget.usuario);
                    Navigator.of(context)
                        .pushNamed(RoutePaths.USUARIO_PHOTOCHANGE_SCREEN);
                  },
                  child: const Icon(Icons.edit)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
