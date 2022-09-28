import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/services/search_service.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/medical_records_screen.dart';
import 'package:tonveto/views/screens/appointments/select_date_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';

import '../../widgets/custom_fields.dart';
import '../../widgets/widgets.dart';

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
  String? text;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    Future<void> confirmDeleteDialog(context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
                "Confimer l'annulation du rendez vous, s'il vous plais"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Confimer',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  SearchService searchService = SearchService();
                  await searchService.cancelAppointment(
                      widget.appointment.id,
                      Provider.of<AuthViewModel>(context, listen: false)
                              .user
                              ?.id ??
                          '',
                      Provider.of<AuthViewModel>(context, listen: false).token);
                  if (!mounted) return;
                  await Provider.of<AuthViewModel>(context, listen: false)
                      .getUserData();
                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> evaluationDialog(context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Consumer<SearchViewModel>(builder: (context, value, _) {
            return AlertDialog(
              title: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StarRating(
                          rating: (value.rating ?? 0).toDouble(),
                          onRatingChanged: (rating) =>
                              setState(() => value.setRating(rating ?? 0)),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.divider),
                    CustomTextField(
                      labelText: "Commentaire",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'le champ ne peut pas être vide';
                        }
                        return null;
                      },
                      onSaved: (value) => text = value,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Confimer',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      SearchService searchService = SearchService();

                      await searchService.addVetComment(
                          text,
                          widget.appointment.vetId,
                          (value.rating ?? 0).toString(),
                          Provider.of<AuthViewModel>(context, listen: false)
                              .user
                              ?.id,
                          Provider.of<AuthViewModel>(context, listen: false)
                              .token);
                      value.setRating(0);
                      if (!mounted) return;
                      await Provider.of<AuthViewModel>(context, listen: false)
                          .getUserData();
                      if (!mounted) return;
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                ),
                TextButton(
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        },
      );
    }

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
          if (!widget.appointment.date!.isBefore(DateTime.now()))
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectDateScreen(
                            cliniqueId: widget.appointment.clinicId ?? '',
                            vetId: widget.appointment.vetId ?? '',
                            price: '',
                            appointment: widget.appointment,
                          )),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              )),
        ],
      ),
      backgroundColor: AppTheme.secondaryColor,
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
                        if (widget.appointment.pet != null)
                          ListTile(
                            leading: const Icon(Icons.pets),
                            title: Text(
                                "Animal: ${widget.appointment.pet?.name} , ${widget.appointment.pet?.species}"),
                          ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                              "Vétérinaire: ${widget.appointment.vet?.firstName} ${widget.appointment.vet?.lastName}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.date_range_outlined),
                          title: Text(
                              "Date: ${widget.appointment.date?.day}/${widget.appointment.date?.month}/${widget.appointment.date?.year} - ${widget.appointment.time}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(
                              "Téléphone: ${widget.appointment.vet?.phoneNumber}"),
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
                  if (!widget.appointment.date!.isBefore(DateTime.now()))
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
                          leading: const Icon(
                            Icons.delete,
                          ),
                          title: const Text("Annuler le rendez vous"),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () async {
                            confirmDeleteDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  if (widget.appointment.date!.isBefore(DateTime.now()))
                      Container(
                        margin:
                            EdgeInsets.only(left: 5.w, right: 5.w, bottom: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.star,
                              ),
                              title: const Text("Evaluer le vétérinaire"),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () async {
                                evaluationDialog(context);
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
                                "${clinic?.address}, ${clinic?.city}, ${clinic?.country} (${clinic?.zipCode})"),
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
