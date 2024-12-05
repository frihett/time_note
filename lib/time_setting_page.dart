import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSettingPage extends StatefulWidget {
  @override
  _TimeSettingPageState createState() => _TimeSettingPageState();
}

class _TimeSettingPageState extends State<TimeSettingPage> {
  // 선택된 시간 값을 저장
  String _selectedPeriod = "오전"; // 오전/오후
  int _selectedHour = 1; // 시간 (1~12)
  int _selectedMinute = 0; // 분 (0~59)

  // 데이터 리스트
  final List<String> _periods = ["오전", "오후"];
  final List<int> _hours = List.generate(12, (index) => index + 1); // 1~12
  final List<int> _minutes = List.generate(60, (index) => index); // 0~59

  late FixedExtentScrollController _hourController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hourController.animateToItem(5,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('시간 설정'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 180,
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
                    itemExtent: 50,
                    // 아이템 높이
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
                // 시간 슬롯
                Flexible(
                  flex: 2,
                  child: CupertinoPicker(
                    diameterRatio: 1.5,
                    selectionOverlay: null,
                    magnification: 1.1,
                    squeeze: 1.25,
                    scrollController: _hourController,
                    looping: true,
                    itemExtent: 50,
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
                    width: 10,
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
                    itemExtent: 50,
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 선택된 시간 저장 또는 처리
              final selectedTime =
                  "$_selectedPeriod $_selectedHour:${_selectedMinute.toString().padLeft(2, '0')}";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('선택된 시간: $selectedTime')),
              );
              Navigator.pop(context, selectedTime); // 시간 반환 및 화면 종료
            },
            child: Text('시간 저장'),
          ),
        ],
      ),
    );
  }
}
