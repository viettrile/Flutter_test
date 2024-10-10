import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autoFocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;

  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;

  const CommonTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autoFocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.enableInteractiveSelection,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.inputFormatters,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  InputDecoration? _inputDecoration;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
     _focusNode = FocusNode();
      _focusNode.addListener(() {
      if (_focusNode.hasFocus != _isFocused) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
    controller = widget.controller ?? TextEditingController();
    _obscureText = widget.obscureText;
    loadInputDecoration();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }

    super.dispose();
  }

  void loadInputDecoration() {
    final commonBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.gray60,
      ),
      borderRadius: BorderRadius.circular(10),
    );
    final customDecoration = widget.decoration;
    _inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      border: commonBorder,
      enabledBorder: commonBorder,
      focusedBorder: commonBorder,
      disabledBorder: commonBorder,
      errorMaxLines: 3,
      hintStyle: AppTypography.s14.withColor(
        AppColors.gray60,
      ),
    ).copyWith(
      icon: customDecoration.icon,
      contentPadding: customDecoration.contentPadding,
      iconColor: customDecoration.iconColor,
      label: customDecoration.label,
      labelText: customDecoration.labelText,
      labelStyle: customDecoration.labelStyle,
      floatingLabelStyle: customDecoration.floatingLabelStyle,
      helperStyle: customDecoration.helperStyle,
      helperMaxLines: customDecoration.helperMaxLines,
      hintText: customDecoration.hintText,
      hintStyle: customDecoration.hintStyle,
      hintFadeDuration: customDecoration.hintFadeDuration,
      hintMaxLines: customDecoration.hintMaxLines,
      error: customDecoration.error,
      errorText: customDecoration.errorText,
      errorStyle: customDecoration.errorStyle,
      errorMaxLines: customDecoration.errorMaxLines,
      floatingLabelBehavior: customDecoration.floatingLabelBehavior,
      floatingLabelAlignment: customDecoration.floatingLabelAlignment,
      isCollapsed: customDecoration.isCollapsed,
      isDense: customDecoration.isDense,
      prefixIcon: customDecoration.prefixIcon,
      prefix: customDecoration.prefix,
      prefixText: customDecoration.prefixText,
      prefixIconConstraints: customDecoration.prefixIconConstraints,
      prefixStyle: customDecoration.prefixStyle,
      prefixIconColor: customDecoration.prefixIconColor,
      suffixIcon: customDecoration.suffixIcon,
      suffix: customDecoration.suffix,
      suffixText: customDecoration.suffixText,
      suffixStyle: customDecoration.suffixStyle,
      suffixIconColor: customDecoration.suffixIconColor,
      suffixIconConstraints: customDecoration.suffixIconConstraints,
      counter: customDecoration.counter,
      counterText: customDecoration.counterText,
      counterStyle: customDecoration.counterStyle,
      filled: customDecoration.filled,
      fillColor: customDecoration.fillColor,
      focusColor: customDecoration.focusColor,
      hoverColor: customDecoration.hoverColor,
      errorBorder: customDecoration.enabledBorder,
      focusedBorder: customDecoration.focusedBorder,
      focusedErrorBorder: customDecoration.focusedErrorBorder,
      disabledBorder: customDecoration.disabledBorder,
      enabledBorder: customDecoration.enabledBorder,
      border: customDecoration.border,
      enabled: customDecoration.enabled,
      semanticCounterText: customDecoration.semanticCounterText,
      alignLabelWithHint: customDecoration.alignLabelWithHint,
      constraints: customDecoration.constraints,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      decoration: _inputDecoration?.copyWith(
          suffixIconConstraints: const BoxConstraints(minWidth: 24),
          suffixIcon: SizedBox(
            height: 52, // Đảm bảo chiều cao nhất quán cho suffix icon
            child: widget.obscureText
                ? Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 24,
                          color: AppColors.gray60,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(
                        widget.decoration.suffixIcon != null ? 8 : 0),
                    child:
                        widget.decoration.suffixIcon ?? const SizedBox.shrink(),
                  ),
          )),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.style ?? AppTypography.s14.withColor(AppColors.black),
      strutStyle: widget.strutStyle,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autoFocus,
      autocorrect: widget.autocorrect,
      showCursor: widget.showCursor,
      readOnly: widget.readOnly,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: _obscureText,
      enableSuggestions: widget.enableSuggestions,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth ?? 2.0,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor ?? AppColors.gray40,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      autofillHints: widget.autofillHints,
      scrollPhysics: widget.scrollPhysics,
      autovalidateMode: widget.autovalidateMode,
      scrollController: widget.scrollController,
      expands: widget.expands,
    );
  }
}
