import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';

/// A beautifully themed widget that replaces Flutter's default red error
/// screen.
///
/// This is used globally via [ErrorWidget.builder] to catch any build phase
/// exceptions and present a clean "Something went wrong" UI.
class AppErrorBoundary extends StatelessWidget {
  /// Creates a [AppErrorBoundary] instance.
  const AppErrorBoundary({
    required this.details,
    super.key,
  });

  /// The details of the error that caused this boundary to trigger.
  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    // We wrap in Material to ensure text styles and background work out
    // of the box even if the error happens outside the Scaffold scope.
    return Material(
      color: context.colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: context.colorScheme.error,
                size: AppSpacing.section,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Oops! Something went wrong.',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'An unexpected rendering error occurred.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              // In debug mode, we can show the actual error to the developer.
              // In release mode this will be hidden.
              if (!const bool.fromEnvironment('dart.vm.product')) ...[
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                  child: Text(
                    details.exceptionAsString(),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onErrorContainer,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
