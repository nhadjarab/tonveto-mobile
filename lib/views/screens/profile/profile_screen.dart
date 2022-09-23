import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme.dart';
import '../../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_progress.dart';
import 'edit_profile_screen.dart';

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
      backgroundColor: AppTheme.secondaryColor,
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
                        decoration:
                        BoxDecoration(color: Colors.white,
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
                              title: Text("Nom: ${auth.user?.last_name}"),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: AppTheme.mainColor,
                              ),
                              title: Text("Prénom: ${auth.user?.first_name}"),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.email,
                                color: AppTheme.mainColor,
                              ),
                              title: Text("Email: ${auth.user?.email}"),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.date_range_outlined,
                                color: AppTheme.mainColor,
                              ),
                              title: Text(
                                  "Date de naissance: ${auth.user?.birth_date?.year}/${auth.user?.birth_date?.month}/${auth.user?.birth_date?.day}"),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: AppTheme.mainColor,
                              ),
                              title: Text("Tel: ${auth.user?.phone_number}"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        padding: const EdgeInsets.all(10),decoration:
                      BoxDecoration(color: Colors.white,
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
                                Icons.logout,
                                color: AppTheme.mainColor,
                              ),
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
