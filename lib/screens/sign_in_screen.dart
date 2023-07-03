import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_infnet_pkg/flutter_infnet_pkg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController(text: "teste@flutterinfnet.com");
  final TextEditingController passwordController = TextEditingController(text: "teste@flutterinfnet.com");
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  late String imageUrl="";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();


    imagemLogin();

  }

  Future<void> imagemLogin() async {
    var url = ImageCat().getImage();
    setState(() {
      imageUrl = url;
    });
  }


  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = emailController.text;

    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final currentUser = auth.currentUser;    
      if(currentUser != null){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Usuário autenticado"),
          duration: Duration(seconds: 2),
        ));
        // Navigator.of(context)
        //     .pushReplacementNamed(RoutePaths.TESTE_SCREEN);
        Navigator.of(context)
            .pushReplacementNamed(RoutePaths.USUARIO_LIST_SCREEN);
      } 

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${e}"),
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> cadastrar() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = emailController.text;

    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário autenticado"),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context)
          .pushReplacementNamed(RoutePaths.USUARIO_LIST_SCREEN);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${e}"),
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
          const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32
              ),
          ),
          if (imageUrl.length > 0) SizedBox(
            height: 300,
            width: 300,
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
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "E-mail"),
              key: const Key("texto_email")
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
              key: const Key("texto_senha")
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () => {cadastrar()},
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(100, 40)
                            )
                          ),
                          key: const Key("botao_cadastrar"),
                          child: const Text("Cadastrar"),
                      ),
                      // const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () => {login()},
                        style: ButtonStyle(minimumSize: MaterialStateProperty.all(
                            const Size(100, 40)
                        ),
                      ),
                        key: const Key("botao_login"),
                        child: const Text("Login"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
