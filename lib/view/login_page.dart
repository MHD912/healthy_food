import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/controller/login_controller.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';

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
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundEclipseGradient(
              colors: [
                AppTheme.celadonGreenColor.withAlpha(150),
                AppTheme.whiteColor.withAlpha(5),
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.1,
              ),
              child: Container(
                height: _deviceHeight,
                width: _deviceWidth,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _appLogoWidget(),
                    const SizedBox(height: 45),
                    const CustomTextField(
                      text: "Email",
                      iconPath: "assets/icons/edit_icon.svg",
                    ),
                    const CustomTextField(
                      text: "Mobile Number",
                    ),
                    GetX<LoginController>(
                      builder: (controller) => CustomTextField(
                        text: "Password",
                        iconPath: (controller.showPassword.value)
                            ? "assets/icons/visibility_on.svg"
                            : "assets/icons/visibility_off.svg",
                        onIconPressed: () {
                          controller.toggleShowPassword();
                        },
                      ),
                    ),
                    _loginButton(context),
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

  Widget _loginButton(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await controller.setToken();
        Get.offNamed('/home');
        // Get.dialog(
        //   const WarningDialog(),
        //   barrierColor: AppTheme.whiteColor.withOpacity(0.6),
        // );
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
          GetX<LoginController>(
            builder: (controller) => Icon(
              (controller.rememberMe.value)
                  ? Icons.check_circle_outline
                  : Icons.circle_outlined,
              size: 13,
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
      onPressed: () {},
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
