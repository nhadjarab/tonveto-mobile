import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/services/search_service.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme.dart';
import '../../../models/pet_model.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../../viewmodels/payement_viewmodel.dart';

class SelectPetsScreen extends StatelessWidget {
  final DateTime date;
  final String userId;
  final String vetId;
  final String token;
  final String time;
  final String clinicId;
  final String price;
  static const route = "/select-pets-list";

  const SelectPetsScreen({required this.date,
    required this.token,
    required this.userId,
    required this.time,
    required this.vetId,
    required this.price,
    required this.clinicId,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

    Future<void> confirmDeleteDialog(context,) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(textLocals.rendezVousReserveAvecSucces),
            actions: <Widget>[
              TextButton(
                child: Text(
                  textLocals.ok,
                  style: const TextStyle(color: AppTheme.mainColor),
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
        title: Text(
          textLocals.selectionnerUnAnimal,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.mainColor,
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Consumer<AuthViewModel>(
          builder: (context, auth, child) =>
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: auth.loading
                      ? const CustomProgress()
                      :

                  auth.user?.pets?.length == 0 ? const Center(
                    child:  Text(
                      "Vous n'avez aucun animal.",
                      style:  TextStyle(fontSize: 22),),
                  ) :
                  ListView.builder(
                  itemCount: auth.user?.pets?.length ?? 0,
              itemBuilder: (context, index) {
      Pet pet = auth.user!.pets![index];
      return GestureDetector(
      onTap: () async {
      try {
      SearchService searchService = SearchService();

      await Provider.of<PayementViewModel>(context,
      listen: false)
          .makePayment(amount: price, currency: 'EUR')
          .then((value) async {
      if (value) {
      await searchService
          .addAppointment(
      DateFormat('yyyy-MM-dd').format(date),
      time,
      pet.id,
      vetId,
      userId,
      clinicId,
      token)
          .then((value) async {
      Provider.of<PayementViewModel>(context,
      listen: false)
          .addPayement(
      price, vetId, value, userId, token);
      confirmDeleteDialog(context);
      });
      } else {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text(
      textLocals.payementNonEffectue,
      style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppTheme.errorColor,
      ),
      );
      }
      });
      } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
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
      child: Container(
      padding: const EdgeInsets.symmetric(
      horizontal: 10, vertical: 15),
      margin:
      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
      children: [
      const CircleAvatar(
      backgroundImage:
      AssetImage('assets/images/dog.png'),
      backgroundColor: AppTheme.mainColor,
      radius: 30,
      ),
      Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 10),
      child: Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
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
      TextSpan(
      text: '${textLocals.sex} : ',
      style:const TextStyle(
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
      ],
      ),
      ),
      );
      }),
    ),)
    ,
    );
  }
}
