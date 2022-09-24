import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/pet_model.dart';

class User {
  User(
      {this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.birth_date,
      this.phone_number,
      this.profile_complete,
      this.type,
      this.appointments,
      this.pets});

  String? id;
  String? first_name;
  String? last_name;
  String? email;
  DateTime? birth_date;
  String? phone_number;
  bool? profile_complete;
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
    return com;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
        phone_number: json["phone_number"],
        profile_complete: json["profile_complete"],
        type: json["type"],
        pets: List<Pet>.from(json["pets"].map((pet) => Pet.fromJson(pet))),
        appointments: List<Appointment>.from(json["appointments"]
                ?.map((appointment) => Appointment.fromJson(appointment)) ??
            []),
        birth_date:
            DateTime.tryParse(json["birth_date"] ?? DateTime.now().toString()),
      );
}
