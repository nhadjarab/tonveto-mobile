import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/views/screens/appointments/select_clinique_screen.dart';
import 'package:tonveto/views/screens/appointments/select_date_screen.dart';

import '../../../config/theme.dart';
import '../../../models/clinique_model.dart';

class SelectSpecialty extends StatefulWidget {
   SelectSpecialty(
      {required this.clinics,
      required this.vet_id,
      required this.specialties,
      Key? key})
      : super(key: key);
  List<Clinique> clinics;
  String vet_id;
  List<dynamic> specialties;

  @override
  _SelectSpecialtyState createState() => _SelectSpecialtyState();
}

class _SelectSpecialtyState extends State<SelectSpecialty> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.mainColor,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Sélectionner une spécialité'),
          ),
          backgroundColor: AppTheme.secondaryColor,
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50.h,
            child: widget.specialties.length == 0
                ? const Center(
              child: Text(
                'Aucune spécialité trouvée',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
                :
            GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  // crossAxisSpacing: 20,
                ),
                itemCount: widget.specialties.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(

                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectCliniqueScreen(
                              clinics: widget.clinics ?? [],
                              vet_id: widget.vet_id,
                              price:widget.specialties[index]['price'],
                            )),
                      );
                    },
                    child: Container(

                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(

                          color: AppTheme.mainColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            widget.specialties[index]['price'] + '€' ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          Text(
                            widget.specialties[index]['name']  ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                }),




          ),
        ));
  }
}
