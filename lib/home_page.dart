import 'package:flutter/material.dart';
import 'package:time_note/time_setting_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈 화면'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 15, // 예시 시간 개수
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('알람 시간: 12:${index + 30} PM'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TimeSettingPage()));
        },
        child: Text('시간 추가'),
      ),
    );
  }
}
