import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/views/screens/appointments/select_date_screen.dart';

import '../../widgets/widgets.dart';

class SelectCliniqueScreen extends StatefulWidget {
  SelectCliniqueScreen(
      {required this.clinics,
      required this.vet_id,
      required this.price,
      Key? key})
      : super(key: key);
  List<Clinique> clinics;
  String vet_id;
  String price;

  @override
  _SelectCliniqueScreenState createState() => _SelectCliniqueScreenState();
}

class _SelectCliniqueScreenState extends State<SelectCliniqueScreen> {
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
        title: const Text('Sélectionner une clinique'),
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50.h,
        child: widget.clinics.length == 0
            ? const Center(
                child: Text(
                  'Aucune clinique trouvée',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: widget.clinics.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectDateScreen(
                                  clinique_id: widget.clinics[index].id ?? '',
                                  vet_id: widget.vet_id,
                              price: widget.price,
                                )),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/clinic.png'),
                            radius: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.clinics[index].name}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.clinics[index].address} , ${widget.clinics[index].city} , ${widget.clinics[index].country}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.clinics[index].phone_number}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    ));
  }
}
