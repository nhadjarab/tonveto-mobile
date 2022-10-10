import 'package:flutter/material.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/comment_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/widgets.dart';

class CommentairesScreen extends StatefulWidget {
  static const route = "/commentaires-list";

  const CommentairesScreen({required this.comments, Key? key})
      : super(key: key);

  final List<CommentModel> comments;

  @override
  State<CommentairesScreen> createState() => _CommentairesScreenState();
}

class _CommentairesScreenState extends State<CommentairesScreen> {
  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.mainColor,
        centerTitle: true,
        title: Text(textLocals.commentairesEtEvalutations),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: ListView.builder(
          itemCount: widget.comments.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.comments[index].ownerFirstName} ${widget.comments[index].ownerLastName}',
                          style: const TextStyle(
                              color: AppTheme.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AbsorbPointer(
                        child: StarRating(
                          size: 20,
                          rating:
                              (widget.comments[index].rating ?? 0).toDouble(),
                          onRatingChanged: (rating) => setState(() => 5 + 5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppTheme.divider,
                  ),
                  Text("${widget.comments[index].text}"),
                  const SizedBox(
                    height: AppTheme.divider,
                  ),
                  Text(
                    "${widget.comments[index].date?.day}/${widget.comments[index].date?.month}/${widget.comments[index].date?.year}",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
