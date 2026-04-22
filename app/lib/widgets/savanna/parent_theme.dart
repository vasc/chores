import 'package:flutter/material.dart';

import '../../theme.dart';

/// Wraps its child in the muted "parent" Savanna palette. Use this for
/// every adult/parent-facing screen so it reads calmer than the kid UI.
class ParentTheme extends StatelessWidget {
  const ParentTheme({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildTheme(
        Brightness.light,
        tokens: SavannaTokens.parent,
      ),
      child: child,
    );
  }
}
