import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:shahin_appify_task/core/routes/go_route_context_extension.dart';
import 'package:shahin_appify_task/core/utils/snackbar/snackbar_service.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/presentation/features/auth/login_screen/login_screen_view_model.dart';
import 'package:shahin_appify_task/presentation/features/home/feed_screen/feeds_screen_view_model.dart';

import '../../../../../core/themes/styles/app_colors.dart';
import '../../feed_screen/widget/comment_bottom_sheet.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: AppColors.white,
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
                    builder: (context, ref, child) {
                      observer(ref,context);
                      return TextButton(
                      onPressed: () {
                        ref
                            .read(authProviderLogout.notifier)
                            .logOut();
                        ref.invalidate(feedFutureProvider);
                        ref.invalidate(replyFutureProvider);
                        ref.invalidate(commentFutureProvider);
                        ref.invalidate(reactionFutureProvider);
                        ref.invalidate(feedProvider);
                        SharePreferenceUtil.setRememberMe(false);

                        controllerComment.text = "";

                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    );}
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

  void observer(WidgetRef ref,BuildContext context) {
    ref.listen<DataState>(authProviderLogout, (_, state) {
      state.maybeWhen(
        success: (user) {

          context.goToLoginPage();
        },
        error: (err, _) {
          debugPrint(err);
          ToastService.showToast(title: err, backgroundColor: AppColors.colorError);
        },
        orElse: () {},
      );
    });

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