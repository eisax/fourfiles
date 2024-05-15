import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/view/widgets/dialog_helper.dart';
import 'package:fourfiles/view/widgets/logout_widget.dart';

class MobileAppWraper extends StatefulWidget {
  final Widget child;
  final bool? search;
  final bool? notes;
  final bool notifications;
  final bool profile;

  const MobileAppWraper({super.key, required this.child,  this.search=false,  this.notes=false,  this.notifications=true,  this.profile=true});

  @override
  State<MobileAppWraper> createState() => _MobileAppWraperState();
}

class _MobileAppWraperState extends State<MobileAppWraper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leadingWidth: 130,
        leading: Center(
          child: Text(
            "fourfiles",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        actions: [
          if(widget.search!)
          const Icon(
            Icons.search,
            color: Colors.white,
          ),
          if(widget.search!=null&&widget.search!)
          SizedBox(
            width: Dimensions.paddingSizeSmall,
          ),
          if(widget.notes!=null&&widget.notes!)
          const Icon(
            Icons.notes_sharp,
            color: Colors.white,
          ),
          if(widget.notes!=null&&widget.notes!)
          SizedBox(
            width: Dimensions.paddingSizeSmall,
          ),
          if(widget.notifications)
          const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          if(widget.notifications)
          SizedBox(
            width: Dimensions.paddingSizeSmall,
          ),
          if(widget.profile)
          GestureDetector(
            onTap: () {
              DialogHelper.showGeneralDialog(
                context,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignOutWarningWidget(
                        title: 'ACCOUNT',
                        subtitle: 'eisaxoffice@gmail.com',
                        onTap: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.brown,
              child: Text(
                "K",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          if(widget.profile)
          SizedBox(
            width: Dimensions.paddingSizeDefault,
          ),
        ],
      ),
      body: widget.child,
    );
  }
}
