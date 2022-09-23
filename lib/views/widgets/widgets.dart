import 'package:flutter/material.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/models/vet_model.dart';
import 'package:tonveto/views/screens/vet/vet_profile.dart';

class VetCard extends StatelessWidget {

  final Veterinaire? veterinaire;

  const VetCard(
      {
        required this.veterinaire,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  VetProfileScreen(vet: veterinaire!)),
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
                      text: 'Dr ${veterinaire?.first_name} ${veterinaire?.last_name}',
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
            Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      ' 4.8',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CliniqueCard extends StatelessWidget {

  final Clinique? clinique;

  const CliniqueCard(
      {required this.clinique,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    ' 4.8',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
