import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_note/config/ui_style/ui_style.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({Key? key, required this.child}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: UiStyle.secondaryColorSurface,
        selectedItemColor: UiStyle.secondaryColor,
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
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Memo',
          ),
        ],
      ),
    );
  }
}
