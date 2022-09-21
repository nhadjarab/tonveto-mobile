class Pet {
  Pet({
    this.id,
    this.sex,
    this.name,
    this.birthDate,
    this.species,
    this.breed,
    this.crossbreed,
    this.sterilised,
    this.ownerId,
  });

  String? id;
  String? sex;
  String? name;
  DateTime? birthDate;
  String? species;
  String? breed;
  bool? crossbreed;
  bool? sterilised;
  String? ownerId;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        sex: json["sex"],
        name: json["name"],
        birthDate: DateTime.parse(json["birth_date"]),
        species: json["species"],
        breed: json["breed"],
        crossbreed: json["crossbreed"],
        sterilised: json["sterilised"],
        ownerId: json["owner_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sex": sex,
        "name": name,
        "birth_date":
            "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
        "species": species,
        "breed": breed,
        "crossbreed": crossbreed,
        "sterilised": sterilised,
        "owner_id": ownerId,
      };
}
