import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fourfiles/helper/route_helper.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/view/widgets/textinput_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController useremail = TextEditingController();
  TextEditingController userpass = TextEditingController();

  @override
  void dispose() {
    
    super.dispose();
    useremail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        padding: EdgeInsets.only(
            top: Get.height * 0.1,
            left: Dimensions.paddingSizeDefault,
            right: Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Registration 👍",
                      style: TextStyle(
                          fontSize: Dimensions.fontSizeOverLarge,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: Get.width * 0.5,
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's Register, and start browsing",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeDefault),
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextField(
                        hintText: 'firstname',
                        controller: useremail,
                        // errorText: "Please enter your email",
                        borderColor: Theme.of(context).highlightColor,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'lastname',
                        controller: useremail,
                        // errorText: "Please enter your email",
                        borderColor: Theme.of(context).highlightColor,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'email', controller: userpass,

                        // errorText: "Please enter your email",
                        borderColor: Theme.of(context).highlightColor,
                      ),
                      const SizedBox(height: 10),
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
                    onPressed: () async {},
                    child: Text('Register',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Get.toNamed(RouteHelper.auth),
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
                              text: ' Login',
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
    );
  
  }
}
