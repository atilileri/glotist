import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Screen where users choose their onboarding path.
class OnboardingChoiceScreen extends StatelessWidget {
  /// Creates an [OnboardingChoiceScreen] instance.
  const OnboardingChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Start Your Journey')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChoiceCard(
                context,
                title: 'Create Profile & Customize',
                description:
                    'Chat with our AI agent to tailor the curriculum to '
                    'your interests and level.',
                icon: Icons.chat_bubble_outline,
                onTap: () async {
                  await context.push('/conversation');
                },
              ),
              const SizedBox(height: 24),
              _buildChoiceCard(
                context,
                title: 'Quick Start',
                description: 'Jump right into a lesson. We will refine your '
                    'profile later.',
                icon: Icons.flash_on,
                isPrimary: false,
                onTap: () {
                  // TODO(dev): Navigate to standard lesson
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                icon,
                size: 48,
                color: isPrimary ? colorScheme.primary : colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
