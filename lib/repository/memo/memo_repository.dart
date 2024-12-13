import 'package:time_note/model/memo.dart';

abstract interface class MemoRepository {
  Future<List<Memo>> getMemosByDate(DateTime date);

  Future<Memo> addMemo(Memo memo);

  Future<int> deleteMemo(int id);

  Future<int> updateMemo(int id, String content);
}
