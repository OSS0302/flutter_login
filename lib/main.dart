import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RootPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
      ),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}
// 상태 정의하기
enum AuthState {
  Authenticated,
  UnAuthenticated, //Authenticated : 인증 된거 UnAuthenticated 안증 안된거
}
//상태 저장 공간 클래스
class AuthRepository{
  AuthState _auth = AuthState.UnAuthenticated;
  final _streamController = StreamController<AuthState>()
  ..add(AuthState.UnAuthenticated);

  get authStream => _streamController.stream;
}

//로그인 페이지 로갈 지 메인 페이지 가는 루트 페이지
class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { // 로그인 상태인지
    return Scaffold(
      appBar:  AppBar(
        title:  Text('Root'),
      ),
      body: Container(),
    );

  }
}

