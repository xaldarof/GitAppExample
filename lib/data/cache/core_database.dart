
import 'dart:async';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

import 'AccountCacheModel.dart';
import 'cache_dao.dart';

part 'core_database.g.dart';

@Database(version: 1, entities: [AccountCacheModel])
abstract class CoreDatabase extends FloorDatabase {
  CacheDao get cacheDao;
}
