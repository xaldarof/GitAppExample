
import 'package:floor/floor.dart';

import 'AccountCacheModel.dart';

@dao
abstract class CacheDao {

  @insert
  Future<int> insertUser(AccountCacheModel user);

  @Query('SELECT * FROM AccountCacheModel')
  Future<List<AccountCacheModel>> getAll();

  @Query('SELECT * FROM AccountCacheModel WHERE id=:id')
  Future<AccountCacheModel?> getById(int id);

  @Query('DELETE FROM AccountCacheModel WHERE id = :id')
  Future<AccountCacheModel?> delete(int id);

  @Query("UPDATE AccountCacheModel SET name = :name WHERE id =:id")
  Future<AccountCacheModel?> updateName(String name, int id);
}
