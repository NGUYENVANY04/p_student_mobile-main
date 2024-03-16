
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/route/router_name.dart';
import 'package:p_student_mobile/ui/pages/chat/chat_page.dart';
import 'package:p_student_mobile/ui/pages/home/home_page.dart';
import 'package:p_student_mobile/ui/pages/login/login_page.dart';
import 'package:p_student_mobile/ui/pages/signup/signup_page.dart';
import 'package:p_student_mobile/ui/pages/splash/splash.dart';



class AppRouter {
  static final router = FluroRouter();

  static void defineRoutes() {
    router.notFoundHandler = notHandler;

    _set(RouterName.splash, (_, __) => const SplashPage());
    _set(RouterName.login, (_, __) => const LoginPage());
    _set(RouterName.signUp, (_, __) => const SignUpPage());
    _set(RouterName.home, (_, __) => const HomePage());
    _set(RouterName.chat, (_, __) => const ChatPage());



  }

  static void _set(String path, HandlerFunc handler) {
    router.define(
      path,
      handler: Handler(handlerFunc: handler),
      transitionType: TransitionType.cupertino,
    );
  }
}

Handler notHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      Scaffold(
        body: Center(
          child: Text('notHandler - $params'),
        ),
      ),
);