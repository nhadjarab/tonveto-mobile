import 'package:tonveto/models/medical_report_model.dart';
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
      this.medicalReports});

  String? id;
  DateTime? date;
  String? time;
  String? petId;
  String? vetId;
  String? userId;
  Veterinaire? vet;
  List<MedicalReport>? medicalReports;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        petId: json["pet_id"],
        vetId: json["vet_id"],
        userId: json["user_id"],
        vet: Veterinaire.fromJson(json["vet"]),
        medicalReports: List<MedicalReport>.from(json["MedicalReport"]
            .map((record) => MedicalReport.fromJson(record))),
      );

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
