import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/viewmodels/search_viewmodel.dart';
import 'package:tonveto/views/widgets/custom_button.dart';
import '../../../config/theme.dart';
import '../../../models/clinique_model.dart';
import '../../widgets/custom_progress.dart';

class ClinicProfileScreen extends StatefulWidget {
  static const route = "/clinique-profile";
  Clinique clinique;

  ClinicProfileScreen({required this.clinique, Key? key}) : super(key: key);

  @override
  _ClinicProfileScreenState createState() => _ClinicProfileScreenState();
}

class _ClinicProfileScreenState extends State<ClinicProfileScreen> {
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
                      padding:const EdgeInsets.all(5),
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
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 40),
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
                                  const  TextSpan(
                                    text: 'Nom:',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.mainColor),
                                  ),
                                  TextSpan(
                                    text: " ${widget.clinique.name}",
                                    style:const TextStyle(
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
                                 const  TextSpan(
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
                                    text: " ${widget.clinique.phone_number}",
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
                                    text: " ${widget.clinique.zip_code}",
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
                  ],
                ),
              ),
      ),
    );
  }
}
