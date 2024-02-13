/*
 * "ttorok" created by @howyoujini on 2/11/24  4:22 PM
 * Copyright (c) . All rights reserved.
 */

extension StringToBool on String? {
  static const String _trueString = "true";
  static const String _falseString = "false";

  bool toBool() {
    switch (this) {
      case _trueString:
        return true;
      case _falseString:
        return false;
      default:
        return false;
    }
  }
}
