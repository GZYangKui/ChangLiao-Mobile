import 'package:sqflite/sqflite.dart';

///
/// 存放整个app的全局变量
///

///声音提醒开关
bool voiceSwitch = true;

///夜间模式
bool nightModel = false;

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
