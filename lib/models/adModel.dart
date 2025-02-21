import 'dart:io';

class AdModel {
  static String get adUnitawardId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9849258764948384/5331148493';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9849258764948384/9268414144';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
