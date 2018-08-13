///
///
/// 系统推送数据model
/// @ _message 推送内容
/// @ _type  推送类型
/// @ _to   若需要回复,回复对象
/// @ isDeal 该条消息是否处理
/// @ isAccept 处理结果
///
///
class SystemPropelModel{
  final String message;
  final String type;
  final String to;
  bool isDeal = false;
  bool isAccept = false;
  SystemPropelModel(this.message, this.type, this.to);

}