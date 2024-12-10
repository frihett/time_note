import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_note/presentation/home/home_page.dart';
import 'package:time_note/memo_manage_page.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({Key? key, required this.child}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // 각 네비게이션 페이지
  final List<Widget> _pages = [
    HomePage(),
    MemoManagePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Note'),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            context.go('/home'); // 홈으로 이동
          } else if (index == 1) {
            context.go('/memo'); // 메모 관리로 이동
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '메모 관리',
          ),
        ],
      ),
    );
  }
}
