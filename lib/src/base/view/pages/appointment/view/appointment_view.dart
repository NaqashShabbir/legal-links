import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/view/widget/appointment_widget.dart';
import 'package:legal_links_app/src/base/view/pages/appointment/vm/appointment_vm.dart';
import 'package:provider/provider.dart';

class AppointmentView extends StatefulWidget {
  static String route = '/appointment';
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List tabTitle = ['Today/Upcoming', "Previous"];

  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {});
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
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                Column(
                  children: [
                    ...List.generate(
                        context.read<AppointmentVM>().appointmentList.length,
                        (index) => AppointmentWidget(
                            model: context
                                .read<AppointmentVM>()
                                .appointmentList[index]))
                  ],
                ),
                Column()
              ],
            ))
          ],
        ),
      ),
    );
  }
}
