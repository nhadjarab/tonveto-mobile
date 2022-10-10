import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/views/screens/appointments/select_date_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SelectCliniqueScreen extends StatefulWidget {
  const SelectCliniqueScreen(
      {required this.clinics,
      required this.vetId,
      required this.price,
      Key? key})
      : super(key: key);
 final  List<Clinique> clinics;
final  String vetId;
 final String price;

  @override
  State<SelectCliniqueScreen> createState() => _SelectCliniqueScreenState();
}

class _SelectCliniqueScreenState extends State<SelectCliniqueScreen> {
  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

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
        title:  Text(textLocals.selectionnerUneClinique),
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50.h,
        child: widget.clinics.length == 0
            ?  Center(
                child: Text(
                  textLocals.aucuneCliniqueTrouvee,
                  style:const  TextStyle(
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
                                  cliniqueId: widget.clinics[index].id ?? '',
                                  vetId: widget.vetId,
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
                                  '${widget.clinics[index].phoneNumber}',
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
