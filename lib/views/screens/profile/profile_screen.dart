import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/viewmodels/auth_viewmodel.dart';
import 'package:vet/views/screens/profile/edit_profile_screen.dart';
import 'package:vet/views/widgets/custom_progress.dart';

class ProfileScreen extends StatelessWidget {
  static const route = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

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
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Consumer<AuthViewModel>(builder: (context, auth, _) {
          return auth.loading
              ? const Center(child: CustomProgress())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, EditProfileScreen.route);
                                },
                              ),
                            ),
                            const SizedBox(height: AppTheme.divider * 2),
                            Text(
                              "${auth.user?.first_name} ${auth.user?.last_name}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5.w,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: AppTheme.divider),
                            Text(
                              "${auth.user?.email}",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 4.w),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 40),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: Text("Nom: ${auth.user?.last_name}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: Text("Prénom: ${auth.user?.first_name}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email),
                              title: Text("Email: ${auth.user?.email}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.date_range_outlined),
                              title: Text(
                                  "Date de naissance: ${auth.user?.birth_date?.year}/${auth.user?.birth_date?.month}/${auth.user?.birth_date?.day}"),
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: Text("Tel: ${auth.user?.phone_number}"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5.w,),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4.0,
                              )
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text("Déconnecter"),
                              onTap: () {
                                auth.logout();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
