class MedicalReport {
  MedicalReport({
    this.id,
    this.appointmentId,
    this.reason,
    this.diagnosis,
    this.treatment,
    this.notes,
    this.petId,
    this.vetId,
  });

  String? id;
  String? appointmentId;
  String? reason;
  String? diagnosis;
  String? treatment;
  String? notes;
  String? petId;
  String? vetId;

  factory MedicalReport.fromJson(Map<String, dynamic> json) => MedicalReport(
        id: json["id"],
        appointmentId: json["appointment_id"],
        reason: json["reason"],
        diagnosis: json["diagnosis"],
        treatment: json["treatment"],
        notes: json["notes"],
        petId: json["pet_id"],
        vetId: json["vet_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appointment_id": appointmentId,
        "reason": reason,
        "diagnosis": diagnosis,
        "treatment": treatment,
        "notes": notes,
        "pet_id": petId,
        "vet_id": vetId,
      };
}
