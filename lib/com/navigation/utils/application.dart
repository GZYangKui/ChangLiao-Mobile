import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

///
/// 存放整个app的全局变量
///

/// 整个应用数据存储路径
String dir = "";

///数据库文件路径
String dbPath = "";

///sqlite数据库操纵实例
Database dataBases;

///人工智能时间查询
String aiDate = "2018-07-29";

///区块链查询时间
String blockDate = "2018-07-29";

///账号集合
List<Map<String, dynamic>> counts = [];

/// 当前app设置信息
Map<String, String> settings = {};

///
/// 根据传过来的用户名查找密码
///
String findUser(String userId) {
  if (counts.length == 0) return null;
  String password;
  counts.forEach((count) {
    if (count.containsValue(userId)) {
      password = count["password"];
      return;
    }
    if (password != "") return;
  });
  return password ?? null;
}
