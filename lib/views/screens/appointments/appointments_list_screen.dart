import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/appointment_details_screen.dart';

class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.mainColor,
          title: const Text("Rendez-vous"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "à venir"),
              Tab(text: "passé"),
            ],
          ),
        ),
        backgroundColor: AppTheme.secondaryColor,
        body: Consumer<AuthViewModel>(
          builder: (context, auth, _) => TabBarView(
            children: [
              ListView.builder(
                itemCount: auth.user?.getCommingAppointments().length ?? 0,
                itemBuilder: (context, index) {
                  final appointment =
                      auth.user?.getCommingAppointments()[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentDetailsScreen(
                                  appointment: appointment!)));
                    },
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                        "${appointment?.vet?.lastName} ${appointment?.vet?.firstName}"),
                    subtitle: Text(
                        "Date:  ${appointment?.date?.day}/${appointment?.date?.month}/${appointment?.date?.year} - ${appointment?.time}"),
                  //  trailing: const Icon(Icons.keyboard_arrow_right),
                  );
                },
              ),
              ListView.builder(
                itemCount: auth.user?.getPastAppointments().length ?? 0,
                itemBuilder: (context, index) {
                  final appointment = auth.user?.getPastAppointments()[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentDetailsScreen(
                                  appointment: appointment!)));
                    },
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                        "${appointment?.vet?.lastName} ${appointment?.vet?.firstName}"),
                    subtitle: Text(
                        "Date:  ${appointment?.date?.day}/${appointment?.date?.month}/${appointment?.date?.year} - ${appointment?.time}"),
                    // trailing:  const Icon(Icons.keyboard_arrow_right),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
