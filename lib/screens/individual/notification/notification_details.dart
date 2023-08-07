import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/notification_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationDetails extends StatefulWidget {
  final String title;
  final String body;
  final String id;
  final String status;
  const NotificationDetails({super.key, required this.title, required this.body, required this.id, required this.status});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  //https://github.com/FagoPay-Development/FagoMobile.git
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  SizedBox(height: 3.h),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: const Image(image: AssetImage("assets/images/Icon.png"))),
                      const AutoSizeText(
                        'Notifications Details',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const Divider(thickness: 2, color: fagoPrimaryColorWithOpacity),
                  const SizedBox(height: 10,),
                  Container(
                      decoration: BoxDecoration(color: fagoSecondaryColorWithOpacity10, borderRadius: BorderRadius.circular(13)),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title ?? "", style: Theme.of(context).textTheme.bodySmall?.
                            copyWith(fontWeight: FontWeight.w400, color: fagoSecondaryColor, fontSize: 15),),
                            const SizedBox(height: 10,),
                            Text(widget.title ?? "",overflow: TextOverflow.ellipsis, maxLines: 3, style: Theme.of(context).textTheme.bodySmall?.
                            copyWith(fontWeight: widget.status == "Unread" ? FontWeight.w700 : FontWeight.w400, color: stepsColor, fontSize: 12,),),
                            widget.status == "Unread" ? const SizedBox(height: 5,) : const SizedBox(),
                            widget.status == "Unread" ? Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    controller.markNotificationAsRead(notificationId: widget.id, context: context);
                                  },
                                  child: Container(padding: const EdgeInsets.all(3), width: 100,
                                      decoration: BoxDecoration(border: Border.all(color: fagoSecondaryColor), borderRadius: BorderRadius.circular(15)),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Mark as read", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: fagoSecondaryColor, fontWeight: FontWeight.w400)),
                                          const Icon(Icons.check, color: fagoSecondaryColor, size: 15,)
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ) : const SizedBox(),
                          ]))
                ],
              ),
            ),
          )
      );
    });
  }
}
