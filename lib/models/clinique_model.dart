class Clinique {
  Clinique(
      {this.id,
        this.name,
        this.address,
        this.city,
        this.country,
        this.phone_number,
        this.owner_id,
        this.zip_code,
        this.is_approved,
       });

  String? id;
  String? name;
  String? address;
  String? city;
  String? country;
  String? phone_number;
  String? owner_id;
  String? zip_code;
  bool? is_approved;


  factory Clinique.fromJson(Map<String, dynamic> json) => Clinique(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    phone_number: json["phone_number"],
    country: json["country"],
    owner_id: json["owner_id"],
    zip_code: json["zip_code"],
    is_approved: json["is_approved"],

  );
}
