import 'dart:async';
import 'dart:convert';
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
Future initFileState() async {
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
}

///
///读取配置文件application.json
///
Future readConfig() async {
  File configDir = File("${application.dir}/application.json");
  if (!await configDir.exists()) return;
  var config = json.decode(configDir.readAsStringSync());
  if (config["primaryColor"] != null)
    application.settings["primaryColor"] = config["primaryColor"];
  if (config["voiceSwitch"] != null)
    application.settings["voiceSwitch"] = config["voiceSwitch"];
}

///
///创建app所需Table
///@user 用户信息表(id userName password brief)
///
///
Future initDataBases() async {
  application.dataBases = await openDatabase(application.dbPath, version: 1);
  await application.dataBases.execute(constants.createUserTable);
}

///
///查取用户列表
///
Future obtainUsers() async {
  application.dataBases.rawQuery(constants.obtainUser).then((value) {
    application.counts = value;
  });
}

///
/// 添加用户到数据库
///
void addUser(String userName, String password) async {
  bool isExist = false;
  application.counts.forEach((element) {
    element.forEach((key, value) {
      if (value == userName && key == "userName") {
        isExist = true;
        return;
      }
    });
  });
  if (!isExist) {
    await application.dataBases
        .rawQuery(constants.addUser, [userName, password]);
    obtainUsers();
  }
}

///
/// 更新/写入app设置选项
///
void updateConfig() async {
  File config = File("${application.dir}/application.json");
  if (!await config.exists()) config.createSync();
  config.writeAsStringSync(json.encode(application.settings));
}
