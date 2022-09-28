import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/pet_model.dart';

class User {
  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.birthDate,
      this.phoneNumber,
      this.profileComplete,
      this.type,
      this.appointments,
      this.pets});

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  String? phoneNumber;
  bool? profileComplete;
  String? type;
  List<Pet>? pets;
  List<Appointment>? appointments;

  void addPet(Pet pet) {
    pets?.add(pet);
  }

  List<Appointment> getPastAppointments() {
    List<Appointment> past = [];
    if (appointments == null) return [];
    for (Appointment app in appointments!) {
      if (app.date != null && app.date!.isBefore(DateTime.now())) {
        past.add(app);
      }
    }
    past.sort((a, b){ //sorting in ascending order
      return a.date!.compareTo(b.date!);
    });
    return past;
  }

  List<Appointment> getCommingAppointments() {
    List<Appointment> com = [];
    if (appointments == null) return [];
    for (Appointment app in appointments!) {
      if (app.date != null && app.date!.isAfter(DateTime.now())) {
        com.add(app);
      }
    }
    com.sort((a, b){ //sorting in ascending order
      return a.date!.compareTo(b.date!);
    });
    return com;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profileComplete: json["profile_complete"],
        type: json["type"],
        pets: List<Pet>.from(json["pets"].map((pet) => Pet.fromJson(pet))),
        appointments: List<Appointment>.from(json["appointments"]
                ?.map((appointment) => Appointment.fromJson(appointment)) ??
            []),
        birthDate:
            DateTime.tryParse(json["birth_date"] ?? DateTime.now().toString()),
      );
}
