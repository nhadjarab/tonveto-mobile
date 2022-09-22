import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/models/search_model.dart';
import 'package:vet/viewmodels/search_viewmodel.dart';
import 'package:vet/views/screens/profile/profile_screen.dart';
import 'package:vet/views/widgets/custom_button.dart';
import 'package:vet/views/widgets/custom_fields.dart';

import '../../viewmodels/auth_viewmodel.dart';

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
    });
    search();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.mainColor,
        body: Provider.of<SearchViewModel>(
          context,
        ).loading
            ? Center(
                child: CircularProgressIndicator(),
              )
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(
                                        context, ProfileScreen.route);
                                  },
                                  icon: const Icon(
                                    Icons.person,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Page principale',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await Provider.of<AuthViewModel>(context,
                                              listen: false)
                                          .logout();
                                    },
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Trouvez votre vétérinaire',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'désiré dès maintenant!',
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
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            //  mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Filtres',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Spacer(),
                                                  CustomButton(
                                                      text: 'Filtrer',
                                                      padding: 0,
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        await search();
                                                      })
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
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
                                              0.3,
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
                                                  return Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/veterinaire.png'),
                                                          radius: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'Dr ${value.searchResult?.veterinaires?[index].first_name} ${value.searchResult?.veterinaires?[index].last_name}',
                                                                      style: const TextStyle(
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ])),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${value.searchResult?.veterinaires?[index].phone_number}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                ),
                                                                Text(
                                                                  ' 4.8',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
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
                                                  return Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/clinic.png'),
                                                          radius: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${value.searchResult?.cliniques?[index].name}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                '${value.searchResult?.cliniques?[index].address} , ${value.searchResult?.cliniques?[index].city} , ${value.searchResult?.cliniques?[index].country}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                '${value.searchResult?.cliniques?[index].phone_number}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                ),
                                                                Text(
                                                                  ' 4.8',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
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
