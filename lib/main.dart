import 'dart:async';

import 'package:flutter/material.dart';

final authRepository = AuthRepository(); // 최상단에 선언

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
        primarySwatch: Colors.blue
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
      body:  Center(
    child: ElevatedButton(
    child: Text('sign up'),
    onPressed: () {authRepository.setAuthState(AuthState.Authenticated);
        },
      ),
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
      body:  Center(
        child: Text('LoginPage'),
      ),
    );
  }
}
// 상태 정의하기
enum AuthState {
  Authenticated, UnAuthenticated, //Authenticated : 인증 된거 UnAuthenticated 안증 안된거
}
//상태 저장 공간 클래스
class AuthRepository{

  final _streamController = StreamController<AuthState>()
  ..add(AuthState.UnAuthenticated);

  get authStream => _streamController.stream; // 자동으로 통제 되도록 한다.
  //상태 값을 변경하려면
setAuthState(AuthState state){
  _streamController.add(state); //스트림 컨트롤러 추가
}

}

//로그인 페이지 로갈 지 메인 페이지 가는 루트 페이지
class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { // 로그인 상태인지
    return StreamBuilder<AuthState>(
      stream: authRepository.authStream,
      builder: (BuildContext context,
        AsyncSnapshot snapshot){
      if(snapshot.data == AuthState.UnAuthenticated){
        return LoginPage();
      }else{
        return MainPage();
      }
    },
    );

  }
}

