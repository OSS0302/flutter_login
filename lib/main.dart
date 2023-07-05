import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final authRepository = AuthRepository(); // 최상단에 선언 해서 싱글톤으로 사용되고있다.

void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider.value(
          value: AuthRepository(),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
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
        child: ElevatedButton(
          child: Text('sign up'),
          onPressed: () {
            Provider.of<AuthRepository>(context , listen: false).authState = AuthState.Authenticated;
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
      body: Center(
        child: ElevatedButton(
          child: Text('sign out'),
          onPressed: () {
            Provider.of<AuthRepository>(context, listen: false).authState = AuthState.UnAuthenticated; // 단발성 일떄 listen.false 을 사용하지 않으면 대기 상태가 되어서 오류가 난다.
          },
        ),
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
class AuthRepository with ChangeNotifier {
  AuthState authState = AuthState.UnAuthenticated;
}

//로그인 페이지 로갈 지 메인 페이지 가는 루트 페이지
class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   AuthState authState = Provider.of<AuthRepository>(context).authState;
    // 로그인 상태인지
    return authState == AuthState.UnAuthenticated ? LoginPage() : MainPage();
  }
}
