import 'package:flutter/material.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/comment_model.dart';

import '../../widgets/widgets.dart';

class CommentairesScreen extends StatefulWidget {
  static const route = "/commentaires-list";

  CommentairesScreen({required this.comments, Key? key}) : super(key: key);

  List<CommentModel> comments;

  @override
  _CommentairesScreenState createState() => _CommentairesScreenState();
}

class _CommentairesScreenState extends State<CommentairesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.mainColor,
        centerTitle: true,
        title: const Text('Commentaires et évalutations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Container(
        child: ListView.builder(
            itemCount: widget.comments.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.comments[index].owner_first_name} ${widget.comments[index].owner_last_name}',
                          style: const TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        AbsorbPointer(
                          child: StarRating(
                            size: 20,
                            rating: (widget.comments[index].rating ?? 0).toDouble(),
                            onRatingChanged: (rating) =>
                                setState(() => 5 + 5),
                          ),

                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.divider,),
                    Text(widget.comments[index].text ?? ''),
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
