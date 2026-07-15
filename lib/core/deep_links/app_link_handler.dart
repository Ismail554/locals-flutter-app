import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

import '../../app/router.dart';
import '../../features/explore/restaurant_view_details/model/restaurant_view_details_args.dart';

class AppLinkHandler {
  AppLinkHandler._();

  static final AppLinks _appLinks = AppLinks();

  static StreamSubscription<Uri>? _subscription;

  static Future<void> init() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();

      if (initialUri != null) {
        _handle(initialUri);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    _subscription = _appLinks.uriLinkStream.listen(
      _handle,
      onError: (e) {
        debugPrint(e.toString());
      },
    );
  }

static void _handle(Uri uri) {
  debugPrint("DeepLink => $uri");

  if (uri.host != "clubby-andy-irksomely.ngrok-free.dev") return;

  appRouter.go(uri.path);
}

  static void dispose() {
    _subscription?.cancel();
  }
}