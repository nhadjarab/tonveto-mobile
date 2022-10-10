import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme.dart';
import '../../../utils/validators.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_fields.dart';
import '../../widgets/custom_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = "/edit-profile";

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? birthDateInString;

  DateTime? birthDate;

  bool isDateSelected = false;

  String? _lastname;
  String? _firstname;
  String? _email;
  String? _phone;

  void update() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (birthDate == null || DateTime.now().year - birthDate!.year < 18) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("il faut avoir au moins 18 ans")));
        return;
      }

      try {
         await Provider.of<AuthViewModel>(context, listen: false)
            .updateUserData(_firstname, _lastname, _phone, birthDate, _email).then((value){
           if (value) {
             if (!mounted) return;
             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(
                 content: Text(
                   'Informations modifiées avec succès',
                   style: TextStyle(color: Colors.white),
                 ),
                 backgroundColor: AppTheme.successColor,
               ),
             );
             Navigator.pop(context);
           }
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



    }
  }

  @override
  void initState() {
    birthDate =
        Provider.of<AuthViewModel>(context, listen: false).user?.birthDate;
    birthDateInString =
        "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.mainColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title:  Text(
          textLocals.modiferMonProfile,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer<AuthViewModel>(builder: (context, auth, _) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          initialValue: auth.user?.lastName ?? "",
                          labelText:  textLocals.nom,
                          keyboardType: TextInputType.name,
                          validator: (value) => validateName(
                              value,
                              textLocals.leChampNePeutPasEtreVide,
                              textLocals.leNomDoitAvoirAuMoinsCaracteresPasdeCaracteresSpecieaux),
                          onSaved: (value) => _lastname = value,
                        ),
                        CustomTextField(
                          initialValue: auth.user?.firstName ?? "",
                          labelText: textLocals.prenom,
                          keyboardType: TextInputType.name,
                          validator: (value) => validateName(
                              value,
                              textLocals.leChampNePeutPasEtreVide,
                              textLocals.lePrenomDoitAvoirAuMoinsCaracteresPasDeCaracteresSpecieaux),
                          onSaved: (value) => _firstname = value,
                        ),
                        CustomTextField(
                          initialValue: auth.user?.email ?? "",
                          labelText:  textLocals.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(
                              value,
                              textLocals.leChampNePeutPasEtreVide,
                              textLocals.emailInvalide),
                          onSaved: (value) => _email = value,
                        ),
                        const SizedBox(height: AppTheme.divider * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text( textLocals.dateDeNaissance),
                            const SizedBox(width: AppTheme.divider),
                            Text(birthDateInString ?? "DD/MM/YYYY"),
                            const SizedBox(width: AppTheme.divider),
                            GestureDetector(
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: AppTheme.mainColor,
                                ),
                                onTap: () async {
                                  final datePick = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:
                                          DateTime(DateTime.now().year - 100),
                                      lastDate: DateTime(2050));
                                  if (datePick != null &&
                                      datePick != birthDate) {
                                    setState(() {
                                      birthDate = datePick;
                                      isDateSelected = true;
                                      birthDateInString =
                                          "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}"; // 08/14/2019
                                    });
                                  }
                                }),
                          ],
                        ),
                        const SizedBox(height: AppTheme.divider * 2),
                        const Divider(
                          height: 1,
                          color: AppTheme.mainColor,
                        ),
                        const SizedBox(height: AppTheme.divider),
                        CustomTextField(
                          initialValue: auth.user?.phoneNumber,
                          labelText:  textLocals.telephone,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value != null && value.length >= 8
                                  ? null
                                  :  textLocals.leNumeroDoitEtreValide,
                          onSaved: (value) => _phone = value,
                        ),
                        const SizedBox(height: AppTheme.divider * 2),
                        Provider.of<AuthViewModel>(context).loading
                            ? const CustomProgress()
                            : CustomButton(
                                text:  textLocals.mettreAJour, onPressed: update),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
