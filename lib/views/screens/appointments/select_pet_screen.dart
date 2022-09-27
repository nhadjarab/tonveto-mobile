import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/services/search_service.dart';

import '../../../config/theme.dart';
import '../../../models/pet_model.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../../viewmodels/payement_viewmodel.dart';
import '../pet/add_pet_screen.dart';

class SelectPetsScreen extends StatelessWidget {
  final DateTime date;
  final String user_id;
  final String vet_id;
  final String token;
  final String time;
  final String clinic_id;
  final String price;
  static const route = "/select-pets-list";

  const SelectPetsScreen(
      {required this.date,
      required this.token,
      required this.user_id,
      required this.time,
      required this.vet_id,
      required this.price,
      required this.clinic_id,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> confirmDeleteDialog(
      context,
    ) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Rendez vous réservé avec succés"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Ok',
                  style: TextStyle(color: AppTheme.mainColor),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  await Provider.of<AuthViewModel>(context, listen: false)
                      .getUserData();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Séléctionner un animal",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.mainColor,
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Consumer<AuthViewModel>(
        builder: (context, auth, child) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
              itemCount: auth.user?.pets?.length ?? 0,
              itemBuilder: (context, index) {
                Pet pet = auth.user!.pets![index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                      GestureDetector(
                        onTap: () async {
                          SearchService searchService = SearchService();
                          await Provider.of<PayementViewModel>(context,
                                  listen: false)
                              .makePayment(amount: price, currency: 'USD')
                              .then((value) async {
                            if (value) {
                              await searchService
                                  .addAppointment(
                                      DateFormat('yyyy-MM-dd').format(date),
                                      time,
                                      pet.id,
                                      vet_id,
                                      user_id,
                                      clinic_id,
                                      token)
                                  .then((value) async {
                                Provider.of<PayementViewModel>(context,
                                        listen: false)
                                    .addPayement(
                                        price, vet_id, value, user_id, token);
                                confirmDeleteDialog(context);
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Payement non éffectué',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: AppTheme.errorColor,
                                ),
                              );
                            }
                          });
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/dog.png'),
                              backgroundColor: AppTheme.mainColor,
                              radius: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
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
                                  RichText(
                                      text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'Type : ',
                                        style: TextStyle(
                                          color: AppTheme.mainColor,
                                        )),
                                    TextSpan(
                                        text: '${pet.species}  /  ',
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    const TextSpan(
                                        text: 'Sex : ',
                                        style: TextStyle(
                                          color: AppTheme.mainColor,
                                        )),
                                    TextSpan(
                                        text: '${pet.sex}',
                                        style: const TextStyle(
                                            color: Colors.black))
                                  ])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
