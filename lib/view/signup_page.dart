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
        body: SafeArea(
          bottom: false,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectProfilePicture(),
                      const SizedBox(height: 45),
                      GetBuilder<SignupController>(
                        id: 'username',
                        builder: (controller) {
                          return CustomTextField(
                            textController: controller.usernameController,
                            labelText: "Username",
                            errorText: controller.usernameError,
                            onFocusChange: (isFocused) {
                              if (!isFocused) {
                                controller.validateUsername();
                              }
                            },
                            onChanged: (value) {
                              if (controller.usernameError != null) {
                                controller.clearUsernameError();
                              }
                            },
                          );
                        },
                      ),
                      GetBuilder<SignupController>(
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
                      GetBuilder<SignupController>(
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
                      GetBuilder<SignupController>(
                        id: 'password',
                        builder: (controller) {
                          return CustomTextField(
                            textController: controller.passwordController,
                            labelText: "Password",
                            errorText: controller.passwordError,
                            obscureText: controller.hidePassword,
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
                          );
                        },
                      ),
                      GetBuilder<SignupController>(
                        id: 'confirm_password',
                        builder: (controller) {
                          return CustomTextField(
                            textController:
                                controller.confirmPasswordController,
                            labelText: "Confirm Password",
                            errorText: controller.confirmPasswordError,
                            obscureText: controller.hidePassword,
                            iconPath: (controller.hideConfirmPassword)
                                ? "assets/icons/visibility_off.svg"
                                : "assets/icons/visibility_on.svg",
                            onIconPressed: () {
                              controller.toggleShowConfirmPassword();
                            },
                            onFocusChange: (isFocused) {
                              if (!isFocused) {
                                controller.validateConfirmPassword();
                              }
                            },
                            onChanged: (value) {
                              if (controller.confirmPasswordError != null) {
                                controller.clearConfirmPasswordError();
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: _deviceHeight * 0.12,
                        child: Column(
                          children: [
                            _selectCertificateButton(),
                            _showPickedCertificate(),
                          ],
                        ),
                      ),
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
      padding: const EdgeInsets.only(top: 5),
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
              height: _deviceHeight * 0.11,
              width: _deviceHeight * 0.11,
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
              height: _deviceHeight * 0.11,
            );
          }
        },
      ),
    );
  }

  Widget _signupButton() {
    return MaterialButton(
      onPressed: () {
        controller.checkCredentials().then(
          (result) {
            if (result == true) {
              Get.toNamed('/authentication');
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
