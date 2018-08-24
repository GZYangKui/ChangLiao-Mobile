import 'package:audioplayers/audio_cache.dart';

///
/// 系统通知(包括一些提示音)
///
///

void playFriendMention() {
  AudioCache player = new AudioCache(prefix: "audio/");
  player.play('request.mp3');
}

void playMessageMention() {
  AudioCache player = new AudioCache(prefix: "audio/");
  player.play('message.wav');
}
