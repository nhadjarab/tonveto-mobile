import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/pet/edit_pet_screen.dart';
import 'package:tonveto/views/screens/pet/pet_appointments_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/widgets.dart';

class PetDetailsScreen extends StatelessWidget {
  static const route = "/pet-details";

  const PetDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

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
        title:  Text(
          textLocals.details,
          style:const TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      backgroundColor: AppTheme.secondaryColor,

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
                        margin: EdgeInsets.only(
                            left: 5.w, right: 5.w, top: 40, bottom: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info: "${pet.name}",
                                  infoType:  textLocals.nom,
                                )),
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info:
                                      "${pet.birthDate?.day}/${pet.birthDate?.month}/${pet.birthDate?.year}",
                                  infoType:  textLocals.dateDeNaissance,
                                )),
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info: "${pet.sex}",
                                  infoType:  textLocals.sex,
                                )),
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info: "${pet.species}",
                                  infoType:  textLocals.especes,
                                )),
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info: "${pet.breed}",
                                  infoType:  textLocals.race,
                                )),
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info: pet.crossbreed! ?  textLocals.oui :  textLocals.non,
                                  infoType:  textLocals.croise,
                                )),
                            ListTile(
                                leading: const Icon(
                                  Icons.pets,
                                  color: AppTheme.mainColor,
                                ),
                                title: InfoWidget(
                                  info: pet.sterilised! ? textLocals.oui :  textLocals.non,
                                  infoType: textLocals.sterelise,
                                )),
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
                              title:  Text(textLocals.afficherLesRendeVous),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PetAppointmentScreen(pet: pet),
                                ));
                              },
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
