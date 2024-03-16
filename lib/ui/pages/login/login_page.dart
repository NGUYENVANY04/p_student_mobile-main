import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:p_student_mobile/common/app_images.dart';
import 'package:p_student_mobile/route/router_name.dart';
import 'package:p_student_mobile/ui/pages/login/login_vm.dart';
import 'package:p_student_mobile/widgets/custombutton.dart';
import 'package:p_student_mobile/widgets/customtextinput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return LoginVM();
      },
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginVM _viewModel = context.read<LoginVM>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loggingin = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loggingin,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'heroicon',
                    child: Image.asset(
                      AppImage.appLogo,
                      height: 120,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Hero(
                    tag: 'HeroTitle',
                    child: Text(
                      'THPT BẮC YÊN THÀNH',
                      style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextInput(
                    hintText: 'Email',
                    leading: Icons.person,
                    obscure: false,
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Mật khẩu',
                    leading: Icons.lock,
                    obscure: true,
                    controller: passController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'loginbutton',
                    child: CustomButton(
                      text: 'ĐĂNG NHẬp',
                      accentColor: Colors.white,
                      mainColor: Colors.deepPurple,
                      onpress: () async {
                        _viewModel.checkLogin(
                          email: emailController.text,
                          password: passController.text,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouterName.signUp);
                      },
                      child: const Text(
                        'hoặc đăng ký tài khoản mới',
                        style:
                            TextStyle(fontSize: 12, color: Colors.deepPurple),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Hero(
                    tag: 'footer',
                    child: Text(
                      'from VANYPTIT',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
