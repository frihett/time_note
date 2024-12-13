import 'package:time_note/data_source/memo_database_service.dart';
import 'package:time_note/model/memo.dart';
import 'package:time_note/repository/memo/memo_repository.dart';

class MemoRepositoryLocal implements MemoRepository {
  final MemoDatabaseService databaseService;

  MemoRepositoryLocal({required this.databaseService});

  @override
  Future<List<Memo>> getMemosByDate(DateTime date) async {
    return await databaseService.getMemosByDate(date);
  }

  @override
  Future<Memo> addMemo(Memo memo) async {
    return await databaseService.insertMemo(memo);
  }

  @override
  Future<int> deleteMemo(int id) async {
    return await databaseService.deleteMemo(id);
  }

  @override
  Future<int> updateMemo(int id, String content) async {
    return await databaseService.updateMemo(id, content);
  }
}
