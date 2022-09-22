
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
  List? appointments;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
        phone_number: json["phone_number"],
        profile_complete: json["profile_complete"],
        type: json["type"],
        pets: List<Pet>.from(json["pets"].map((pet) => Pet.fromJson(pet))),
        appointments:
            List<dynamic>.from(json["appointments"]?.map((x) => x) ?? []),
        birth_date:
            DateTime.tryParse(json["birth_date"] ?? DateTime.now().toString()),
      );
}
