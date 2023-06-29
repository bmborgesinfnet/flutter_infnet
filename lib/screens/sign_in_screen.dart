import 'package:flutter_infnet/routes/RoutePaths.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = emailController.text;

    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário autenticado"),
        duration: Duration(seconds: 2),
      ));
      // Navigator.of(context)
      //     .pushReplacementNamed(RoutePaths.TESTE_SCREEN);
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "E-mail"),

            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () => {cadastrar()},
                          style: ButtonStyle(minimumSize: MaterialStateProperty.all(
                              const Size(100, 40)
                          ),
                          ),
                          child: const Text("Cadastrar"),
                      ),
                      // const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () => {login()},
                        style: ButtonStyle(minimumSize: MaterialStateProperty.all(
                            const Size(100, 40)
                        ),
                      ),
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
