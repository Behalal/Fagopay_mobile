import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/notification_controller.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/individual/notification/notification_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _controller = Get.put(NotificationController());

  @override
  void initState() {
    _controller.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          body: controller.onLoadingNotification == true && controller.onNotificationResponseError == false ? const Center(
            child: CupertinoActivityIndicator(color: fagoSecondaryColor,),
          ) : controller.onLoadingNotification == false && controller.onNotificationResponseError == false ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
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
                      'Notifications',
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
              controller.notificationResponse?.data?.notifications == [] ?
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100,),
                    CircleAvatar(
                        radius: 40, backgroundColor: fagoSecondaryColor.withOpacity(0.1),
                        child: Center(child: Image.asset("assets/images/empty-folder.png", height: 60, width: 60,))),
                    const SizedBox(height: 10,),
                    Text("No transaction record yet", style:
                    Theme.of(context).textTheme.bodyLarge?.copyWith(color: fagoSecondaryColor, fontSize: 14, fontWeight: FontWeight.w400),),
                  ],
                ),
              ) : Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(controller.notificationResponse!.data!.notifications!.length, (index){
                    final data = controller.notificationResponse!.data!.notifications![index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>  NotificationDetails(title: data.title! , body: data.description!, id: data.id!, status: data.status!,));
                      },
                      child: Container( width: double.infinity, margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration:
                      BoxDecoration(color: fagoSecondaryColorWithOpacity10, borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          children: [
                            const Icon(Icons.notifications, color: fagoSecondaryColor,),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Column(mainAxisAlignment: MainAxisAlignment.start , crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.title ?? "", style: Theme.of(context).textTheme.bodySmall?.
                                  copyWith(fontWeight: FontWeight.w400, color: fagoSecondaryColor, fontSize: 15),),
                                  const SizedBox(height: 10,),
                                  Text(data.description ?? "",overflow: TextOverflow.ellipsis, maxLines: 3, style: Theme.of(context).textTheme.bodySmall?.
                                  copyWith(fontWeight: data.status == "Unread" ? FontWeight.w700 : FontWeight.w400, color: stepsColor, fontSize: 12,),),
                                  data.status == "Unread" ? const SizedBox(height: 5,) : const SizedBox(),
                                  data.status == "Unread" ? Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          controller.markNotificationAsRead(notificationId: data.id!, context: context);
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
                                  ) : const SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              )],
            ),
          ) : controller.onLoadingNotification == false && controller.onNotificationResponseError == true ? const Center(
            child: Column(
              children: [
                CupertinoActivityIndicator(color: fagoSecondaryColor,),
              ],
            ),
          ) : const SizedBox()
        ),
      );
    });
  }
}
