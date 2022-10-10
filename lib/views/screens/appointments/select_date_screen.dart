import 'package:flutter/material.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/views/screens/appointments/available_appointments_screen.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectDateScreen extends StatefulWidget {
  const SelectDateScreen(
      {required this.cliniqueId,
      required this.vetId,
      required this.price,
      this.appointment,
      Key? key})
      : super(key: key);

 final  String cliniqueId;
 final String vetId;
  final String price;
  final Appointment? appointment;

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  String? birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  @override
  void initState() {
    if (widget.appointment != null) {
      birthDate = widget.appointment?.date;
      isDateSelected = true;
      birthDateInString =
      "${widget.appointment?.date?.day}/${widget.appointment?.date?.month}/${widget.appointment?.date?.year}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;


    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.mainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
             Text(
              textLocals.selectionnerUneDate,
              style:const TextStyle(
                  color: AppTheme.mainColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final datePick = await showDatePicker(
                    context: context,
                    initialDate: widget.appointment != null
                        ? widget.appointment?.date ?? DateTime.now()
                        : DateTime.now(),
                    firstDate: widget.appointment != null
                        ? widget.appointment?.date ?? DateTime.now()
                        : DateTime.now(),
                    lastDate: DateTime(2050));
                if (datePick != null && datePick != birthDate) {
                  setState(() {
                    birthDate = datePick;
                    isDateSelected = true;

                    birthDateInString =
                        "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}"; // 08/14/2019
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 40,
                      color: AppTheme.mainColor,
                    ),
                    const Spacer(),
                    Text(
                      birthDateInString ?? "DD/MM/YYYY",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_right,
                      size: 40,
                      color: AppTheme.mainColor,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (isDateSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      text:  textLocals.suivant,
                      onPressed: () {
                        if (widget.appointment != null) {
                          setState(() {
                            widget.appointment?.date = birthDate;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AvailableAppointmentsScreen(
                                      cliniqueId: widget.cliniqueId,
                                      date: birthDate!,
                                      vetId: widget.vetId,
                                      appointment: widget.appointment,
                                      price: '',

                                    )),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AvailableAppointmentsScreen(
                                      cliniqueId: widget.cliniqueId,
                                      date: birthDate!,
                                      vetId: widget.vetId,
                                      price:widget.price,
                                    )),
                          );
                        }
                      })
                ],
              )
          ],
        ),
      ),
    ));
  }
}
