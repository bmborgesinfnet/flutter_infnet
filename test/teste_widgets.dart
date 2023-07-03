// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_infnet/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();

  });
  testWidgets('Testar tela de SignIn', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: SignInScreen())
    );

    final campoEmail = find.byKey(const Key("texto_email"));
    final campoSenha = find.byKey(const Key("texto_senha"));
    final botaoCadastrar = find.byKey(const Key("botao_cadastrar"));
    final botaoLogin = find.byKey(const Key("botao_login"));

    //Verificar se o widget de email está existente
    expect(campoEmail, findsWidgets);

    //Verificar se o widget de senha está existente
    expect(campoSenha, findsWidgets);

    //Verificar se o botao de cadastrar está existente
    expect(botaoCadastrar, findsWidgets);

    //Verificar se o botao de login está existente
    expect(botaoLogin, findsWidgets);
  });
}
