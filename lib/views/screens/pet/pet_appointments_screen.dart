import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/appointment_details_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';

class PetAppointmentScreen extends StatefulWidget {
  static const route = "/pet-appointments";
  final Pet pet;
  const PetAppointmentScreen({Key? key, required this.pet}) : super(key: key);

  @override
  State<PetAppointmentScreen> createState() => _PetAppointmentScreenState();
}

class _PetAppointmentScreenState extends State<PetAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthViewModel>(context, listen: false)
          .getPetAppointments(widget.pet.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainColor,
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
        title: Text(
          "Les rendez-vous de ${widget.pet.name}",
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      body: Consumer<AuthViewModel>(builder: (context, auth, _) {
        return Container(
          padding: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: auth.loading
              ? const Center(child: CustomProgress())
              : ListView.builder(
                  itemCount: widget.pet.appointments.length,
                  itemBuilder: (context, index) {
                    Appointment appointment = widget.pet.appointments[index];
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                          "${appointment.vet?.last_name} ${appointment.vet?.first_name}"),
                      subtitle: Text(
                          "Date:  ${appointment.date?.day}/${appointment.date?.month}/${appointment.date?.year} - ${appointment.time}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentDetailsScreen(
                                          appointment: appointment)));
                        },
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }
}
