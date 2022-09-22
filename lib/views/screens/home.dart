import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tonveto/views/screens/profile/profile_screen.dart';
import 'package:tonveto/views/widgets/custom_progress.dart';
import 'package:tonveto/views/widgets/widgets.dart';

import '../../config/theme.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/search_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_fields.dart';

class Home extends StatefulWidget {
  static const route = "/home";

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> specialities = [
    'Consultation',
    'Dermatologie',
    'Cardiologie',
    'Chirurgie',
    'Orthopédie',
    'Ophtalmologie',
  ];
  int? selectedIndex = 100;

  TextEditingController city = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController clinicName = TextEditingController();
  TextEditingController vetName = TextEditingController();
  TextEditingController speciality = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController country = TextEditingController();

  search() async {
    await Provider.of<SearchViewModel>(context, listen: false).search(
      city.text,
      zipCode.text,
      vetName.text,
      clinicName.text,
      speciality.text,
      adress.text,
      country.text,
      Provider.of<AuthViewModel>(context, listen: false).token,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthViewModel>(context, listen: false).getUserData();
      search();
    });

    super.initState();
  }

  @override
  void dispose() {
    city.dispose();
    zipCode.dispose();
    clinicName.dispose();
    vetName.dispose();
    speciality.dispose();
    adress.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _dialogBuilder(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Dialog(
              insetPadding: EdgeInsets.all(10),
              //insetPadding: EdgeInsets.zero,
              // contentPadding: EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //  mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: const [
                            Text(
                              'Filtres',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VetTextField(
                          hintText: 'Ville',
                          controller: city,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VetTextField(
                          hintText: 'Code postal',
                          controller: zipCode,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VetTextField(
                          hintText: 'Nom de la clinique',
                          controller: clinicName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VetTextField(
                          hintText: 'Nom du vétérinaire',
                          controller: vetName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VetTextField(
                          hintText: 'Adresse',
                          controller: adress,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VetTextField(
                          hintText: 'Pays',
                          controller: country,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            width: MediaQuery.of(context).size.width * 0.4,
                            text: 'Filtrer',
                            padding: 0,
                            onPressed: () async {
                              Navigator.pop(context);
                              await search();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.mainColor,
        body: Provider.of<SearchViewModel>(
          context,
        ).loading
            ? const CustomProgress()
            : SingleChildScrollView(
                child: Container(
                  color: AppTheme.mainColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [

                                 Text(
                                  'Page principale',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Trouver un bon vétérinaire',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'n\'a jamais été si facile',
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                _dialogBuilder(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    const Icon(Icons.search),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text(
                                      'Filtrer',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    const Spacer(),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: AppTheme.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SvgPicture.asset(
                                        "assets/icons/parametre.svg",
                                        color: Colors.white,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: const BoxDecoration(
                            color: AppTheme.secondaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Spécialités',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: specialities.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        if (selectedIndex == index) {
                                          selectedIndex = 100;
                                          speciality.text = '';
                                        } else {
                                          selectedIndex = index;
                                          speciality.text = specialities[index];
                                        }
                                      });
                                      await search();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppTheme.mainColor,
                                        ),
                                        color: selectedIndex == index
                                            ? AppTheme.mainColor
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        specialities[index],
                                        style: TextStyle(
                                            color: selectedIndex != index
                                                ? AppTheme.mainColor
                                                : Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Consumer<SearchViewModel>(
                                builder: (context, value, child) {
                              return DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    const TabBar(
                                      labelColor: AppTheme.mainColor,
                                      unselectedLabelColor: Colors.grey,
                                      tabs: [
                                        Tab(
                                          text: "Vétérinaires",
                                        ),
                                        Tab(
                                          text: "Cliniques",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: TabBarView(children: [
                                        value.searchResult?.veterinaires
                                                    ?.length ==
                                                0
                                            ? const Center(
                                                child: Text(
                                                  'Aucun vétérinaire trouvé',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: value.searchResult
                                                    ?.veterinaires?.length,
                                                itemBuilder: (context, index) {
                                                  return VetCard(
                                                      veterinaire: value
                                                              .searchResult
                                                              ?.veterinaires?[
                                                          index]);
                                                },
                                              ),
                                        value.searchResult?.cliniques?.length ==
                                                0
                                            ? const Center(
                                                child: Text(
                                                  'Aucune clinique trouvée',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount: value.searchResult
                                                    ?.cliniques?.length,
                                                itemBuilder: (context, index) {
                                                  return CliniqueCard(
                                                      clinique: value
                                                          .searchResult
                                                          ?.cliniques?[index]);
                                                },
                                              ),
                                      ]),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
