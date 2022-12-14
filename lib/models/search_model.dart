

import 'package:tonveto/models/vet_model.dart';

import 'clinique_model.dart';

class SearchModel {
  SearchModel(
      {this.cliniques,this.veterinaires});


  List<Clinique>? cliniques;
  List<Veterinaire>? veterinaires;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(

    cliniques: List<Clinique>.from(json["filteredClinics"].map((clinique) => Clinique.fromJson(clinique))),
    veterinaires: List<Veterinaire>.from(json["filteredVets"].map((veterinaire) => Veterinaire.fromJson(veterinaire))),

  );
}
