import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/select_pet_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';

import '../../../config/theme.dart';
import '../../../viewmodels/auth_viewmodel.dart';

class AvailableAppointmentsScreen extends StatefulWidget {
  AvailableAppointmentsScreen(
      {required this.clinique, required this.date, Key? key})
      : super(key: key);

  Clinique clinique;
  DateTime date;

  @override
  _AvailableAppointmentsScreenState createState() =>
      _AvailableAppointmentsScreenState();
}

class _AvailableAppointmentsScreenState
    extends State<AvailableAppointmentsScreen> {
  List<String> appointments = [];
  List<String> matin = [];
  List<String> apresMidi = [];

  getAvailableAppointments() async {
    appointments = await Provider.of<SearchViewModel>(context, listen: false)
            .getAvailableAppointments(
          widget.clinique.owner_id,
          Provider.of<AuthViewModel>(context, listen: false).user?.id,
          "${widget.date.year}-${widget.date.month}-${widget.date.day}",
          Provider.of<AuthViewModel>(context, listen: false).token,
        ) ??
        [];

    for (int i = 0; i < appointments.length; i++) {
      if (int.parse(appointments[i].split(':')[0]) < 12) {
        matin.add(appointments[i]);
      } else {
        apresMidi.add(appointments[i]);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getAvailableAppointments();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.mainColor,
            title: const Text("Rendez-vous disponibles"),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Matin"),
                Tab(text: "Aprés midi"),
              ],
            ),
          ),
          body: Provider.of<SearchViewModel>(
            context,
          ).loading
              ? const CustomProgress()
              : TabBarView(
                  children: [
                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.5,
                          // crossAxisSpacing: 20,
                        ),
                        itemCount: matin.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectPetsScreen(
                                        date:
                                            widget.date,
                                        token: Provider.of<AuthViewModel>(
                                                    context,
                                                    listen: false)
                                                .token ??
                                            '',
                                        user_id: Provider.of<AuthViewModel>(
                                                    context,
                                                    listen: false)
                                                .user
                                                ?.id ??
                                            '',
                                        vet_id: widget.clinique.owner_id ?? '',
                                        time: matin[index],
                                        clinic_id: widget.clinique.id ?? '')),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppTheme.mainColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                matin[index] ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          );
                        }),
                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.5,
                          // crossAxisSpacing: 20,
                        ),
                        itemCount: apresMidi.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectPetsScreen(
                                        date: widget.date,
                                        token: Provider.of<AuthViewModel>(
                                                    context,
                                                    listen: false)
                                                .token ??
                                            '',
                                        user_id: Provider.of<AuthViewModel>(
                                                    context,
                                                    listen: false)
                                                .user
                                                ?.id ??
                                            '',
                                        vet_id: widget.clinique.owner_id ?? '',
                                        time: apresMidi[index],
                                        clinic_id: widget.clinique.id ?? '')),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppTheme.mainColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                apresMidi[index] ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          );
                        }),

                    /* ListView.builder(
                      itemCount: value.user?.getPastAppointments().length ?? 0,
                      itemBuilder: (context, index) {
                        final appointment = value.user?.getPastAppointments()[index];
                        return ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                              "${appointment?.vet?.last_name} ${appointment?.vet?.first_name}"),
                          subtitle: Text(
                              "Date:  ${appointment?.date?.day}/${appointment?.date?.month}/${appointment?.date?.year} - ${appointment?.time}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.keyboard_arrow_right),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppointmentDetailsScreen(
                                          appointment: appointment!)));
                            },
                          ),
                        );
                      },
                    ),*/
                  ],
                ),
        ));
  }
}
