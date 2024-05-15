import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fourfiles/controller/auth_controller.dart';
import 'package:fourfiles/helper/route_helper.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/view/widgets/dialog_helper.dart';
import 'package:fourfiles/view/widgets/loading_widget.dart';
import 'package:fourfiles/view/widgets/textinput_widget.dart';
import 'package:fourfiles/view/widgets/toaster_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController useremail = TextEditingController();
  TextEditingController userpass = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    useremail.dispose();
    userpass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          padding: EdgeInsets.only(
              top: Get.height * 0.1,
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign in Account 👍",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeOverLarge,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: Get.width * 0.5,
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Let's Sign in, and start surveying",
                          style: TextStyle(
                              fontSize: 16, color: Theme.of(context).hintColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeDefault),
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextField(
                            hintText: 'email', controller: useremail,

                            // errorText: "Please enter your email",
                            borderColor: Theme.of(context).highlightColor,
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            hintText: 'password', controller: userpass,
                            isPassword: true,

                            // errorText: "Please enter your email",
                            borderColor: Theme.of(context).highlightColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radiusSmall),
                            ),
                          ),
                          shadowColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          if (useremail.text.isEmpty) {
                            Toaster(
                                    type: ToasterType.error,
                                    message: 'Pleaser enter your email')
                                .show(context);
                          } else if (userpass.text.isEmpty) {
                            Toaster(
                                    type: ToasterType.error,
                                    message: 'Pleaser enter your password')
                                .show(context);
                          } else {
                            DialogHelper.showGeneralDialog(
                              context,
                              child: LoadingWidget(),
                            );

                            await authController
                                .login(context,
                                    email: useremail.text,
                                    password: userpass.text)
                                .then((res) => {
                                      if (res)
                                        {
                                          Get.offAllNamed(
                                              RouteHelper.dashboard),
                                          Toaster(
                                                  type: ToasterType.success,
                                                  message:
                                                      'User Authenticated Successfuly')
                                              .show(context)
                                        }
                                      else
                                        {
                                          Toaster(
                                                  type: ToasterType.error,
                                                  message:
                                                      'Wrong email or password')
                                              .show(context)
                                        }
                                    });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: Dimensions.paddingSizeExtraLarge),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => Get.toNamed(
                            RouteHelper.register,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Have an account?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: ' Register',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
