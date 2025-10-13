import 'package:flutter/material.dart';

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnFocusExtension on BuildContext {
  void unFocus() => Focus.of(this).unfocus();
}