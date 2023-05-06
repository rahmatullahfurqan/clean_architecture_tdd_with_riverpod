import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tdd_with_riverpod/core/config/theme.dart';

import '../../../../core/service/constants.dart';

class DefaultSearchBoxWidget extends HookWidget {
  final String hint;
  final Color? backgroundColor, borderColor;
  final double borderWidth;
  final Function(String value) action;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;

  const DefaultSearchBoxWidget({
    super.key,
    required this.hint,
    this.textInputType,
    this.backgroundColor,
    this.borderColor,
    this.textEditingController,
    this.borderWidth = 1,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onEditingComplete: () => action,
      onChanged: action,
      keyboardType: textInputType ?? TextInputType.name,
      style: Theme.of(context).textTheme.paragraph3,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))
      ],
      decoration: InputDecoration(
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        suffixIconConstraints: const BoxConstraints(maxHeight: 40),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          style: IconButton.styleFrom(minimumSize: Size.zero),
          icon: Icon(
            Icons.search_rounded,
            color: focusNode.hasFocus
                ? Theme.of(context).primaryColor
                : Theme.of(context).baseColorShimmer,
          ),
          onPressed: null,
        ),
        hintText: hint,
        enabledBorder: borderColor != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor!,
                  width: borderWidth,
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorBorder,
                  width: borderWidth,
                ),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorBorder,
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}
