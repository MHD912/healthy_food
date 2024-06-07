import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';
import 'package:healthy_food/core/widget/success_bottom_sheet.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
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
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                height: deviceHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
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
                        CustomTextField(
                          text: "Password",
                          iconPath: "assets/icons/visibility_off.svg",
                          onIconPressed: () {},
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
                      ],
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
      height: 140,
      // width: 200,
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
      onPressed: () {
        // showDialog(
        //   context: context,
        //   barrierColor: AppTheme.whiteColor.withOpacity(0.5),
        //   builder: (context) {
        //     return const WarningDialog();
        //   },
        // );
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return const SuccessBottomSheet();
          },
        );
      },
      height: 35,
      minWidth: double.infinity,
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
      onPressed: () {},
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
          Icon(
            // isChecked
            //     ? Icons.check_circle_outline
            //     : Icons.circle_outlined,
            Icons.check_circle_outline,
            size: 13,
            color: AppTheme.camaroneColor,
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
      minWidth: double.infinity,
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
