import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:p_student_mobile/common/app_images.dart';
import 'package:p_student_mobile/ui/pages/signup/signup_vm.dart';
import 'package:p_student_mobile/widgets/custombutton.dart';
import 'package:p_student_mobile/widgets/customtextinput.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SignUpVM();
      },
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final _viewModel = context.read<SignUpVM>();

  TextEditingController nameController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String? email;
  // String username;
  bool signingup = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: signingup,
      child: Scaffold(
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
                      height: 60,
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
                    hintText: 'Họ tên',
                    leading: Icons.text_format,
                    obscure: false,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Trường',
                    leading: Icons.school,
                    obscure: false,
                    controller: schoolController,
                  ),
                  CustomTextInput(
                    hintText: 'Lớp',
                    leading: Icons.class_outlined,
                    obscure: false,
                    controller: classController,
                  ),
                  CustomTextInput(
                    hintText: 'Số thứ tự',
                    leading: Icons.class_outlined,
                    obscure: false,
                    controller: studentNumberController,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Email',
                    leading: Icons.mail,
                    keyboard: TextInputType.emailAddress,
                    obscure: false,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Mật khẩu',
                    leading: Icons.lock,
                    keyboard: TextInputType.visiblePassword,
                    obscure: true,
                    controller: passController,
                  ),
                  CustomTextInput(
                    hintText: 'Xác nhận mật khẩu',
                    leading: Icons.lock,
                    keyboard: TextInputType.visiblePassword,
                    obscure: true,
                    controller: confirmPassController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'signupbutton',
                    child: CustomButton(
                      onpress: () async {
                        _viewModel.registerWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text,
                          name: nameController.text,
                          school: schoolController.text,
                          nameClass: classController.text,
                          confirmPass: confirmPassController.text,
                          studentNumber: studentNumberController.text,
                        );
                      },
                      text: 'ĐĂNG KÝ',
                      accentColor: Colors.white,
                      mainColor: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'or log in instead',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.deepPurple),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
