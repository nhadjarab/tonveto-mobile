import 'package:tonveto/models/medical_report_model.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/models/vet_model.dart';

class Appointment {
  Appointment(
      {this.id,
      this.date,
      this.time,
      this.petId,
      this.vetId,
      this.userId,
      this.vet,
      this.medicalReports,
      this.clinicId,
      this.pet});

  String? id;
  DateTime? date;
  String? time;
  String? petId;
  String? vetId;
  String? userId;
  Veterinaire? vet;
  Pet? pet;
  List<MedicalReport>? medicalReports;
  String? clinicId;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
      id: json["id"],
      date: DateTime.tryParse(json["date"] ?? DateTime.now().toString()),
      time: json["time"],
      petId: json["pet_id"],
      vetId: json["vet_id"],
      userId: json["user_id"],
      vet: Veterinaire.fromJson(json["vet"]),
      pet:  json["pet"] != null ? Pet.fromJson(json["pet"]) : null ,
      medicalReports: List<MedicalReport>.from(json["MedicalReport"]
              ?.map((record) => MedicalReport.fromJson(record)) ??
          []),
      clinicId: json["clinic_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": time,
        "pet_id": petId,
        "vet_id": vetId,
        "user_id": userId,
      };
}
