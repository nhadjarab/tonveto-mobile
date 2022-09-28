import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/consts.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/utils/validators.dart';
import 'package:tonveto/viewmodels/auth_viewmodel.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import 'package:tonveto/views/widgets/custom_fields.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';

class AddPetScreen extends StatefulWidget {
  static const route = "/add-pets";

  const AddPetScreen({Key? key}) : super(key: key);

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> genders = [
    "Mâle",
    "Femelle",
  ];

  String? birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  String? _nom;
  String? _sex = "Mâle";
  String? _animal = types[0];
  String? _race;
  bool _crossbreed = true;
  bool _sterilised = false;

  void addPet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (birthDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppTheme.errorColor,
            content: Text("Ajoutez la date de naissance",
                style: TextStyle(color: Colors.white))));
        return;
      }

      if (_race == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppTheme.errorColor,
            content: Text(
              "La race est obligatoire",
              style: TextStyle(color: Colors.white),
            )));
        return;
      }
      Pet pet = Pet(
        birthDate: birthDate,
        name: _nom,
        breed: _race,
        species: _animal,
        sex: _sex,
        sterilised: _sterilised,
        crossbreed: _crossbreed,
      );
      final redirect =
          await Provider.of<AuthViewModel>(context, listen: false).addPet(pet);
      if (redirect) {
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "Ajouter un animal",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        Icons.pets,
                        size: 30,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        labelText: "Surnom*",
                        keyboardType: TextInputType.name,
                        validator: (value) => validateName(
                            value,
                            "le champ ne peut pas être vide",
                            "le surnom doit être +3 caracteres"),
                        onSaved: (value) => _nom = value,
                      ),
                      const SizedBox(height: AppTheme.divider),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton(
                            // Initial Value
                            value: _sex,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: genders.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                _sex = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.divider),
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
                                    firstDate:
                                        DateTime(DateTime.now().year - 100),
                                    lastDate: DateTime.now());
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
                      const SizedBox(height: AppTheme.divider),
                      const Divider(
                        height: 1,
                        color: AppTheme.mainColor,
                      ),
                      const SizedBox(height: AppTheme.divider),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton(
                            hint: const Text("Animal"),
                            // Initial Value
                            value: _animal,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: types.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                _animal = newValue!;
                                _race = null;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton(
                            hint: const Text("Race"),
                            // Initial Value
                            value: _race,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: animalsTypes[_animal]!.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                _race = newValue!;
                              });
                            },
                          ),
                          const Text("Croisé(e)"),
                          Column(
                            children: [
                              RadioListTile<bool>(
                                title: const Text('Oui'),
                                value: true,
                                groupValue: _crossbreed,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _crossbreed = value!;
                                  });
                                },
                              ),
                              RadioListTile<bool>(
                                title: const Text('Non'),
                                value: false,
                                groupValue: _crossbreed,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _crossbreed = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const Text("Stérélisé(e)"),
                          Column(
                            children: [
                              RadioListTile<bool>(
                                title: const Text('Oui'),
                                value: true,
                                groupValue: _sterilised,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _sterilised = value!;
                                  });
                                },
                              ),
                              RadioListTile<bool>(
                                title: const Text('Non'),
                                value: false,
                                groupValue: _sterilised,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _sterilised = value!;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: AppTheme.divider * 2),
                      Provider.of<AuthViewModel>(context).loading
                          ? const CustomProgress()
                          : CustomButton(
                              text: "Ajouter",
                              onPressed: addPet,
                            )
                    ],
                  )),
            )
          ],
        ),
      )),
    );
  }
}
