import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/config/ui_style/ui_style.dart';
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
      appBar: AppBar(),
      body: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.timeSettings.isEmpty) {
            return Center(
              child: Text('저장된 시간이 없습니다.'),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              children: [
                Icon(
                  Icons.access_time,
                  size: 150.sp,
                  color: UiStyle.secondaryColorSurface,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await context.push('/timeSettingPage');

                        if (result != null && result is Map<String, dynamic>) {
                          final newTimeSetting = TimeSetting(
                            id: null,
                            period: result['period'],
                            hour: result['hour'],
                            minute: result['minute'],
                            date: DateTime.now(),
                          );
                          Provider.of<HomePageViewModel>(context, listen: false)
                              .addTimeSetting(newTimeSetting);
                        }
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: UiStyle.secondaryColorSurface,
                        size: 32.sp,
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    itemCount: viewModel.timeSettings.length,
                    itemBuilder: (context, index) {
                      final timeSetting = viewModel.timeSettings[index];
                      return GestureDetector(
                        onLongPress: () {
                          viewModel.deleteTimeSetting(timeSetting.id!);
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 8.w),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.w),
                            decoration: BoxDecoration(
                                color: UiStyle.secondaryColorSurface,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${timeSetting.period} ${timeSetting.hour}:${timeSetting.minute.toString().padLeft(2, '0')}',
                                  style: UiStyle.h2Style
                                      .copyWith(color: UiStyle.color[900]),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    activeColor: Colors.white,
                                    activeTrackColor: UiStyle.secondaryColor,
                                    inactiveThumbColor: Colors.white,
                                    trackOutlineWidth:
                                        WidgetStateProperty.all(0.0),
                                    trackOutlineColor: WidgetStateProperty.all(
                                        Colors.transparent),
                                    thumbIcon: WidgetStateProperty.all(
                                      Icon(Icons.circle,
                                          size: 20, color: Colors.white),
                                    ),
                                    value: timeSetting.isToggled,
                                    onChanged: (value) {
                                      viewModel.updateToggleState(
                                          timeSetting.id!, value);
                                    },
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
