import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/models/comment_model.dart';

class Veterinaire {
  Veterinaire({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.birth_date,
    this.phone_number,
    this.identification_order,
    this.profile_complete,
    this.is_approved,
    this.type,
    this.bank_details,
    this.balance,
    this.specialities,
    this.clinics,
    this.comments,
  });

  String? id;
  String? first_name;
  String? last_name;
  String? email;
  DateTime? birth_date;
  String? phone_number;
  String? identification_order;
  bool? profile_complete;
  bool? is_approved;
  String? type;
  String? bank_details;
  int? balance;
  List<dynamic>? specialities;
  List<Clinique>? clinics;
  List<CommentModel>? comments;

  factory Veterinaire.fromJson(Map<String, dynamic> json) => Veterinaire(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
        phone_number: json["phone_number"],
        birth_date:
            DateTime.tryParse(json["birth_date"] ?? DateTime.now().toString()),
        identification_order: json["identification_order"],
        profile_complete: json["profile_complete"],
        is_approved: json["is_approved"],
        type: json["type"],
        bank_details: json["bank_details"],
        balance: json["balance"],
        //vetRating: json["vetRating"]['_avg']['rating'] ?? 0,
        specialities: List<dynamic>.from(json["specialities"].map((x) => x)),
        clinics: json["clinics"] != null
            ? List<Clinique>.from(json["clinics"]
                .map((clinique) => Clinique.fromJson(clinique['clinic'])))
            : null,
        comments: json["CommentVet"] != null
            ? List<CommentModel>.from(json["CommentVet"]
                .map((comment) => CommentModel.fromJson(comment)))
            : null,
      );
}
