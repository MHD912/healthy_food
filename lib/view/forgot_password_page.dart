import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';
import 'package:healthy_food/controller/forgot_password_controller.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';

class ForgotPasswordPage extends StatelessWidget {
  final controller = Get.find<ForgotPasswordController>();
  final double _deviceHeight, _deviceWidth;
  ForgotPasswordPage({super.key})
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
        appBar: _appBar(),
        body: Stack(
          children: [
            BackgroundEclipseGradient(
              colors: [
                AppTheme.celadonGreenColor.withAlpha(150),
                AppTheme.whiteColor.withAlpha(5),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                height: _deviceHeight,
                width: _deviceWidth,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceWidth * 0.06,
                ),
                child: Column(
                  children: [
                    _appLogoWidget(),
                    const SizedBox(height: 35),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forgot your password?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          color: AppTheme.camaroneColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '''Write your email below and submit it. 
If the email has an account connected to it, we 
will send you a link for resetting your password!''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _deviceHeight * 0.05,
                    ),
                    _emailTextField(),
                    SizedBox(
                      height: _deviceHeight * 0.2,
                    ),
                    Column(
                      children: [
                        _submitButton(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 13,
                                color: AppTheme.camaroneColor,
                              ),
                            ),
                            _signupButton(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            "assets/icons/back_button.svg",
          ),
        ),
      ),
      leadingWidth: 50,
    );
  }

  Widget _emailTextField() {
    return GetBuilder<ForgotPasswordController>(
      id: 'email',
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextField(
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
          ),
        );
      },
    );
  }

  Widget _appLogoWidget() {
    return Container(
      height: _deviceHeight * 0.14,
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/healthy_food_logo.png",
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          controller.checkCredentials().then(
            (result) {
              if (result == true) {
                Get.offNamed('/login');
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
          "Submit",
          style: AppTheme.buttonTextStyle,
        ),
      ),
    );
  }

  Widget _signupButton() {
    return TextButton(
      onPressed: () {
        Get.offNamed('/signup');
      },
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: const WidgetStatePropertyAll(
          EdgeInsets.zero,
        ),
        overlayColor: WidgetStatePropertyAll(
          AppTheme.pepperMintColor,
        ),
      ),
      child: Text(
        "Signup",
        style: TextStyle(
          fontFamily: "Cabin",
          fontSize: 13,
          color: AppTheme.forestGreenColor,
        ),
      ),
    );
  }
}
