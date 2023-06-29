import 'package:flutter_infnet/providers/usuario_provider.dart';
import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:flutter_infnet/screens/usuario_photochange_screen.dart';
import 'package:flutter_infnet/screens/list_usuario_screen.dart';
import 'package:flutter_infnet/screens/sign_in_screen.dart';
// import 'package:flutter_infnet/screens/teste.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Aplicativo());
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => UsuarioProvider(),
    child: MaterialApp(
      title: "Lista de Albuns",
      debugShowCheckedModeBanner: false,
      routes: {
        RoutePaths.SIGN_IN_SCREEN: (context) => const SignInScreen(),
        RoutePaths.USUARIO_LIST_SCREEN: (context) => const UsuarioListScreen(),
        RoutePaths.USUARIO_PHOTOCHANGE_SCREEN: (context) => const PhotoChangeScreen(),
      },
    ),
    );
  }
}
