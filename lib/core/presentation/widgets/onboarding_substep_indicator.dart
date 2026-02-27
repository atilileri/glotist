import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';

/// Horizontal indicator for substeps within an onboarding screen.
///
/// Renders a row of numbered circles connected by lines, showing completion
/// state for each substep (e.g. Interests → Level → Purpose).
class OnboardingSubstepIndicator extends StatelessWidget {
  /// Creates an [OnboardingSubstepIndicator] instance.
  const OnboardingSubstepIndicator({
    required this.currentSubstep,
    required this.labels,
    super.key,
  });

  /// The 0-indexed currently active substep. All substeps before this index
  /// are considered completed.
  final int currentSubstep;

  /// Labels for each substep.
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.s12,
      ),
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++) ...[
            _buildStep(
              context,
              index: i,
              label: labels[i],
              colorScheme: colorScheme,
            ),
            if (i < labels.length - 1)
              Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxs,
                  ),
                  color: i < currentSubstep
                      ? colorScheme.primary.withValues(alpha: 0.3)
                      : colorScheme.outline,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required int index,
    required String label,
    required ColorScheme colorScheme,
  }) {
    final isCompleted = index < currentSubstep;
    final isActive = index == currentSubstep;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circle
        Container(
          width: AppSpacing.s20,
          height: AppSpacing.s20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? colorScheme.primary
                : isActive
                    ? colorScheme.surface
                    : colorScheme.surfaceContainerHighest,
            border: isActive
                ? Border.all(color: colorScheme.primary, width: 2)
                : isCompleted
                    ? null
                    : Border.all(color: colorScheme.outline),
          ),
          child: Center(
            child: isCompleted
                ? Icon(
                    Icons.check,
                    size: AppSpacing.s14,
                    color: colorScheme.onPrimary,
                  )
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: AppSpacing.s10,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: AppSpacing.xxs),

        // Label
        Text(
          label,
          style: TextStyle(
            fontSize: AppSpacing.s11,
            fontWeight:
                isCompleted || isActive ? FontWeight.bold : FontWeight.w500,
            color: isCompleted
                ? colorScheme.primary
                : isActive
                    ? colorScheme.onSurface
                    : colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
