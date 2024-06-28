import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/controller/login_controller.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';

class LoginPage extends StatelessWidget {
  final double _deviceHeight, _deviceWidth;
  final controller = Get.find<LoginController>();
  LoginPage({super.key})
      : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppTheme.whiteColor,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              BackgroundEclipseGradient(
                colors: [
                  AppTheme.celadonGreenColor.withAlpha(150),
                  AppTheme.whiteColor.withAlpha(5),
                ],
              ),
              Container(
                height: _deviceHeight,
                width: _deviceWidth,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceWidth * 0.1,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _appLogoWidget(),
                      const SizedBox(height: 45),
                      GetBuilder<LoginController>(
                        id: 'email',
                        builder: (controller) {
                          return CustomTextField(
                            textController: controller.emailController,
                            labelText: "Email",
                            errorText: controller.emailError,
                            iconPath: "assets/icons/edit_icon.svg",
                            keyboardType: TextInputType.emailAddress,
                            onFocusChange: (isFocused) {
                              if (!isFocused) {
                                controller.validateEmail();
                              }
                            },
                            onChanged: (value) {
                              if (controller.emailError != null) {
                                controller.clearEmailError();
                              }
                            },
                          );
                        },
                      ),
                      GetBuilder<LoginController>(
                        id: 'phone',
                        builder: (controller) {
                          return CustomTextField(
                            textController: controller.phoneController,
                            labelText: "Mobile Number",
                            errorText: controller.phoneError,
                            keyboardType: TextInputType.phone,
                            onFocusChange: (isFocused) {
                              if (!isFocused) {
                                controller.validatePhone();
                              }
                            },
                            onChanged: (value) {
                              if (controller.phoneError != null) {
                                controller.clearPhoneError();
                              }
                            },
                          );
                        },
                      ),
                      GetBuilder<LoginController>(
                        id: 'password',
                        builder: (controller) => CustomTextField(
                          textController: controller.passwordController,
                          obscureText: controller.hidePassword,
                          labelText: "Password",
                          errorText: controller.passwordError,
                          iconPath: (controller.hidePassword)
                              ? "assets/icons/visibility_off.svg"
                              : "assets/icons/visibility_on.svg",
                          onIconPressed: () {
                            controller.toggleShowPassword();
                          },
                          onFocusChange: (isFocused) {
                            if (!isFocused) {
                              controller.validatePassword();
                            }
                          },
                          onChanged: (value) {
                            if (controller.passwordError != null) {
                              controller.clearPasswordError();
                            }
                          },
                        ),
                      ),
                      _loginButton(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _rememberMeButton(),
                          _forgotPasswordButton(),
                        ],
                      ),
                      SizedBox(
                        height: _deviceHeight * 0.13,
                      ),
                      _createAccountButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _appLogoWidget() {
    return Container(
      height: _deviceHeight * 0.16,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/healthy_food_logo.png",
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        controller.checkCredentials().then(
          (result) {
            if (result == true) {
              Get.offNamed('/home');
            }
          },
        );
      },
      height: 35,
      minWidth: _deviceWidth,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      color: AppTheme.celadonGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppTheme.summerGreenColor,
          width: 1,
        ),
      ),
      child: Text(
        "Log in",
        style: AppTheme.buttonTextStyle,
      ),
    );
  }

  Widget _rememberMeButton() {
    return TextButton(
      onPressed: () {
        controller.toggleRememberMe();
      },
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 5),
        ),
        overlayColor: WidgetStatePropertyAll(
          AppTheme.pepperMintColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<LoginController>(
            id: 'remember_me',
            builder: (controller) => Icon(
              (controller.rememberMe)
                  ? Icons.check_circle_outline
                  : Icons.circle_outlined,
              size: 15,
              color: AppTheme.camaroneColor,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "Remember Me",
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.camaroneColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return TextButton(
      onPressed: () {
        Get.toNamed('/forgot_password');
      },
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8),
        ),
        overlayColor: WidgetStatePropertyAll(
          AppTheme.pepperMintColor,
        ),
      ),
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontFamily: "Cabin",
          fontSize: 13,
          color: AppTheme.camaroneColor,
        ),
      ),
    );
  }

  Widget _createAccountButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed('/signup');
      },
      height: 35,
      minWidth: _deviceWidth,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      color: AppTheme.pepperMintColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppTheme.springRainColor,
          width: 1,
        ),
      ),
      child: Text(
        "Create new account",
        style: AppTheme.buttonTextStyle,
      ),
    );
  }
}
