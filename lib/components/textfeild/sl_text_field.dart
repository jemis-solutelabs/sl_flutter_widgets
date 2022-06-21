import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Base wrapper of [TextFormField] with its common APIs.
class SLTextField extends StatefulWidget {
  /// Initializes base text field.
  const SLTextField({
    required this.controller,
    required this.labelText,
    required this.inputFiledTextStyle,
    required this.labelTextStyle,
    this.enabledTextColor,
    this.disabledTextColor,
    this.commonOutlineBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.commonFocusedOutlineBorderColor,
    this.enabledBorderRadius,
    this.errorBorderRadius,
    this.focusedBorderRadius,
    this.focusedErrorBorderRadius,
    this.labelDefaultFocusColor,
    this.labelDefaultErrorColor,
    this.labelDefaultColor,
    this.labelColor,
    this.initialValue,
    this.borderColor,
    this.focusNode,
    this.focusedLabelColor,
    this.focusedBorderColor,
    this.suffixIcon,
    this.formFieldKey,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.errorMaxLines = 2,
    this.onEditingComplete,
    this.onChanged,
    this.onTap,
    Key? key,
  }) : super(key: key);

  /// Text field controller.
  final TextEditingController controller;

  /// Text field label text.
  final String? labelText;

  /// Text field label color when its not focused.
  final Color? labelColor;

  /// Initial value of text field.
  final String? initialValue;

  /// Text field border color when its not focused.
  final Color? borderColor;

  /// Text field focus node.
  final FocusNode? focusNode;

  /// Form field key.
  final GlobalKey<FormFieldState<String>>? formFieldKey;

  /// Text field label color when its focused.
  final Color? focusedLabelColor;

  /// Text field border color when its focused.
  final Color? focusedBorderColor;

  /// Suffix icon widget.
  final Widget? suffixIcon;

  /// Text field textInputAction.
  final TextInputAction? textInputAction;

  /// text input type.
  final TextInputType? keyboardType;

  /// Indicates is text field obscure.
  final bool obscureText;

  /// Indicates whether this text field should be readOnly or not.
  final bool readOnly;

  /// Indicates whether this text field should be enabled or not.
  final bool enabled;

  /// Error max lines.
  final int errorMaxLines;

  /// Input max length.
  final int? maxLength;

  /// List of input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// validator function of text field.
  final String? Function(String?)? validator;

  /// onEditingComplete callback of text field.
  final VoidCallback? onEditingComplete;

  /// onChanged callback of text field.
  final void Function(String)? onChanged;

  /// onTap callback function.
  final VoidCallback? onTap;

  /// TextStyle for Input text field.
  final TextStyle inputFiledTextStyle;

  /// TextStyle for Input text field label.
  final TextStyle? labelTextStyle;

  /// Enabled  Input text field color.
  final Color? enabledTextColor;

  /// Disabled Input text field color.
  final Color? disabledTextColor;

  /// Common app color for border.
  final Color? commonOutlineBorderColor;

  /// Common app color for focused border.
  final Color? commonFocusedOutlineBorderColor;

  /// Common app color for focused error border.
  final Color? focusedErrorBorderColor;

  /// Common app color for error border.
  final Color? errorBorderColor;

  /// Default focus color for the label at the top of the text field.
  final Color? labelDefaultFocusColor;

  /// Default error color for the label at the top of the text field.
  final Color? labelDefaultErrorColor;

  /// Default color for the label at the top of the text field.
  final Color? labelDefaultColor;

  /// Border radius for enabled text filed.
  final double? enabledBorderRadius;

  /// Border radius for focused text filed.
  final double? focusedBorderRadius;

  /// Border radius for error text filed.
  final double? errorBorderRadius;

  /// Border radius for focused error text filed.
  final double? focusedErrorBorderRadius;

  @override
  _SLTextFieldState createState() => _SLTextFieldState();
}

class _SLTextFieldState extends State<SLTextField> {
  GlobalKey<FormFieldState<String>>? _formFieldKey;
  bool _hasError = false;

  @override
  void initState() {
    widget.focusNode?.addListener(() => _handleFocusChange);
    _formFieldKey = widget.formFieldKey ??
        (widget.validator == null ? null : GlobalKey<FormFieldState<String>>());
    super.initState();
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        key: _formFieldKey,
        controller: widget.controller,
        initialValue: widget.initialValue,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        autocorrect: false,
        style: widget.inputFiledTextStyle.copyWith(
          color: widget.enabled
              ? widget.enabledTextColor
              : widget.disabledTextColor,
        ),
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
            ),
            borderRadius:
                BorderRadius.circular(widget.enabledBorderRadius ?? 10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? Colors.transparent,
            ),
            borderRadius:
                BorderRadius.circular(widget.focusedBorderRadius ?? 10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.errorBorderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(widget.errorBorderRadius ?? 10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.focusedErrorBorderColor ?? Colors.transparent),
            borderRadius:
                BorderRadius.circular(widget.focusedErrorBorderRadius ?? 10),
          ),
          labelStyle: widget.labelTextStyle?.copyWith(
            color: _hasError
                ? Colors.transparent
                : (widget.focusNode?.hasFocus ?? false)
                    ? widget.focusedLabelColor ?? Colors.transparent
                    : widget.labelColor ?? Colors.transparent,
          ),
          errorMaxLines: widget.errorMaxLines,
          counterText: '',
        ).copyWith(suffixIcon: widget.suffixIcon),
        validator: (String? input) {
          final String? errorMsg = widget.validator?.call(input);
          setState(() => _hasError = errorMsg != null);

          return errorMsg;
        },
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        onEditingComplete: widget.onEditingComplete,
        onChanged: _onChanged,
        onTap: widget.onTap,
      );

  void _onChanged(String input) {
    _formFieldKey?.currentState?.validate();
    widget.onChanged?.call(input);
  }
}
