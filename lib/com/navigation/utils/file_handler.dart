import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

///
///
///
///初始化文件状态
///
void initFileState() async {
  ///获取app文件路径
  application.dir = (await getApplicationDocumentsDirectory()).path;
  Directory directory = Directory("${application.dir}/db");
  bool isExist = await directory.exists();
  if (!isExist) {
    directory.createSync();
    if (!(await File("${application.dir}/db/flutter_im.db").exists()))
      File("${application.dir}/db/flutter_im.db").createSync();
  }
  application.dbPath = "${application.dir}/db/flutter_im.db";
  _initDataBases();
}

///
///创建app所需Table
///@user 用户信息表(id userName password brief)
///
///
void _initDataBases() async {
  application.dataBases = await openDatabase(application.dbPath, version: 1);
  await application.dataBases.execute(constants.createUserTable);
  _obtainUsers();
}

///
///查取用户列表
///
void _obtainUsers() async {
  application.dataBases.query(constants.obtainUser).then((value) {
    print(value);
  });
}

///
/// 添加用户到数据库
///
void addUser(String userName, String password) async {
  application.dataBases.execute(constants.addUser, [userName, password]);
}
