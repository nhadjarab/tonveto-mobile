class CommentModel {
  CommentModel({
    this.text,
    this.ownerFirstName,
    this.ownerLastName,
    this.rating,
    this.date,
  });

  String? text;
  String? ownerFirstName;
  String? ownerLastName;
  DateTime? date;
  int? rating;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        text: json["text"],
        date: DateTime.tryParse(json["date"] ?? DateTime.now().toString()),
        ownerFirstName: json["owner"]['first_name'],
        ownerLastName: json["owner"]['last_name'],
        rating: json["rating"]['rating'] ?? 0,
      );
}
