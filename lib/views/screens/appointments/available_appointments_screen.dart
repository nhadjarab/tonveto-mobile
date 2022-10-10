import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/services/search_service.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/select_pet_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme.dart';
import '../../../viewmodels/auth_viewmodel.dart';

class AvailableAppointmentsScreen extends StatefulWidget {
  const AvailableAppointmentsScreen(
      {required this.cliniqueId,
      required this.date,
      required this.vetId,
      required this.price,
      this.appointment,
      Key? key})
      : super(key: key);

  final String cliniqueId;
  final DateTime date;
  final String vetId;
  final String price;
  final Appointment? appointment;

  @override
  State<AvailableAppointmentsScreen> createState() =>
      _AvailableAppointmentsScreenState();
}

class _AvailableAppointmentsScreenState
    extends State<AvailableAppointmentsScreen> {
  List<String> appointments = [];
  List<String> matin = [];
  List<String> apresMidi = [];

  getAvailableAppointments() async {
    try {
      appointments = await Provider.of<SearchViewModel>(context, listen: false)
          .getAvailableAppointments(
        widget.vetId,
        Provider.of<AuthViewModel>(context, listen: false).user?.id,
        DateFormat('yyyy-MM-dd').format(widget.date),
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
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        const  SnackBar(
          content: Text(
            'Vous étes hors ligne',
            style:
            TextStyle(color: Colors.white),
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
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
    final textLocals = AppLocalizations.of(context)!;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.mainColor,
            title:  Text(textLocals.rendezVousDisponibles),
            centerTitle: true,
            bottom:  TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: textLocals.matin),
                Tab(text: textLocals.apresMidi),
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
                            onTap: () async {
                              if (widget.appointment != null) {
                                setState(() {
                                  widget.appointment?.time = matin[index];
                                });
                                SearchService searchService = SearchService();
                                await searchService.updateAppointment(
                                    widget.appointment,
                                    Provider.of<AuthViewModel>(context,
                                            listen: false)
                                        .token);
                                if (!mounted) return;
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text(
                                      textLocals.rendezVousModifieAvecSucces,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: AppTheme.successColor,
                                  ),
                                );
                                await Provider.of<AuthViewModel>(context,
                                        listen: false)
                                    .getUserData();
                              } else {
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
                                          userId: Provider.of<AuthViewModel>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  ?.id ??
                                              '',
                                          vetId: widget.vetId,
                                          price: widget.price,
                                          time: matin[index],
                                          clinicId: widget.cliniqueId)),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppTheme.mainColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                matin[index],
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
                            onTap: () async {
                              if (widget.appointment != null) {
                                setState(() {
                                  widget.appointment?.time = apresMidi[index];
                                });
                                SearchService searchService = SearchService();
                                await searchService.updateAppointment(
                                    widget.appointment,
                                    Provider.of<AuthViewModel>(context,
                                            listen: false)
                                        .token);
                                if (!mounted) return;
                                Navigator.pop(context);
                                Navigator.pop(context);

                                await Provider.of<AuthViewModel>(context,
                                        listen: false)
                                    .getUserData();
                              } else {
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
                                          userId: Provider.of<AuthViewModel>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  ?.id ??
                                              '',
                                          vetId: widget.vetId,
                                          price: widget.price,
                                          time: apresMidi[index],
                                          clinicId: widget.cliniqueId)),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppTheme.mainColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                apresMidi[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          );
                        }),


                  ],
                ),
        ));
  }
}
