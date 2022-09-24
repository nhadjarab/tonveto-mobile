import 'package:flutter/material.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/models/vet_model.dart';
import 'package:tonveto/views/screens/vet/vet_profile.dart';

import '../../config/theme.dart';
import '../screens/clinique/clinique_profile.dart';

class VetCard extends StatelessWidget {
  final Veterinaire? veterinaire;

  const VetCard({required this.veterinaire, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VetProfileScreen(vet: veterinaire!)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/veterinaire.png'),
              radius: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text:
                          'Dr ${veterinaire?.first_name} ${veterinaire?.last_name}',
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ])),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${veterinaire?.phone_number}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CliniqueCard extends StatelessWidget {
  final Clinique? clinique;

  const CliniqueCard({required this.clinique, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClinicProfileScreen(
                    clinique: clinique!,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/clinic.png'),
              radius: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${clinique?.name}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${clinique?.address} , ${clinique?.city} , ${clinique?.country}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${clinique?.phone_number}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class InfoWidget extends StatelessWidget {
  final String infoType;
  final String info;
  const InfoWidget({required this.info,required this.infoType,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
            TextSpan(
            text: '$infoType:',
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppTheme.mainColor),
          ),
          TextSpan(
            text: " $info",
            style:const TextStyle(
                fontSize: 17, color: Colors.black),
          ),
        ],
      ),
    );
  }
}


class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function(double?)? onRatingChanged;
  final Color? color;
  final int size;

  const StarRating({this.starCount = 5, this.rating = .0, this.size = 30,this.onRatingChanged, this.color,Key? key}):super(key:key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon =  Icon(
        Icons.star_border,
        color: Colors.grey,
        size: size.toDouble(),
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon =  Icon(
        Icons.star_half,
        color: Colors.yellow,
        size: size.toDouble(),
      );
    } else {
      icon =  Icon(
        Icons.star,
        color: Colors.yellow,
        size: size.toDouble(),
      );
    }
    return  InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(children:  List.generate(starCount, (index) => buildStar(context, index)));
  }
}