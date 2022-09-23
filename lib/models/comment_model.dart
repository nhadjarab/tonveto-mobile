class CommentModel {
  CommentModel({
    this.text,
    this.owner_first_name,
    this.owner_last_name,
    this.rating,

  });

  String? text;
  String? owner_first_name;
  String? owner_last_name;
  int? rating;


  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    text: json["text"],
    owner_first_name: json["owner"]['first_name'],
    owner_last_name: json["owner"]['last_name'],
    rating: json["rating"]['rating'] ?? 0,

  );


}