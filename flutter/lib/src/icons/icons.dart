import 'package:flutter/material.dart';

// todo: switch image quality based on mobile needs
// https://i.stack.imgur.com/I8ioG.png

// fixme: https://github.com/flutter/flutter/issues/1831
// Flutter does not support svg (yet?), so we will hold everything as svg
// for future exports and png for usage

class FlashcardsIcons {
  static const String commonIconPath = 'packages/flashcards_common/assets/icons';

  static Widget _icon({String path, double size = 18.0}) {
    return Image.asset(
      '$commonIconPath/$path',
      width: size,
      height: size,
      color: null,
    );
  }

  static Widget google({double size = 18.0}) {
    return _icon(
      path: 'google_logo.png',
      size: size,
    );
  }
}
