class CommentModel {
  CommentModel({
    this.text,
    this.ownerFirstName,
    this.ownerLastName,
    this.rating,

  });

  String? text;
  String? ownerFirstName;
  String? ownerLastName;
  int? rating;


  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    text: json["text"],
    ownerFirstName: json["owner"]['first_name'],
    ownerLastName: json["owner"]['last_name'],
    rating: json["rating"]['rating'] ?? 0,

  );


}