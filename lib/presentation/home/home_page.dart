import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/model/time_setting.dart';
import 'package:time_note/presentation/home/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈 화면'),
      ),
      body: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.timeSettings.isEmpty) {
            return Center(
              child: Text('저장된 시간이 없습니다.'),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: ListView.builder(
              itemCount: viewModel.timeSettings.length,
              itemBuilder: (context, index) {
                final timeSetting = viewModel.timeSettings[index];
                return ListTile(
                  title: Text(
                    '${timeSetting.period} ${timeSetting.hour}:${timeSetting.minute.toString().padLeft(2, '0')}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      viewModel.deleteTimeSetting(timeSetting.id!);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push('/timeSettingPage');


          if (result != null && result is Map<String, dynamic>) {
            final newTimeSetting = TimeSetting(
              id: null,
              period: result['period'],
              hour: result['hour'],
              minute: result['minute'],
              date: DateTime.now(),
              memo: result['memo'] ?? '',
            );
            Provider.of<HomePageViewModel>(context, listen: false)
                .addTimeSetting(newTimeSetting);
          }
        },
        child: Text('시간 추가'),
      ),
    );
  }
}
