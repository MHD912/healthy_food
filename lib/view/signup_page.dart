import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/controller/signup_controller.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';
import 'package:healthy_food/core/widget/image_picker_dialog.dart';

class SignupPage extends StatelessWidget {
  final double _deviceHeight, _deviceWidth;
  final controller = Get.find<SignupController>();

  SignupPage({super.key})
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BackgroundEclipseGradient(
                radius: 0.9,
                colors: [
                  AppTheme.celadonGreenColor.withAlpha(255),
                  AppTheme.whiteColor.withAlpha(200),
                ],
              ),
              Container(
                height: _deviceHeight,
                width: _deviceWidth,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceWidth * 0.1,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _selectProfilePicture(),
                    const SizedBox(height: 45),
                    const CustomTextField(
                      text: "Username",
                    ),
                    CustomTextField(
                      text: "Email",
                      iconPath: "assets/icons/edit_icon.svg",
                      onIconPressed: () {},
                    ),
                    const CustomTextField(
                      text: "Mobile Number",
                    ),
                    GetBuilder<SignupController>(
                      id: 'password',
                      builder: (controller) => CustomTextField(
                        text: "Password",
                        iconPath: (controller.showPassword)
                            ? "assets/icons/visibility_on.svg"
                            : "assets/icons/visibility_off.svg",
                        onIconPressed: () {
                          controller.toggleShowPassword();
                        },
                      ),
                    ),
                    GetBuilder<SignupController>(
                      id: 'confirm_password',
                      builder: (controller) {
                        return CustomTextField(
                          text: "Confirm Password",
                          iconPath: (controller.showConfirmPassword)
                              ? "assets/icons/visibility_on.svg"
                              : "assets/icons/visibility_off.svg",
                          onIconPressed: () {
                            controller.toggleShowConfirmPassword();
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: _deviceHeight * 0.13,
                      child: Column(
                        children: [
                          _selectCertificateButton(),
                          _showPickedCertificate(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _signupButton(),
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
                        _loginButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder<SignupController> _showPickedCertificate() {
    return GetBuilder<SignupController>(
      id: 'certificate',
      builder: (controller) {
        if (controller.certificate != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.certificate!.name,
                style: const TextStyle(
                  fontFamily: 'Cabin',
                  fontSize: 14,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.clearCertificate();
                },
                visualDensity: VisualDensity.compact,
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _selectCertificateButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: MaterialButton(
        onPressed: () {
          controller.pickFile();
        },
        color: AppTheme.textFieldFillColor,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppTheme.textFieldBorderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Certificate PDF file",
              style: TextStyle(
                fontFamily: "Cabin",
                fontSize: 13,
                color: AppTheme.springRainColor,
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              "assets/icons/cloud_upload.svg",
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _selectProfilePicture() {
    return MaterialButton(
      onPressed: () {
        ImagePickerDialog.showDialog();
      },
      shape: const CircleBorder(),
      child: GetBuilder<SignupController>(
        id: 'profile_picture',
        builder: (controller) {
          if (controller.image != null) {
            return Container(
              height: _deviceHeight * 0.14,
              width: _deviceHeight * 0.14,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(controller.image!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return SvgPicture.asset(
              "assets/icons/camera_in_circle.svg",
              height: _deviceHeight * 0.14,
            );
          }
        },
      ),
    );
  }

  Widget _signupButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed('/authentication');
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
        "Sign up",
        style: AppTheme.buttonTextStyle,
      ),
    );
  }

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        Get.offAllNamed('/login');
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
        "Login",
        style: TextStyle(
          fontFamily: "Cabin",
          fontSize: 13,
          color: AppTheme.forestGreenColor,
        ),
      ),
    );
  }
}
