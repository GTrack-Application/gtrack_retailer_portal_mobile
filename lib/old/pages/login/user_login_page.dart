import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/common/utils/app_dialogs.dart';
import 'package:gtrack_retailer_portal/common/utils/app_navigator.dart';
import 'package:gtrack_retailer_portal/common/utils/app_snakbars.dart';
import 'package:gtrack_retailer_portal/constants/app_preferences.dart';
import 'package:gtrack_retailer_portal/old/domain/services/apis/login/login_services.dart';
import 'package:gtrack_retailer_portal/old/pages/login/activities_and_password_page.dart';
import 'package:gtrack_retailer_portal/old/providers/login/login_provider.dart';
import 'package:gtrack_retailer_portal/screen/scanner/scanning_screen.dart';
import 'package:gtrack_retailer_portal/widgets/buttons/primary_button.dart';
import 'package:gtrack_retailer_portal/widgets/text_field/icon_text_field.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});
  static const String pageName = '/login';

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  login() {
    if (formKey.currentState?.validate() ?? false) {
      AppDialogs.loadingDialog(context);
      LoginServices.login(email: emailController.text).then((response) {
        AppDialogs.closeDialog();
        final activities = response;

        // add email and activities to login provider
        Provider.of<LoginProvider>(context, listen: false)
            .setEmail(emailController.text);
        Provider.of<LoginProvider>(context, listen: false)
            .setActivities(activities);

        AppNavigator.goToPage(
          context: context,
          screen: ActivitiesAndPasswordPage(
            email: emailController.text.trim(),
            activities: activities,
          ),
        );
      }).catchError((error) {
        AppDialogs.closeDialog();
        AppSnackbars.danger(context, error.toString());
      });
    }
  }

  normalUserLogin() async {
    AppDialogs.loadingDialog(context);
    LoginServices.normalUserLogin(
      emailController.text.trim(),
      passwordController.text.trim(),
    ).then((value) {
      AppPreferences.setToken(value.token.toString()).then((_) {});
      AppPreferences.setUserId(value.data!.userID.toString()).then((_) {});

      AppDialogs.closeDialog();
      AppSnackbars.success(context, "Login Successful", 2);
      AppNavigator.replaceTo(context: context, screen: const ScanningScreen());
    }).onError((error, stackTrace) {
      AppDialogs.closeDialog();
      AppSnackbars.danger(context, error.toString());
    });
  }

  String dropdownValue = "Admin User";
  List<String> dropdownList = [
    "Admin User",
    "Normal User",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const AppLogo(width: 200, height: 200),
              const Text(
                'Enter your login ID',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
              ),
              IconTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                // leadingIcon: Image.asset(AppIcons.usernameIcon),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your login ID';
                  }
                  // if (EmailValidator.validate(value)) {
                  //   return null;
                  // } else {
                  //   return 'Please enter a valid email';
                  // }
                  return null;
                },
              ).box.width(context.width * 0.9).make(),
              const SizedBox(height: 20),
              Visibility(
                visible: dropdownValue == "Admin User" ? false : true,
                child: const Text(
                  "Enter your password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
              ),
              Visibility(
                visible: dropdownValue == "Admin User" ? false : true,
                child: IconTextField(
                  controller: passwordController,
                  // leadingIcon: Image.asset(
                  //   AppIcons.passwordIcon,
                  //   width: 42,
                  //   height: 42,
                  // ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButtonWidget(
                onPressed: () {
                  if (dropdownValue.toString() == "Normal User") {
                    normalUserLogin();
                  }
                  if (dropdownValue.toString() == "Admin User") {
                    login();
                  }
                },
                text: "Log in",
              ).box.width(context.width * 0.85).makeCentered(),
            ],
          ).box.p20.make(),
        ),
      ),
    );
  }
}
