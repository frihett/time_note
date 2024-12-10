import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/main_page.dart';
import 'package:time_note/memo_manage_page.dart';
import 'package:time_note/presentation/home/home_page.dart';
import 'package:time_note/presentation/home/home_page_view_model.dart';
import 'package:time_note/time_setting_page.dart';

final GoRouter goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child); // MainPage로 감싸서 네비게이션 바 유지
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => HomePageViewModel(),
              child: HomePage(),
            );
          },
        ),
        GoRoute(
          path: '/memo',
          builder: (context, state) {
            return MemoManagePage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/timeSettingPage',
      builder: (context, state) {
        return TimeSettingPage(); // MainPage 외부의 페이지
      },
    ),
  ],
);