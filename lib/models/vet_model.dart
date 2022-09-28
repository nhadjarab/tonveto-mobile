import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/models/comment_model.dart';

class Veterinaire {
  Veterinaire({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.phoneNumber,
    this.identificationOrder,
    this.profileComplete,
    this.isApproved,
    this.type,
    this.bankDetails,
    this.balance,
    this.specialities,
    this.clinics,
    this.comments,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  String? phoneNumber;
  String? identificationOrder;
  bool? profileComplete;
  bool? isApproved;
  String? type;
  String? bankDetails;
  int? balance;
  List<dynamic>? specialities;
  List<Clinique>? clinics;
  List<CommentModel>? comments;

  factory Veterinaire.fromJson(Map<String, dynamic> json) => Veterinaire(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        birthDate:
            DateTime.tryParse(json["birth_date"] ?? DateTime.now().toString()),
        identificationOrder: json["identification_order"],
        profileComplete: json["profile_complete"],
        isApproved: json["is_approved"],
        type: json["type"],
        bankDetails: json["bank_details"],
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
