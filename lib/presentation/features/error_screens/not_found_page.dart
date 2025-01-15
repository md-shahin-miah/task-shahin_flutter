import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shahin_appify_task/core/themes/styles/app_text_styles.dart';
import 'package:shahin_appify_task/presentation/widgets/button/custom_secondary_button.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Oops!',
                  style: AppTextStyles.h1,
                ),
                const SizedBox(height: 10),
                Text(
                  "The page you are looking for doesn't seem to exist.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 30),
                CustomSecondaryButton.secondary(
                  width: 200,
                  onTap: () {
                    context.pop();
                  },
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
}
