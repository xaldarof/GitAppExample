import 'package:get/get.dart';
import 'package:git_app/data/cache/AccountCacheModel.dart';

import '../data/cache/core_database.dart';

class FavoritesController extends GetxController {
  late CoreDatabase database;

  List<AccountCacheModel>? accounts;

  @override
  void onInit() {
    $FloorCoreDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;
      accounts = await database.cacheDao.getAll();
      update();
    });
    super.onInit();
  }
}
