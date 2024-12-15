import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TimeSettingPage extends StatefulWidget {
  final String? initialPeriod;
  final int? initialHour;
  final int? initialMinute;

  TimeSettingPage({
    Key? key,
    this.initialPeriod,
    this.initialHour,
    this.initialMinute,
  }) : super(key: key);

  @override
  _TimeSettingPageState createState() => _TimeSettingPageState();
}

class _TimeSettingPageState extends State<TimeSettingPage> {
  late String _selectedPeriod;
  late int _selectedHour;
  late int _selectedMinute;

  final List<String> _periods = ["오전", "오후"];
  final List<int> _hours = List.generate(12, (index) => index + 1);
  final List<int> _minutes = List.generate(60, (index) => index);

  // late FixedExtentScrollController _hourController;

  @override
  void initState() {
    super.initState();

    _selectedPeriod = widget.initialPeriod ?? "오전";
    _selectedHour = widget.initialHour ?? 1;
    _selectedMinute = widget.initialMinute ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedPeriod = _periods[index];
                      });
                    },
                    children: _periods
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
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedHour = _hours[index];
                      });
                    },
                    children: _hours
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
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedMinute = _minutes[index];
                      });
                    },
                    children: _minutes
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
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {
              context.pop({
                'period': _selectedPeriod,
                'hour': _selectedHour,
                'minute': _selectedMinute,
              });
            },
            child: Container(
                alignment: Alignment.center,
                width: 40.w,
                height: 40.h,
                child: Text(
                  '저장',
                  style: TextStyle(fontSize: 16.sp),
                )),
          ),
        ],
      ),
    );
  }
}
