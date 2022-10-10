import 'dart:io';

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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  getClinic()async {
    try {
      clinic = await Provider.of<AuthViewModel>(context, listen: false)
          .getClinic(widget.appointment.clinicId);
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getClinic();
    });


  }

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

    Future<void> confirmDeleteDialog(context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text(
                textLocals.confimerAnnulationDuRendezVousSilVousPlais),
            actions: <Widget>[
              TextButton(
                child:  Text(
                  textLocals.confimer,
                  style: const TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  try {
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

                },
              ),
              TextButton(
                child:  Text(textLocals.annuler),
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
                      labelText:   textLocals.commentaire,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value == '') {
                          return   textLocals.leChampNePeutPasEtreVide;
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
                  child:  Text(
                    textLocals.confimer,
                    style: const TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    try {
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
                            widget.appointment.id,
                            Provider.of<AuthViewModel>(context, listen: false)
                                .token).then((value){
                                  if(!value){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const  SnackBar(
                                        content: Text(
                                          'Vous avez déjà évalué ce vétérinaire',
                                          style:
                                          TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: AppTheme.errorColor,
                                      ),
                                    );
                                  }
                        });
                        value.setRating(0);
                        if (!mounted) return;
                        await Provider.of<AuthViewModel>(context, listen: false)
                            .getUserData();
                        if (!mounted) return;
                        Navigator.pop(context);
                        Navigator.pop(context);
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

                  },
                ),
                TextButton(
                  child:  Text(textLocals.annuler),
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
        title:  Text(
          textLocals.rendezVousDetails,
          style: const TextStyle(fontSize: 18, color: Colors.white),
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
                                "${textLocals.animal}: ${widget.appointment.pet?.name} , ${widget.appointment.pet?.species}"),
                          ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                              "${textLocals.veterinaire}: ${widget.appointment.vet?.firstName} ${widget.appointment.vet?.lastName}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.date_range_outlined),
                          title: Text(
                              "${textLocals.date}: ${widget.appointment.date?.day}/${widget.appointment.date?.month}/${widget.appointment.date?.year} - ${widget.appointment.time}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(
                              "${textLocals.telephone}: ${widget.appointment.vet?.phoneNumber}"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.contact_mail),
                          title:
                              Text("${textLocals.email}: ${widget.appointment.vet?.email}"),
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
                          title:  Text(textLocals.lesRapportsMedicaux),
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
                          title:  Text(textLocals.annulerLeRendezVous),
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
                              title:  Text(textLocals.evaluerLeVeterinaire),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () async {
                                evaluationDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                  if(clinic !=null)
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
