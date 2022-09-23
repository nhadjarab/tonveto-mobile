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
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
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
                      title: Text("Nom: ${widget.clinique.name}"),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: AppTheme.mainColor,
                      ),
                      title: Text("Prénom: ${widget.clinique.name}"),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: AppTheme.mainColor,
                      ),
                      title: Text("Email: ${widget.clinique.name}"),
                    ),

                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: AppTheme.mainColor,
                      ),
                      title: Text(
                          "Numéro de téléphone: ${widget.clinique.name}"),
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/bank_details.svg",
                        width: 30,
                        color: AppTheme.mainColor,
                      ),
                      title:
                      Text("Credit info: ${widget.clinique.name}"),
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
