import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl => dotenv.env['base_url']!;

  static String get googleMapKey =>
      Platform.isAndroid
          ? dotenv.env['map_key_android']!
          : dotenv.env['map_key_ios']!;
}