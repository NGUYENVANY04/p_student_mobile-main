import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:p_student_mobile/route/app_router.dart';
import 'package:p_student_mobile/route/observer.dart';
import 'package:p_student_mobile/route/router_name.dart';

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi_VN', null);
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
       scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: mainNavigatorKey,
      onGenerateRoute: AppRouter.router.generator,
      navigatorObservers: [
        Observer(),
      ],
      initialRoute: RouterName.splash,
    );
  }
  
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
