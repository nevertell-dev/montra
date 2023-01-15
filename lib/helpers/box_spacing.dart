import 'package:flutter/material.dart' show SizedBox;

extension BoxSpacingInt on num {
  SizedBox get hSpace => SizedBox(width: toDouble());
  SizedBox get vSpace => SizedBox(height: toDouble());
}
