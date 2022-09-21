import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/utils/validators.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/widgets/custom_button.dart';
import 'package:vet/views/widgets/custom_fields.dart';
import 'package:vet/views/widgets/custom_progress.dart';
import 'package:vet/views/widgets/show_message.dart';

class InfoScreen extends StatefulWidget {
  static const route = "/info";

  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  String? _lastname;
  String? _firstname;
  String? _email;
  String? _password;
  String? _phone;

  void register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (birthDate == null || DateTime.now().year - birthDate!.year < 18) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("il faut que vous avez +18 ans")));
        return;
      }
      final redirect = await Provider.of<AuthViewModel>(context, listen: false)
          .registerInfo(
              _firstname, _lastname, _phone, birthDate, _email, _password);
      if (redirect) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    _email = args["email"];
    _password = args["password"];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Créer un compte"),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: SizedBox(
            width: 90.w,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.divider * 2),
                  CustomTextField(
                    labelText: "Nom*",
                    validator: (value) => validateName(
                        value,
                        "le champ ne peut pas être vide",
                        "le nom doit être +3 caracteres"),
                    onSaved: (value) => _lastname = value,
                  ),
                  const SizedBox(height: AppTheme.divider),
                  CustomTextField(
                    labelText: "Prénom*",
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
                                lastDate: DateTime(DateTime.now().year - 18));
                            if (datePick != null && datePick != birthDate) {
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
                    labelText: "Tel*",
                    keyboardType: TextInputType.number,
                    validator: (value) => value != null && value.length >= 8
                        ? null
                        : "Le numéro doit être valide",
                    onSaved: (value) => _phone = value,
                  ),
                  const SizedBox(height: AppTheme.divider * 2),
                  Provider.of<AuthViewModel>(context).loading
                      ? const CustomProgress()
                      : CustomButton(
                          text: "Créer votre compte", onPressed: register),
                  Consumer<AuthViewModel>(builder: (context, value, child) {
                    if (value.errorMessage != null) {
                      return ShowMessage(
                          message: value.errorMessage!,
                          isError: true,
                          onPressed: () => value.clearError());
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          )),
        ));
  }
}
