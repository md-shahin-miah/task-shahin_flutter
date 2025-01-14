import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/core/routes/go_route_context_extension.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';
import 'package:shahin_appify_task/presentation/features/auth/login_screen/login_screen_view_model.dart';

import '../../../../../core/themes/styles/app_colors.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.textColorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Are you sure, you want to log\nout?',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              color: AppColors.fillColor3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) =>  TextButton(
                      onPressed: () {
                        ref
                            .read(authProviderLogin.notifier)
                            .logOut();
                       context.goToLoginPage();
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: AppColors.creamColor),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: AppColors.fillColor3,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(color: AppColors.textColorBlack2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showLogoutConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return LogoutDialog();
    },
  );
}