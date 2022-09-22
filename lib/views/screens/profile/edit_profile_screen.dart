import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/utils/validators.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/widgets/custom_button.dart';
import 'package:vet/views/widgets/custom_fields.dart';
import 'package:vet/views/widgets/custom_progress.dart';

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
            const SnackBar(content: Text("il faut que vous avez +18 ans")));
        return;
      }

      bool redirect = await Provider.of<AuthViewModel>(context, listen: false)
          .updateUserData(_firstname, _lastname, _phone, birthDate, _email);
      if (redirect) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    birthDate = Provider.of<AuthViewModel>(context, listen: false)
        .user?.birth_date;
    birthDateInString =
    "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          "Modifer mon profile",
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer<AuthViewModel>(
          builder: (context, auth, _) {

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
                          initialValue: auth.user?.email ?? "",
                          labelText: "e-mail",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(
                              value,
                              "le champ ne peut pas être vide",
                              "email invalide"),
                          onSaved: (value) => _email = value,
                        ),
                        CustomTextField(
                          initialValue: auth.user?.last_name ?? "",
                          labelText: "Nom",
                          keyboardType: TextInputType.name,
                          validator: (value) => validateName(
                              value,
                              "le champ ne peut pas être vide",
                              "le nom doit être +3 caracteres"),
                          onSaved: (value) => _lastname = value,
                        ),
                        CustomTextField(
                          initialValue: auth.user?.first_name ?? "",
                          labelText: "Prénom",
                          keyboardType: TextInputType.name,
                          validator: (value) => validateName(
                              value,
                              "le champ ne peut pas être vide",
                              "le prénom doit être +3 caracteres"),
                          onSaved: (value) => _firstname = value,
                        ),
                        const SizedBox(height: AppTheme.divider * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Date de naissance*"),
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
                                      firstDate: DateTime(DateTime.now().year - 100),
                                      lastDate: DateTime(2050 ));
                                  if (datePick != null && datePick != birthDate) {

                                    setState(() {
                                      birthDate = datePick;
                                      isDateSelected = true;
                                      print(birthDateInString);
                                      birthDateInString =
                                      "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}";  // 08/14/2019
                                      print(birthDateInString);

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
                          initialValue: auth.user?.phone_number,
                          labelText: "Tel*",
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value != null && value.length >= 8
                                  ? null
                                  : "Le numéro doit être valide",
                          onSaved: (value) => _phone = value,
                        ),
                        const SizedBox(height: AppTheme.divider * 2),
                        Provider.of<AuthViewModel>(context).loading
                            ? const CustomProgress()
                            : CustomButton(
                                text: "Mettre à jour", onPressed: update),
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
