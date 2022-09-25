import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/models/vet_model.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/medical_records_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final Appointment appointment;

  const AppointmentDetailsScreen({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  Clinique? clinic;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      clinic = await Provider.of<AuthViewModel>(context, listen: false)
          .getClinic(widget.appointment.clinicId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Rendez-vous details",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ],
      ),
      body: SafeArea(
        child: Consumer<AuthViewModel>(builder: (context, auth, _) {
          return SizedBox(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
                    padding: const EdgeInsets.all(10),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                      )
                    ]),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                              "Vétérinaire: ${widget.appointment.vet?.first_name} ${widget.appointment.vet?.last_name}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.date_range_outlined),
                          title: Text(
                              "Date: ${widget.appointment.date?.day}/${widget.appointment.date?.month}/${widget.appointment.date?.year} - ${widget.appointment.time}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(
                              "Téléphone: ${widget.appointment.vet?.phone_number}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.contact_mail),
                          title:
                              Text("E-mail: ${widget.appointment.vet?.email}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                      )
                    ]),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.file_copy_rounded),
                          title: const Text("Les rapports médicaux"),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MedicalRecordsScreen(
                                records:
                                    widget.appointment.medicalReports ?? [],
                              ),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                      )
                    ]),
                    child: auth.loading
                        ? const Center(child: CustomProgress())
                        : ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(clinic?.name ?? ""),
                            subtitle: Text(
                                "${clinic?.address}, ${clinic?.city}, ${clinic?.country}"),
                          ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
