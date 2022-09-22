import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/pet/add_pet_screen.dart';
import 'package:tonveto/views/screens/pet/pet_details_screen.dart';

class PetsScreen extends StatelessWidget {
  static const route = "/pets";
  const PetsScreen({Key? key}) : super(key: key);
  Future<void> confirmDeleteDialog(context, String? petID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confimer la suppression, s'il vous plais"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confimer',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Provider.of<AuthViewModel>(context, listen: false)
                    .deletePet(petID);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes animaux",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
                color: AppTheme.mainColor, shape: BoxShape.circle),
            child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    Navigator.pushNamed(context, AddPetScreen.route)),
          )
        ],
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, auth, child) => ListView.builder(
            itemCount: auth.user?.pets?.length ?? 0,
            itemBuilder: (context, index) {
              Pet pet = auth.user!.pets![index];
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          confirmDeleteDialog(context, pet.id);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.mainColor),
                        ),
                        const SizedBox(height: AppTheme.divider),
                        Text("Type: ${pet.species} / Sex: ${pet.sex}"),
                        Text(
                            "Date de naissance : ${pet.birthDate?.day}/${pet.birthDate?.month}/${pet.birthDate?.year}")
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PetDetailsScreen.route,
                              arguments: index);
                        },
                        icon: const Icon(Icons.keyboard_arrow_right))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
