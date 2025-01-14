import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shahin_appify_task/core/constants/image_assets.dart';
import 'package:shahin_appify_task/core/routes/go_route_context_extension.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';
import 'package:shahin_appify_task/data/state/data_state.dart';
import 'package:shahin_appify_task/presentation/features/auth/login_screen/login_screen_view_model.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../widgets/common/loading_widget.dart';

final passwordObscureTextSignUp = StateProvider((ref) {
  return true;
});
final rememberMeProvider = StateProvider((ref) {
  return false;
});

class LoginScreenView extends ConsumerWidget {
  LoginScreenView({super.key});

  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();

  // bool _rememberMe = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProviderLogin);

    loginObserver(ref, context);

    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: keyboardHeight == 0 ? 4 : 1,
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              width: size.width,
                              child: Image.asset(
                                AppImageAssets.topCircle,
                                height: (size.height - keyboardHeight) / 9,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              width: size.width,
                              child: Image.asset(
                                AppImageAssets.centreCircle,
                                height: (size.height - keyboardHeight) / 9,
                                fit: BoxFit.cover,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AppImageAssets.easyLogo,
                      height: (size.height - keyboardHeight) / 9,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: LayoutBuilder(
                builder: (context, constraints) => Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Email",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _userEmailController,
                            hintText: "Enter your email",
                            isPassword: false,
                            isBorder: true,
                            hintColor: AppColors.lightGray,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Password",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _userPassController,
                            hintText: "Enter your password",
                            hintColor: AppColors.lightGray,
                            isPassword: true,
                            obscureText: ref.watch(passwordObscureTextSignUp),
                            toggleObscure: () {
                              ref
                                      .watch(passwordObscureTextSignUp.notifier)
                                      .state =
                                  !ref
                                      .watch(passwordObscureTextSignUp.notifier)
                                      .state;
                            },
                            isBorder: true,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Checkbox(
                                value: ref.watch(rememberMeProvider),
                                activeColor: AppColors.colorBlue,
                                checkColor: AppColors.lightGray,
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) => ref.watch(rememberMeProvider)
                                      ? AppColors.colorBlue
                                      : AppColors.lightGray,
                                ),
                                onChanged: (bool? value) {
                                  ref.watch(rememberMeProvider.notifier).state =
                                      !ref
                                          .watch(rememberMeProvider.notifier)
                                          .state;
                                },
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  color: ref.watch(rememberMeProvider)
                                      ? AppColors.colorBlue
                                      : AppColors.lightGray,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: authState.maybeWhen(
                              loading: () => const LoadingWidget(),
                              orElse: () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.lime,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  debugPrint("Sign In clicked");

                                  // ref
                                  //     .read(authProviderLogin.notifier)
                                  //     .login("stu@test.io", "123456");

                                  SharePreferenceUtil.setRememberMe(ref.read(rememberMeProvider));

                                  ref.read(authProviderLogin.notifier).login(
                                      _userEmailController.text,
                                      _userPassController.text);
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginObserver(WidgetRef ref, BuildContext context) {
    ref.listen<DataState>(authProviderLogin, (_, state) {
      state.maybeWhen(
        success: (user) {
          context.goToHomePage();
        },
        error: (err, _) {
          debugPrint(err);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err),
              backgroundColor: AppColors.colorError,
            ),
          );
        },
        orElse: () {},
      );
    });
  }
}
