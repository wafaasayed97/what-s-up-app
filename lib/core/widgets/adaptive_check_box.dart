import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AdaptiveCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  createState() => _AdaptiveCheckboxState();
}

class _AdaptiveCheckboxState extends State<AdaptiveCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoCheckbox(value: widget.value, onChanged: widget.onChanged)
        : Checkbox(value: widget.value, onChanged: widget.onChanged);
  }
}
