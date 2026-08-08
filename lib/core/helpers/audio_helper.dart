import "package:audioplayers/audioplayers.dart";
import "package:flutter/foundation.dart";

class AudioHelper {
  static void runSound(String name) {
    if (kIsWeb) {
      AudioPlayer().play(UrlSource("assets/sounds/$name.mp3"));
    } else {
      AudioPlayer().play(AssetSource("sounds/$name.mp3"));
    }
  }
}
