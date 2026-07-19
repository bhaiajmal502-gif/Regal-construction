import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';

class PremiumButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const PremiumButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isDisabled || widget.isLoading ? null : _handleTapDown,
      onTapUp: widget.isDisabled || widget.isLoading ? null : _handleTapUp,
      onTapCancel: widget.isDisabled || widget.isLoading ? null : _handleTapCancel,
      onTap: widget.isDisabled || widget.isLoading ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: !widget.isDisabled
                ? AppColors.premiumGradient
                : LinearGradient(
                    colors: [
                      AppColors.textTertiary.withOpacity(0.3),
                      AppColors.textTertiary.withOpacity(0.3),
                    ],
                  ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: !widget.isDisabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isDisabled || widget.isLoading
                  ? null
                  : widget.onPressed,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Padding(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingMedium,
                      vertical: AppSpacing.paddingSmall,
                    ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading) ...,
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.textColor ?? Colors.white,
                        ),
                      ),
                    )
                    else if (widget.icon != null) ...,
                    Icon(
                      widget.icon,
                      color: widget.textColor ?? Colors.white,
                      size: 20,
                    ),
                    if (widget.icon != null)
                      const SizedBox(width: AppSpacing.marginSmall),
                    Flexible(
                      child: Text(
                        widget.text,
                        style: AppTypography.titleMedium.copyWith(
                          color: widget.textColor ?? Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
