
import 'package:p_student_mobile/common/app_images.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:p_student_mobile/ui/pages/splash/splash_vm.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SplashVM();
      },
      child: const SplashView(),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController mainController;
  late Animation mainAnimation;
  @override
  void initState() {
    super.initState();
    mainController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    mainAnimation =
        ColorTween(begin: Colors.deepPurple[900], end: Colors.grey[100])
            .animate(mainController);
    mainController.forward();
    mainController.addListener(() {
      setState(() {});
    });
    

    Future.delayed(
      const Duration(seconds: 3),
      () {
       context.read<SplashVM>().checkUid();
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAnimation.value,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Hero(
                tag: 'heroicon',
                child: Image.asset(
                  AppImage.appLogo,
                  height: mainController.value * 100,
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
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Đoàn Thanh niên Cộng sản Hồ Chí Minh".toUpperCase(),
                    textStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.deepPurple),
                    speed: const Duration(milliseconds: 60),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const Text('From VanYSoft')
            ],
          ),
        ),
      ),
    );
  }
}
