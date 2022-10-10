import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/models/vet_model.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';
import 'package:tonveto/views/screens/appointments/select_specialty.dart';
import 'package:tonveto/views/screens/commentaires/commentaires_screen.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_progress.dart';
import '../../widgets/widgets.dart';

class VetProfileScreen extends StatefulWidget {
  static const route = "/vet-profile";
  final Veterinaire vet;

  const VetProfileScreen({required this.vet, Key? key}) : super(key: key);

  @override
  State<VetProfileScreen> createState() => _VetProfileScreenState();
}

class _VetProfileScreenState extends State<VetProfileScreen> {
  Veterinaire? vet;

  getVet() async {

    try {
      vet = await Provider.of<SearchViewModel>(context, listen: false).getVet(
        widget.vet.id,
        Provider.of<AuthViewModel>(context, listen: false).user?.id,
        Provider.of<AuthViewModel>(context, listen: false).token,
      );
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      getVet();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textLocals = AppLocalizations.of(context)!;

    double rating = 0;
    int somme = 0;
    for (int i = 0; i < (vet?.comments?.length ?? 0); i++) {
      somme = somme + (vet?.comments?[i].rating ?? 0);
    }

    if (vet?.comments?.length == 0) {
      rating = somme / (vet?.comments?.length ?? 1);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: vet?.firstName == null
            ? const SizedBox()
            : Text(
                "${vet?.firstName} ${vet?.lastName}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 5.w,
                    fontWeight: FontWeight.bold),
              ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: SafeArea(
        child: Provider.of<SearchViewModel>(context).loading
            ? const CustomProgress()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 50.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.mainColor,
                        ),
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage('assets/images/veterinaire.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    if(vet!=null)
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10),
                      child: CustomButton(
                          text: textLocals.prendreUnRendezVous,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectSpecialty(
                                        specialties:
                                            vet?.specialities ?? [],
                                        clinics: vet?.clinics ?? [],
                                        vetId: vet?.id ?? '',
                                      )),
                            );
                          }),
                    ),


                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10),
                      child: CustomButton(
                          color: const Color(0xFFFFB200),
                          text: textLocals.commentairesEtEvalutations,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentairesScreen(
                                      comments: vet?.comments ?? [])),
                            );
                          }),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                            )
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: AbsorbPointer(
                                  child: StarRating(
                                    rating: (rating).toDouble(),
                                    onRatingChanged: (rating) =>
                                        setState(() => 5 + 5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: AppTheme.mainColor,
                              ),
                              title: InfoWidget(
                                info: '${widget.vet.firstName}',
                                infoType: textLocals.nom,
                              )),
                          ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: AppTheme.mainColor,
                              ),
                              title: InfoWidget(
                                info: '${widget.vet.lastName}',
                                infoType: textLocals.prenom,
                              )),
                          ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: AppTheme.mainColor,
                              ),
                              title: InfoWidget(
                                info: '${widget.vet.phoneNumber}',
                                infoType: textLocals.telephone,
                              )),
                        ],
                      ),
                    ),
                    if(vet!=null)
                    Padding(
                      padding: vet?.specialities?.length != 0
                          ? const EdgeInsets.only(left: 15, bottom: 10)
                          : const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vet?.specialities?.length == 0
                              ? const SizedBox()
                              :  Padding(
                                  padding:
                                   const    EdgeInsets.only(left: 15.0, bottom: 10),
                                  child: Text(
                                    textLocals.specialites,
                                    style: const TextStyle(
                                        color: AppTheme.mainColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          LayoutBuilder(

                            builder:(context, constraints) => SizedBox(
                              height: vet?.specialities?.length == 0 ? 0 : 75,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: vet?.specialities?.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppTheme.mainColor,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${vet?.specialities?[index]['name']}",
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 16),
                                        ),
                                        Text(
                                          "${vet?.specialities?[index]['price']} €",
                                          style: const TextStyle(
                                              color: AppTheme.mainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if(vet!=null)
                    vet?.clinics?.length == 0
                        ? const SizedBox()
                        :  Padding(
                            padding:const EdgeInsets.only(left: 30.0),
                            child: Text(
                              textLocals.cliniques,
                              style:const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                    if(vet!=null)
                    vet?.clinics?.length == 0
                        ? const SizedBox()
                        : Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50.h,
                            child: vet?.clinics?.length == 0
                                ?  Center(
                                    child: Text(
                                      textLocals.aucuneCliniqueTrouvee,
                                      style:const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: vet?.clinics?.length,
                                    itemBuilder: (context, index) {
                                      return CliniqueCard(
                                          clinique: vet?.clinics?[index]);
                                    },
                                  ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
