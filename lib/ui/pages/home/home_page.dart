import 'package:flutter/material.dart';
import 'package:p_student_mobile/common/app_color.dart';
import 'package:p_student_mobile/global/global_data.dart';
import 'package:p_student_mobile/ui/pages/common/drawer_side_bar.dart';
import 'package:p_student_mobile/ui/pages/home/home_vm.dart';
import 'package:p_student_mobile/ui/pages/home/widget/calendar_widget.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeVM();
      },
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  late final _viewModel = context.read<HomeVM>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  backgroundColor: AppColor.canvasColor,
                  title: Text(
                      "${GlobalData.instance.student!.name} - lớp ${GlobalData.instance.student!.nameClass}"),
                  leading: IconButton(
                    onPressed: () {
                      _key.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                )
              : null,
          drawer: DrawerSideBar(controller: _controller),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.actionColor,
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    Text(
                      _viewModel.getFormattedDate(),
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 28,
                      ),
                    )
                  ],
                ),
                const Text(
                  "  -   Đã điểm danh lúc 7 giờ 14",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                const Expanded(child: CalendarWidget())
              ],
            ),
          ),
        );
      },
    );
  }
}
