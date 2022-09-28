class Clinique {
  Clinique(
      {this.id,
        this.name,
        this.address,
        this.city,
        this.country,
        this.phoneNumber,
        this.ownerId,
        this.zipCode,
        this.isApproved,
       });

  String? id;
  String? name;
  String? address;
  String? city;
  String? country;
  String? phoneNumber;
  String? ownerId;
  String? zipCode;
  bool? isApproved;


  factory Clinique.fromJson(Map<String, dynamic> json) => Clinique(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    phoneNumber: json["phone_number"],
    country: json["country"],
    ownerId: json["owner_id"],
    zipCode: json["zip_code"],
    isApproved: json["is_approved"],

  );
}
