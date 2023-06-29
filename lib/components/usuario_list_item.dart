import 'package:flutter_infnet/models/usuario.dart';
import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:flutter_infnet/screens/usuario_photochange_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_provider.dart';

class UsuarioListItem extends StatefulWidget {
  const UsuarioListItem({Key? key, required this.usuario}) : super(key: key);
  final Usuario usuario;

  @override
  State<UsuarioListItem> createState() => _UsuarioListItemState();
}

class _UsuarioListItemState extends State<UsuarioListItem> {
  @override
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    final photoUrl = widget.usuario.photoUrl;

    setState(() {
      imageUrl = photoUrl;
    });
  }

  void fetchImageUrl() async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final reference = firebaseStorage.ref("users/${widget.usuario.id}.jpg");
      final value = await reference.getDownloadURL();
      setState(() {
        imageUrl = value;
      });
    } catch (ignored) {}
  }

  @override
  Widget build(BuildContext context) {
    fetchImageUrl();
    // var imageUrl = widget.album.thumbnailUrl;
    final albumProvider = Provider.of<UsuarioProvider>(context);
    return ListTile(
      leading: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(imageUrl),
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
                    albumProvider.setUsuarioSelecionado(widget.usuario);
                    Navigator.of(context)
                        .pushNamed(RoutePaths.USUARIO_PHOTOCHANGE_SCREEN);
                  },
                  child: const Icon(Icons.image)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
