import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/config/ui_style/ui_style.dart';
import 'package:time_note/presentation/time_setting/time_setting_view_model.dart';

class TimeSettingPage extends StatefulWidget {
  @override
  _TimeSettingPageState createState() => _TimeSettingPageState();
}

class _TimeSettingPageState extends State<TimeSettingPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TimeSettingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              viewModel.currentTime,
              style: UiStyle.h2Style.copyWith(
                fontSize: 40.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            height: 150.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 오전/오후 슬롯
                Flexible(
                  flex: 2,
                  child: CupertinoPicker(
                    diameterRatio: 1.5,
                    squeeze: 1.25,
                    magnification: 1.1,
                    selectionOverlay: null,
                    looping: false,
                    itemExtent: 40.h,
                    onSelectedItemChanged: viewModel.updatePeriod,
                    children: viewModel.periods
                        .map((period) =>
                            Center(child: Container(child: Text(period))))
                        .toList(),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: CupertinoPicker(
                    diameterRatio: 1.5,
                    selectionOverlay: null,
                    magnification: 1.1,
                    squeeze: 1.25,
                    // scrollController: _hourController,
                    looping: true,
                    itemExtent: 40.h,
                    onSelectedItemChanged: viewModel.updateHour,
                    children: viewModel.hours
                        .map((hour) => Center(
                                child: Text(
                              hour.toString(),
                              style: TextStyle(fontSize: 30),
                            )))
                        .toList(),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: 10.w,
                    child: Text(
                      ':',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                // 분 슬롯
                Flexible(
                  flex: 2,
                  child: CupertinoPicker(
                    diameterRatio: 1.5,
                    magnification: 1.1,
                    selectionOverlay: null,
                    squeeze: 1.25,
                    looping: true,
                    itemExtent: 40.h,
                    onSelectedItemChanged: viewModel.updateMinute,
                    children: viewModel.minutes
                        .map((minute) => Center(
                                child: Text(
                              minute.toString().padLeft(2, '0'),
                              style: TextStyle(fontSize: 30),
                            )))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          GestureDetector(
            onTap: () {
              context.pop(viewModel.getSelectedTime());
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: UiStyle.secondaryColorSurface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '저장',
                style: UiStyle.h2Style.copyWith(
                  color: UiStyle.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
