import 'dart:io';

import 'package:flutter/material.dart';

class PhotoProviderNotifier extends ChangeNotifier {
  File? photoNotifier;

  initPhotoNotifier(File file) {
    clearPhotoNotifier();
    photoNotifier = file;
    notifyListeners();
  }

  clearPhotoNotifier() {
    photoNotifier = null;
    notifyListeners();
  }
}
