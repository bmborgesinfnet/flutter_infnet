import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_provider.dart';

class PhotoChangeScreen extends StatefulWidget {
  const PhotoChangeScreen({Key? key}) : super(key: key);
  @override
  State<PhotoChangeScreen> createState() => _PhotoChangeScreenState();
}

class _PhotoChangeScreenState extends State<PhotoChangeScreen> {
  @override
  Widget build(BuildContext context) {

    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuarioSelecionado = usuarioProvider.getUsuarioSelecionado();

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
                child: Image.network(
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
                ),
              ),
              Text("Nome ${usuarioSelecionado.name}"),
              Text("Email ${usuarioSelecionado.email}"),
              Text("Telefone ${usuarioSelecionado.phone}"),
            ],
          ),
        ),
      ),
    );
  }
}
