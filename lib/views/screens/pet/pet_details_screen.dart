import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/pet/edit_pet_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';

class PetDetailsScreen extends StatelessWidget {
  static const route = "/pet-details";

  const PetDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int petIndex = ModalRoute.of(context)!.settings.arguments as int;
    Pet pet = Provider.of<AuthViewModel>(context).user!.pets![petIndex];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Consumer<AuthViewModel>(builder: (context, auth, _) {
          return auth.loading
              ? const Center(child: CustomProgress())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: const BoxDecoration(
                            color: AppTheme.mainColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditPetScreen(pet: pet),
                                      ));
                                },
                              ),
                            ),
                            const SizedBox(height: AppTheme.divider * 2),
                            Text(
                              "${pet.name}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5.w,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 40),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.pets),
                              title: Text("Nom: ${pet.name}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.date_range_outlined),
                              title: Text(
                                  "Date de naissance: ${pet.birthDate?.day}/${pet.birthDate?.month}/${pet.birthDate?.year}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.pets),
                              title: Text(
                                  "${pet.sex} ${pet.species} - ${pet.breed}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.pets),
                              title: Text(
                                  "Croiser: ${pet.crossbreed! ? "Oui" : "Non"} / Stérialsé: ${pet.sterilised! ? "Oui" : "Non"}"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.timelapse),
                              title: const Text("Afficher les rendez-vous"),
                              onTap: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
