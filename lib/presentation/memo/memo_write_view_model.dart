import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_note/model/memo.dart';
import 'package:time_note/repository/memo/memo_repository.dart';

class MemoWriteViewModel extends ChangeNotifier {
  final MemoRepository _memoRepository;
  final Memo _memo;
  final String _period;
  final int _hour;
  final int _minute;
  final int _year;
  final int _month;
  final int _day;

  final TextEditingController memoController;

  MemoWriteViewModel(
      {required MemoRepository memoRepository,
      Memo? memo,
      required String period,
      required int hour,
      required int minute,
      required int year,
      required int month,
      required int day})
      : _memoRepository = memoRepository,
        _memo = memo ??
            Memo(
              date: DateTime(
                year,
                month,
                day,
                period == '오후' && hour != 12
                    ? hour + 12
                    : (period == '오전' && hour == 12 ? 0 : hour),
                minute,
              ),
              content: '',
            ),
        _period = period,
        _hour = hour,
        _minute = minute,
        _year = year,
        _month = month,
        _day = day,
        memoController = TextEditingController(text: memo?.content ?? '');

  Memo get memo => _memo;

  String get formattedTime =>
      '$_period $_hour:${_minute.toString().padLeft(2, '0')}';

  String get formattedDate => '$_year - $_month - $_day';

  void updateMemoText(String content) {
    _memo.content = content;
  }

  Future<void> saveMemo() async {
    if (_memo.id != null) {
      print('메모가 편집 되었습니다.');
      await _memoRepository.updateMemo(_memo.id!, _memo.content);
    } else {
      print(memo.toString());
      print('메모가 추가 되었습니다.');
      await _memoRepository.addMemo(_memo);
    }
    notifyListeners();
  }
}
