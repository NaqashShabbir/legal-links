import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/appointment_details_model.dart';
import 'package:legal_links_app/utils/common-widgets/call_confirmation.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../utils/hights_widths.dart';
import '../../settings/view/widgets/custom_data_widget.dart';

class AppointmentDetails extends StatefulWidget {
  static String route = '/appointmentdetails';
  const AppointmentDetails({super.key});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  dynamic args;
  AppointmentModel? model;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args['model'] != null) {
          model = args['model'];
        }
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: R.colors.white,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: R.colors.primary,
                )),
            title: Center(
              child: Text(
                'Appointment Details',
                style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.dialog(CallConfirmationDialog(
                    PhoneNumberOne: '${model?.numberOne}',
                    PhoneNumberTwo: '${model?.numberTwo}',
                  ));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.sp, horizontal: 10.sp),
                  margin:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 12.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: R.colors.red,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 10.sp,
                      ),
                      w2,
                      Text(
                        "Help",
                        style: R.textStyles.poppinsMedium(
                          fontSize: 9.sp,
                          color: R.colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 15.sp),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: R.colors.grey),
                      borderRadius: BorderRadius.circular(10.sp),
                      boxShadow: [
                        BoxShadow(
                          color: R.colors.grey.withOpacity(.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Your Appointment ID',
                            style: R.textStyles.poppinsSemiBold(),
                          ),
                          Text(
                            "${model?.id.toString()}",
                            style: R.textStyles.poppinsSemiBold(
                                color: R.colors.primary, fontSize: 15.sp),
                          ),
                          h3,
                          CustomData(
                              title: 'Customer:',
                              subTitle: '${model?.customerNamr}'),
                          CustomData(
                              title: 'Laywer:', subTitle: '${model?.username}'),
                          CustomData(
                              title: 'Chamber:',
                              subTitle: '${model?.chamberName}'),
                          CustomData(
                              title: 'Address:', subTitle: '${model?.address}'),
                          CustomData(
                              title: 'Date:', subTitle: '${model?.date}'),
                          CustomData(
                              title: 'Status:', subTitle: '${model?.status}'),
                          CustomData(
                              title: 'Payment:', subTitle: '${model?.payment}'),
                        ]),
                  ),
                ),
                h1,
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Total:',
                          style: R.textStyles.poppinsMedium(
                            fontSize: 12.sp,
                            color: R.colors.primary,
                            letterSpacing: 0.45,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Text(
                          '${model?.fee}',
                          style: R.textStyles.poppinsBold(
                            color: R.colors.black,
                            letterSpacing: 0.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
