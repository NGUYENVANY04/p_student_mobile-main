import 'package:flutter/material.dart';
import 'package:p_student_mobile/app.dart';
import 'package:p_student_mobile/common/app_color.dart';
import 'package:p_student_mobile/route/router_name.dart';
import 'package:sidebarx/sidebarx.dart';

class DrawerSideBar extends StatelessWidget {
  const DrawerSideBar({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: AppColor.scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [AppColor.accentCanvasColor, AppColor.canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: AppColor.canvasColor,
        ),
      ),
      footerDivider: AppColor.divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/icons/app_logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Trang chủ',
          onTap: () {
            debugPrint('Home');
          },
        ),
        SidebarXItem(
          icon: Icons.home,
          label: 'Chat',
          onTap: () {
            mainNavigatorKey.currentState?.pushNamed(RouterName.chat);
          },
        ),
      
      ],
    );
  }
}