import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legal_links_app/src/auth/model/user_model.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/utils/hights_widths.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/call_confirmation.dart';
import '../../../../../../utils/common-widgets/custom_button.dart';
import '../../dashboard.dart/model/lawyers_model.dart';

class BookAppointmentScreen extends StatefulWidget {
  static String route = '/bookAppointment';
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  UserModel? model;
  dynamic args;
  String currentDate = DateFormat("EEEE dd").format(DateTime.now());
  List<String> selectedDates = List.filled(5, "");

  bool isOpened = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args['model'] != null) {
          model = args['model'];
        }
      }
      for (int i = 0; i < selectedDates.length; i++) {
        selectedDates[i] = DateFormat('EEEE dd').format(DateTime.now());
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _selectedDate;
    String _dateCount;
    String _range;
    String _rangeCount;

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
              // ignore: lines_longer_than_80_chars
              ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });
    }

    return Consumer<AuthVM>(builder: (context, vm, _) {
      return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BookButton(),
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
                'Book Appointment',
                style: R.textStyles.poppinsSemiBold(color: R.colors.primary),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.dialog(CallConfirmationDialog(
                    PhoneNumberOne: '0324-4455663',
                    PhoneNumberTwo: '0324-4455663',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.sp),
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 15.sp),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        //   model?.profileImageUrl ??
                                        '',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 14.w,
                                      width: 14.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: R.colors.white, width: 1),
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
                                        child:
                                            CircularProgressIndicator.adaptive(
                                                backgroundColor:
                                                    R.colors.primary),
                                      ));
                                    },
                                  ),
                                ),
                                w2,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vm.userModel.fullName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: R.textStyles.poppinsSemiBold(
                                          fontSize: 11.sp,
                                          color: R.colors.black),
                                    ),
                                    Text(
                                      // model?.lawyerType ??
                                      "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: R.textStyles.poppinsRegular(
                                          fontSize: 10.sp,
                                          color: R.colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Fee: ',
                                          style: R.textStyles
                                              .poppinsSemiBold(fontSize: 10.sp),
                                        ),
                                        Text(
                                          vm.userModel.feePerMeeting.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: R.textStyles.poppinsRegular(
                                              fontSize: 10.sp,
                                              color: R.colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert))
                              ]),
                        ],
                      ),
                    ),
                  ),
                  h1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: R.colors.grey,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.verified,
                                size: 15.sp,
                              ),
                            ),
                          ),
                          w1,
                          Text(
                            'Verified Lawyer',
                            style: R.textStyles.poppinsRegular(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: R.colors.grey,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.online_prediction,
                                size: 15.sp,
                              ),
                            ),
                          ),
                          w1,
                          Text(
                            'Online prescription',
                            style: R.textStyles.poppinsRegular(),
                          )
                        ],
                      ),
                    ],
                  ),
                  h2,
                  AnimatedContainer(
                    padding: EdgeInsets.all(7.sp),
                    decoration: R.decoration.decoration(radius: 15),
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeIn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select date for consultation',
                              style: R.textStyles
                                  .poppinsSemiBold(color: R.colors.primary),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isOpened = !isOpened;
                                });
                              },
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isOpened
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: R.colors.black,
                                size: 25.sp,
                              ),
                            )
                          ],
                        ),
                        h1,
                        if (isOpened)
                          SfDateRangePicker(
                            headerStyle: DateRangePickerHeaderStyle(
                                textStyle: R.textStyles
                                    .poppinsMedium(color: R.colors.primary)),
                            rangeTextStyle: R.textStyles
                                .poppinsRegular(color: R.colors.primary),
                            selectionColor: R.colors.primary,
                            onSelectionChanged: _onSelectionChanged,
                            selectionMode: DateRangePickerSelectionMode.single,
                            initialSelectedRange: PickerDateRange(
                                DateTime.now()
                                    .subtract(const Duration(days: 4)),
                                DateTime.now().add(const Duration(days: 3))),
                          ),
                      ],
                    ),
                  ),
                  h3,
                  Text(
                    'Select Time for consultation',
                    style:
                        R.textStyles.poppinsSemiBold(color: R.colors.primary),
                  ),
                  h1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timeSlots('12:00 PM'),
                      timeSlots('12:15 PM'),
                      timeSlots('12:30 PM'),
                      timeSlots('12:45 PM'),
                    ],
                  ),
                  h1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timeSlots('01:00 PM'),
                      timeSlots('01:15 PM'),
                      timeSlots('01:30 PM'),
                      timeSlots('01:45 PM'),
                    ],
                  ),
                  h1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timeSlots('02:00 PM'),
                      timeSlots('02:15 PM'),
                      timeSlots('02:30 PM'),
                      timeSlots('02:45 PM'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget BookButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: CustomButton(
        color: R.colors.primary,
        buttonTitle: "Book Now",
        tap: () {},
        textColor: R.colors.white,
      ),
    );
  }

  Widget timeSlots(String text) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(color: R.colors.primary)),
      child: Text(
        text,
        style: R.textStyles.poppinsRegular(color: R.colors.primary),
      ),
    );
  }

  Widget selectDateField(
    VoidCallback onTap,
    int index,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(color: R.colors.primary)),
        child: Text(
          '${selectedDates[index]}',
          style: R.textStyles.poppinsRegular(color: R.colors.primary),
        ),
      ),
    );
  }
}
