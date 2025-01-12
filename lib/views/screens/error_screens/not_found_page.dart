
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/themes/styles/app_text_styles.dart';
import '../../widgets/common/app_buttons.dart';



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
                AppButtons.primary(
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
