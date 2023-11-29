import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/utils/common-widgets/custom_button.dart';
import 'package:legal_links_app/utils/common-widgets/global_widget.dart';
import 'package:legal_links_app/utils/common-widgets/payment_confirmation_dialog.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatefulWidget {
  static String route = '/paymentscreen';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GlobalWidgets.appBar('Payment'),
      bottomNavigationBar: buttons(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                3,
                (index) => InkWell(
                    onTap: () {
                      Get.dialog(PaymentConfirmationDialog());
                    },
                    child: paymentWidget()))
          ],
        ),
      ),
    ));
  }

  Widget paymentWidget() {
    return GestureDetector(
      //onTap: (){Get.dialog(PaymentConfirmationDialog)},
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
          child: Container(
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              border: Border.all(color: R.colors.grey),
              color: R.colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSggMIbrbp6eZ4Bbaie7zoNWLFyzkErvPwEkA&usqp=CAU",
                        imageBuilder: (context, imageProvider) => Container(
                          height: 14.w,
                          width: 14.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: R.colors.red, width: 1),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, e) => SizedBox(
                            height: 14.w,
                            width: 14.w,
                            child: const Icon(Icons.error)),
                        placeholder: (context, url) {
                          return Center(
                              child: SizedBox(
                            height: 14.w,
                            width: 14.w,
                            child: CircularProgressIndicator.adaptive(
                                backgroundColor: R.colors.primary),
                          ));
                        },
                      ),
                    ),
                    w3,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "JazzCash",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: R.textStyles.poppinsSemiBold(
                              fontSize: 11.sp, color: R.colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              "Name:",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: R.textStyles.poppinsSemiBold(
                                  fontSize: 10.sp, color: R.colors.primary),
                            ),
                            w1,
                            Text(
                              "john iasnh",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: R.textStyles.poppinsRegular(
                                  fontSize: 10.sp, color: R.colors.primary),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Account Number:",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: R.textStyles.poppinsSemiBold(
                                  fontSize: 10.sp, color: R.colors.primary),
                            ),
                            w1,
                            Text(
                              "34345677889",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: R.textStyles.poppinsRegular(
                                  fontSize: 10.sp, color: R.colors.primary),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomButton(
              color: R.colors.primary,
              buttonTitle: "Book Now",
              tap: () async {
                // TODO: PAYMENT SCREEN TAP
                // await btnTap();
                Get.back();
              },
              textColor: R.colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
