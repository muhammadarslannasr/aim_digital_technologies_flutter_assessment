import 'package:aim_digital_technologies_test_flutter/utils/app_colors.dart';
import 'package:aim_digital_technologies_test_flutter/utils/constants.dart';
import 'package:aim_digital_technologies_test_flutter/utils/svg_images.dart';
import 'package:aim_digital_technologies_test_flutter/utils/utils.dart';
import 'package:aim_digital_technologies_test_flutter/view_model/login_cubit.dart';
import 'package:aim_digital_technologies_test_flutter/views/home/home_view.dart';
import 'package:aim_digital_technologies_test_flutter/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginCubitSuccessState) {
          var snackBar = SnackBar(
              content: Text(
            state.authStatus == AuthStatus.login
                ? Constants.loginSuccessfully
                : Constants.registerSuccessfully,
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (Route<dynamic> route) => false,
          );
        }

        if (state is LoginCubitFailureState) {
          var snackBar = SnackBar(content: Text(state.errMsg));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.gradientFirstColor,
                      AppColors.gradientSecondColor
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Constants.heading,
                      style: TextStyle(
                          color: AppColors.loginTxtColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 41.sp),
                    ),
                    SizedBox(height: 130.h),
                    BlocBuilder<LoginCubit, LoginCubitState>(
                      builder: (context, state) {
                        return TextFormFieldWidget(
                          hintText: Constants.email,
                          prefixImage: SvgImages.email,
                          errorText: state.email.isEmpty ||
                                  Utils.isValidEmail(state.email)
                              ? ""
                              : Constants.emailInValidTxt,
                          prefixIconWidth: 16.67.w,
                          prefixIconHeight: 16.67.h,
                          onTextChanged: (v) => context
                              .read<LoginCubit>()
                              .onEmailTextChange(email: v),
                        );
                      },
                    ),
                    BlocBuilder<LoginCubit, LoginCubitState>(
                      builder: (context, state) {
                        return TextFormFieldWidget(
                          hintText: Constants.password,
                          prefixImage: SvgImages.password,
                          prefixIconWidth: 13.33.w,
                          prefixIconHeight: 16.67.h,
                          errorText: state.password.isEmpty ||
                                  Utils.passwordLength(state.password)
                              ? ""
                              : Constants.passwordIsValidTxt,
                          obSecureText: true,
                          onTextChanged: (v) => context
                              .read<LoginCubit>()
                              .onPasswordTextChange(password: v),
                        );
                      },
                    ),
                    SizedBox(height: 50.h),
                    BlocBuilder<LoginCubit, LoginCubitState>(
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: disableButton(state)
                                ? null
                                : () {
                                    if (!context
                                        .read<LoginCubit>()
                                        .state
                                        .loading) {
                                      context.read<LoginCubit>().login();
                                    }
                                  },
                            child: Container(
                              alignment: Alignment.center,
                              width: 184.w,
                              height: 39.h,
                              decoration: BoxDecoration(
                                  color: disableButton(state)
                                      ? Colors.grey
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: context.watch<LoginCubit>().state.loading
                                  ? Center(
                                      child: Transform.scale(
                                        scale: 0.5,
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    )
                                  : Text(
                                      Constants.login,
                                      style: TextStyle(
                                          color: AppColors.buttonTxtColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool disableButton(LoginCubitState state) {
    bool emailValid = Utils.isValidEmail(state.email);
    bool passwordValid = Utils.passwordLength(state.password);

    return emailValid && passwordValid ? false : true;
  }
}
