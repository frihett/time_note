import 'package:flutter/foundation.dart';
import 'package:time_note/model/memo.dart';
import 'package:time_note/repository/memo/memo_repository.dart';

class MemoManageViewModel extends ChangeNotifier {
  final MemoRepository memoRepository;

  MemoManageViewModel({required this.memoRepository});

  List<Memo> memos = [];

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> fetchMemosByDate(DateTime date) async {
    final fetchedMemos = await memoRepository.getMemosByDate(date);
    memos = fetchedMemos;
    notifyListeners();
  }

  Future<void> deleteMemo(int id) async{
    await memoRepository.deleteMemo(id);
    print(' 메모가 삭제 되었습니다.');
    notifyListeners();
  }

}
