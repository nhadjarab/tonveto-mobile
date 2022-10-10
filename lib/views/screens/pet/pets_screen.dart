import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/screens/pet/add_pet_screen.dart';
import 'package:tonveto/views/screens/pet/pet_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetsScreen extends StatelessWidget {
  static const route = "/pets-list";

  const PetsScreen({Key? key}) : super(key: key);

  Future<void> confirmDeleteDialog(context, String? petID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Votre animal sera supprimé."),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Confimer',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                try {
                  await Provider.of<AuthViewModel>(context, listen: false)
                      .deletePet(petID).then((value) {
                    Navigator.pop(context);
                  });


                } on SocketException {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const  SnackBar(
                      content: Text(
                        'Vous étes hors ligne',
                        style:
                        TextStyle(color: Colors.white),
                      ),
                      backgroundColor: AppTheme.errorColor,
                    ),
                  );
                }

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
    final textLocals = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textLocals.mesAnimaux,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.mainColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.mainColor,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddPetScreen.route);
        },
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Consumer<AuthViewModel>(
        builder: (context, auth, child) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
              itemCount: auth.user?.pets?.length ?? 0,
              itemBuilder: (context, index) {
                Pet pet = auth.user!.pets![index];
                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, PetDetailsScreen.route,
                        arguments: index);
                  },
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/dog.png'),
                    backgroundColor: AppTheme.mainColor,
                    radius: 30,
                  ),
                  title: Text(
                    pet.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.mainColor),
                  ),
                  subtitle: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${textLocals.type} : ',
                        style: const TextStyle(
                          color: AppTheme.mainColor,
                        )),
                    TextSpan(
                        text: '${pet.species}  /  ',
                        style: const TextStyle(color: Colors.black)),
                    TextSpan(
                        text: '${textLocals.sex} : ',
                        style: const TextStyle(
                          color: AppTheme.mainColor,
                        )),
                    TextSpan(
                        text: '${pet.sex}',
                        style: const TextStyle(color: Colors.black))
                  ])),
                  trailing: IconButton(
                      onPressed: () {
                        confirmDeleteDialog(context, pet.id);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red)),
                );
              }),
        ),
      ),
    );
  }
}
