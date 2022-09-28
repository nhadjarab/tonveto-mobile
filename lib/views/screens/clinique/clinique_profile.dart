import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';

import 'package:tonveto/views/widgets/widgets.dart';
import '../../../config/theme.dart';
import '../../../models/clinique_model.dart';
import '../../../models/vet_model.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_progress.dart';

class ClinicProfileScreen extends StatefulWidget {
  static const route = "/clinique-profile";
  final Clinique clinique;

  const ClinicProfileScreen({required this.clinique, Key? key})
      : super(key: key);

  @override
  State<ClinicProfileScreen> createState() => _ClinicProfileScreenState();
}

class _ClinicProfileScreenState extends State<ClinicProfileScreen> {
  List<Veterinaire>? vets;

  getVets() async {
    vets = await Provider.of<SearchViewModel>(context, listen: false)
        .getClinicVets(
      widget.clinique.id,
      Provider.of<AuthViewModel>(context, listen: false).user?.id,
      Provider.of<AuthViewModel>(context, listen: false).token,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getVets();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: widget.clinique.name == null
            ? const SizedBox()
            : Text(
                "${widget.clinique.name}}",
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
                            image: AssetImage('assets/images/clinic.png'),
                            fit: BoxFit.contain),
                      ),
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
                          ListTile(
                            leading: const Icon(
                              Icons.person,
                              color: AppTheme.mainColor,
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Nom:',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.mainColor),
                                  ),
                                  TextSpan(
                                    text: " ${widget.clinique.name}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.location_on,
                              color: AppTheme.mainColor,
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Adresse:',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.mainColor),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${widget.clinique.address} , ${widget.clinique.city} , ${widget.clinique.country}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.phone,
                              color: AppTheme.mainColor,
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Numéro de téléphone:',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.mainColor),
                                  ),
                                  TextSpan(
                                    text: " ${widget.clinique.phoneNumber}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/icons/zip_code.svg",
                              width: 25,
                              color: AppTheme.mainColor,
                            ),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Code postal:',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.mainColor),
                                  ),
                                  TextSpan(
                                    text: " ${widget.clinique.zipCode}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    vets?.length == 0
                        ? const SizedBox()
                        : const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Vétérinaires',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                    vets?.length == 0
                        ? const SizedBox()
                        : Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50.h,
                            child: vets?.length == 0
                                ? const Center(
                                    child: Text(
                                      'Aucune Vétérinaire trouvée',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: vets?.length,
                                    itemBuilder: (context, index) {
                                      return VetCard(veterinaire: vets?[index]);
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
