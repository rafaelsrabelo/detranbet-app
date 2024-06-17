import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart';

class Loader {
  static OverlayEntry? _overlayEntry;
  static bool _open = false;

  Loader._();

  static void show() {
    if (!_open) {
      _overlayEntry = OverlayEntry(
        builder: (context) {
          return Container(
            color: Config.backgroundColor,
            child: const Center(
              child: CircularProgressIndicator(
                color: Config.primaryColor,
              ),
            ),
          );
        },
      );

      _open = true;
      Asuka.addOverlay(_overlayEntry!);
    }
  }

  static void hide() {
    if (_open && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _open = false;
    }
  }
}
