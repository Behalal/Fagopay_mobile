import '../../admin/all_admin.dart';
import '../../customers/customer.dart';
import 'package:flutter/cupertino.dart';

class ActionsModel {
  String actionImage;
  String actionText;
  Widget? route;

  ActionsModel({required this.actionImage, required this.actionText, this.route});
}

List<ActionsModel> actionContents = [
  ActionsModel(
      actionImage: "assets/images/business_home_1.png",
      actionText: "Generate QR"),
  ActionsModel(
      actionImage: "assets/images/business_home_2.png",
      actionText: "Payment Link"),
  ActionsModel(
      actionImage: "assets/images/business_home_3.png",
      actionText: "Create Invoice",
      route: const AllAdmin()
  ),
  ActionsModel(
      actionImage: "assets/images/business_home_4.png",
      actionText: "Suppliers"),
  ActionsModel(
      actionImage: "assets/images/business_home_5.png",
      actionText: "Customers",
      route: const CustomerPage()
    ),
  ActionsModel(
      actionImage: "assets/images/business_box3.png", actionText: "Transactions"),
];
