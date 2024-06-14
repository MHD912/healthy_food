import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String? iconPath;
  final Size? iconSize;
  final void Function()? onIconPressed;

  const CustomTextField({
    super.key,
    required this.text,
    this.iconPath,
    this.iconSize,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        autofocus: false,
        magnifierConfiguration: const TextMagnifierConfiguration(
          shouldDisplayHandlesInMagnifier: false,
        ),
        style: AppTheme.textFieldLabelStyle.copyWith(
          color: AppTheme.camaroneColor,
        ),
        decoration: AppTheme.textFieldDecoration(
          labelText: text,
          iconPath: iconPath,
          iconSize: iconSize,
          onPressed: onIconPressed,
        ),
      ),
    );
  }
}
