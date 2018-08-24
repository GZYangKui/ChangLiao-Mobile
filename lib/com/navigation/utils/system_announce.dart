import 'package:audioplayers/audio_cache.dart';

///
/// 系统通知(包括一些提示音)
///
///

void playFriendMention() {
  new AudioCache().play("assets/audio/friend_request.mp3");
}
