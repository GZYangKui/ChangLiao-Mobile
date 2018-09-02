import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/com/navigation/models/new_trend_model.dart';
import 'package:flutter_app/com/navigation/utils/utils.dart';
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
  ///实例化数据库操作对象
  application.dataBases = await openDatabase(application.dbPath, version: 1);

  ///创建用户表
  await application.dataBases.execute(constants.createUserTable);

  ///创建收藏表
  await application.dataBases.execute(constants.createCollectionTable);
}

///
///查取用户列表
///
Future<Map<String, dynamic>> obtainUsers({String userId}) async {
  await application.dataBases.rawQuery(constants.obtainUser).then((value) {
    application.counts = value;
  });
  Map<String, dynamic> user = {};
  if (userId != null) {
    application.counts.forEach((count) {
      if (count["userId"] == userId) {
        user = count;
        return user;
      }
    });
  }
  return user;
}

///
/// 添加用户到数据库
///
void addUser(String userId, String password) async {
  bool isExist = false;
  application.counts.forEach((element) {
    element.forEach((key, value) {
      if (value == userId && key == "userId") {
        isExist = true;
        return;
      }
    });
  });
  if (!isExist) {
    await application.dataBases.rawQuery(constants.addUser, [userId, password]);
    obtainUsers();
  }
}

///
/// 插入NewTrend到数据库收藏
///
Future insertCollect(NewTrendModel model, String type) async {
  var result = await application.dataBases
      .rawQuery(constants.selectCollect, [model.title]);
  if (result.length == 0) {
    await application.dataBases.execute(constants.insertCollect,
        [model.title, model.url, model.enbrief, model.cnbrief, type]);
    showToast("收藏成功!");
  } else
    showToast("数据已经存在了!");
}

///
///查询某一条记录是否存在
///
Future<bool> selectCollects(String title) async {
  var result =
      await application.dataBases.rawQuery(constants.selectCollect, [title]);
  if (result.length > 0) return true;

  return false;
}

///
///删除某一条收藏数据
///
void deleteCollects(String title) async {
  var result =
      await application.dataBases.rawDelete(constants.deleteCollect, [title]);
  if (result > 0) {
    showToast("移除成功！");
  } else {
    showToast("移除失败！");
  }
}

///
/// 更新用户信息
/// @item 参数 userName/sign/mail/phone/website
///
Future<String> _loadInfo(String item) async {
  String sql = "SELECT $item FROM user WHERE userId ='${handler.userId}'";
  await application.dataBases.rawQuery(sql);
  return null;
}

///
/// 更新/写入app设置选项
///
void updateConfig() async {
  File config = File("${application.dir}/application.json");
  if (!await config.exists()) config.createSync();
  config.writeAsStringSync(json.encode(application.settings));
}
