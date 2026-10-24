/*
Created by Neloy on 23 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

class AuthSessionExpiryNotifier {
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  Stream<bool> get sessionExpired => _controller.stream;

  void notifySessionExpired({bool deferRedirectUntilResultDismissed = false}) {
    if (!_controller.isClosed) {
      _controller.add(deferRedirectUntilResultDismissed);
    }
  }

  void dispose() {
    unawaited(_controller.close());
  }
}
