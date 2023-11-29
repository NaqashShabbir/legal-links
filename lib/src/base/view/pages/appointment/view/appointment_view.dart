import 'package:flutter/material.dart';
import 'package:legal_links_app/constants/enums.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/services/auth_services.dart';
import 'package:legal_links_app/src/auth/vm/auth_vm.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/model/booking_model.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/view/widget/appointment_widget.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/vm/appointment_vm.dart';
import 'package:legal_links_app/utils/zbot_toast.dart';
import 'package:provider/provider.dart';

class AppointmentView extends StatefulWidget {
  static String route = '/appointment';
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List tabTitle = ['Upcoming', "Previous"];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var vm = Provider.of<AppointmentVM>(context, listen: false);
      var aVm = Provider.of<AuthVM>(context, listen: false);
      ZBotToast.loadingShow();

      if (aVm.userModel.role == UserRole.LAWYER) {
        await vm.getLawyerBookings(aVm.userModel.id ?? "");
      } else {
        await vm.getUserBookings(aVm.userModel.id ?? "");
      }

      vm.update();
      setState(() {});
      ZBotToast.loadingClose();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppointmentVM, AuthVM>(builder: (context, appVm, vm, _) {
      return SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () async {
              // var vm = Provider.of<AppointmentVM>(context, listen: false);
              // var aVm = Provider.of<AuthVM>(context, listen: false);

              // await vm.getUserBookings(aVm.userModel.id ?? "");

              // setState(() {});
            },
            child: Column(
              children: [
                DefaultTabController(
                  length: 3,
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    controller: tabController,
                    labelStyle: R.textStyles.poppinsSemiBold(),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    //controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: R.colors.primary,
                    indicatorWeight: 4,
                    tabs: [
                      for (int i = 0; i < tabTitle.length; i++)
                        Tab(
                          text: tabTitle[i],
                        ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  controller: tabController,
                  children: [
                    if (vm.userModel.role == UserRole.LAWYER)
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              appVm.lawyerAppointmentList.length,
                              (index) => AppointmentWidget(
                                model: appVm.lawyerAppointmentList[index],
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              appVm.appointmentList.length,
                              (index) {
                                BookingModel appointment = appVm.appointmentList[index];

                                DateTime now = DateTime.now();

                                if (appointment.selectedDate != null &&
                                    appointment.selectedDate!.toDate().year == now.year &&
                                    appointment.selectedDate!.toDate().month == now.month &&
                                    appointment.selectedDate!.toDate().day == now.day) {
                                  final isFutureAppointment =
                                      appointment.timeSlot!.toDate().isAfter(DateTime.now());

                                  if (isFutureAppointment) {
                                    return AppointmentWidget(model: appointment);
                                  } else {
                                    return Container();
                                  }
                                } else {
                                  // return Container();
                                  final isFutureAppointment = appointment.selectedDate != null &&
                                      appointment.timeSlot != null &&
                                      appointment.selectedDate!.toDate().isAfter(DateTime.now()) &&
                                      appointment.timeSlot!.toDate().isAfter(DateTime.now());

                                  debugPrint("aaa ${appVm.appointmentList.length}");
                                  debugPrint(
                                      " ${R.colors.yellowPrint}bbb: $isFutureAppointment : ${appointment.selectedDate?.toDate()}");
                                  debugPrint(
                                      " ${R.colors.redPrint}bbb: $isFutureAppointment : ${appointment.timeSlot?.toDate()}");

                                  if (isFutureAppointment) {
                                    return AppointmentWidget(
                                      model: appointment,
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                    // /-------------------------/ TAB 2
                    if (vm.userModel.role == UserRole.LAWYER)
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              appVm.lawyerAppointmentList.length,
                              (index) => AppointmentWidget(
                                model: appVm.lawyerAppointmentList[index],
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              appVm.appointmentList.length,
                              (index) {
                                BookingModel appointment = appVm.appointmentList[index];
                                final isFutureAppointment =
                                    appointment.timeSlot!.toDate().isBefore(DateTime.now());

                                // debugPrint("aaa ${appVm.appointmentList.length}");

                                if (isFutureAppointment) {
                                  return AppointmentWidget(model: appointment);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                    // Text(appVm.appointmentList.length.toString())
                  ],
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
