import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fourfiles/util/dimensiona.dart';

class SignOutWarningWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() onTap;
  const SignOutWarningWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: Get.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.8,
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusLarge),
                    topRight: Radius.circular(Dimensions.radiusLarge),
                  ),
                  color: Theme.of(context).primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Padding(
              padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Center(
                child: Text(
                  
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).hintColor),
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).hintColor,
              height: 0.5,
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: Get.width * 0.35,
                    padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: const BoxDecoration(
                        borderRadius:  BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radiusLarge),
                          bottomRight: Radius.circular(Dimensions.radiusLarge),
                        ),
                        ),
                    child: Center(
                      child: Text(
                        "CANCEL",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                
                GestureDetector(
                  onTap: () => SystemNavigator.pop(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: Get.width * 0.35,
                    padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: const BoxDecoration(
                        borderRadius:  BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radiusLarge),
                          bottomRight: Radius.circular(Dimensions.radiusLarge),
                        ),
                        ),
                    child: Center(
                      child: Text(
                        "SIGN OUT",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
