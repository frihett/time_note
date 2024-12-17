import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_note/config/ui_style/ui_style.dart';
import 'package:time_note/presentation/memo/memo_manage_view_model.dart';

class MemoManagePage extends StatefulWidget {
  @override
  State<MemoManagePage> createState() => _MemoManagePageState();
}

class _MemoManagePageState extends State<MemoManagePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<MemoManageViewModel>();
      viewModel.fetchMemosByDate(viewModel.selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<MemoManageViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              // 달력 위젯
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: viewModel.selectedDate,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, viewModel.selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    viewModel.selectedDate = selectedDay;
                    viewModel.fetchMemosByDate(viewModel.selectedDate);
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: UiStyle.primaryColorSurface,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: UiStyle.secondaryColorSurface,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                ),
              ),

              Expanded(
                child: viewModel.memos.isEmpty
                    ? Center(
                        child: Text('선택한 날짜에 메모가 없습니다.'),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: ListView.builder(
                          itemCount: viewModel.memos.length,
                          itemBuilder: (context, index) {
                            final memo = viewModel.memos[index];
                            return GestureDetector(
                              onLongPress: () {
                                viewModel.deleteMemo(memo.id!);
                                viewModel
                                    .fetchMemosByDate(viewModel.selectedDate);
                              },
                              onTap: () {
                                final date =
                                    DateTime.parse(memo.date.toString());

                                context.go('/memoWritePage', extra: {
                                  'memo': memo,
                                  'period': date.hour >= 12 ? '오후' : '오전',
                                  'hour':
                                      date.hour % 12 == 0 ? 12 : date.hour % 12,
                                  'minute': date.minute,
                                  'year': date.year,
                                  'month': date.month,
                                  'day': date.day,
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 12.h),
                                padding: EdgeInsets.symmetric(
                                  vertical: 20.h,
                                  horizontal: 20.w,
                                ),
                                decoration: BoxDecoration(
                                  color: UiStyle.secondaryColorSurface,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${memo.date.hour}:${memo.date.minute}',
                                        style: UiStyle.bodyStyle),
                                    SizedBox(height: 10.h),
                                    Text(memo.content, style: UiStyle.h4Style),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedDate = context.read<MemoManageViewModel>().selectedDate;
          final now = DateTime.now().toUtc().add(Duration(hours: 9));

          final period = now.hour >= 12 ? 'PM' : 'AM';
          final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
          final minute = now.minute;
          context.go(
            '/memoWritePage',
            extra: {
              'period': period,
              'hour': hour,
              'minute': minute,
              'year': selectedDate.year,
              'month': selectedDate.month,
              'day': selectedDate.day,
            },
          );
          context.read<MemoManageViewModel>().fetchMemosByDate(selectedDate);
        },
        backgroundColor: UiStyle.primaryColorSurface,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
