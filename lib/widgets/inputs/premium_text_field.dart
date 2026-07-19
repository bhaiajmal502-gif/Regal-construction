import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';

class PremiumTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconTap;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const PremiumTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PremiumTextField> createState() => _PremiumTextFieldState();
}

class _PremiumTextFieldState extends State<PremiumTextField> {
  late FocusNode _focusNode;
  late bool _showPassword;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _showPassword = !widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTypography.labelMedium,
        ),
        const SizedBox(height: AppSpacing.marginSmall),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText && !_showPassword,
          maxLines: widget.obscureText && !_showPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: _focusNode.hasFocus
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.onSuffixIconTap,
                    child: Icon(
                      widget.suffixIcon,
                      color: _focusNode.hasFocus
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  )
                : widget.obscureText
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _focusNode.hasFocus
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      )
                    : null,
            filled: true,
            fillColor: _focusNode.hasFocus
                ? AppColors.primaryLight.withOpacity(0.3)
                : Color(0xFFF3F4F6),
          ),
        ),
      ],
    );
  }
}
