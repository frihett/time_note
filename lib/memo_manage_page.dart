import 'package:flutter/material.dart';
import 'package:time_note/memo_write_page.dart';

class MemoManagePage extends StatelessWidget {
  final List<String> dummyMemos = ['12:00 PM - 점심', '1:00 PM - 산책'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기록 관리'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dummyMemos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dummyMemos[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoWritePage()),
          );
        },
        child: Text('메모 작성'),
      ),
    );
  }
}
