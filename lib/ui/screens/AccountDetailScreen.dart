import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:git_app/bloc/account_detail_screen_bloc.dart';
import 'package:git_app/controllers/user_info_controller.dart';

import '../../data/model/ui/GitAccount.dart';

class AccountDetailScreen extends StatelessWidget {
  final GitAccount account;

  AccountDetailScreen({super.key, required this.account});

  UserInfoController controller = Get.put(UserInfoController());

  @override
  Widget build(BuildContext context) {
    controller.getAccountInfo(account.login);

    return Scaffold(
        body: Center(
      child: GestureDetector(
        child: Text(controller.account?.login ?? "Loading"),
        onTap: () {
          controller.updateName();
        },
      ),
    ));
  }
}