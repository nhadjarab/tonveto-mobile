import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vet/config/theme.dart';
import 'package:vet/views/widgets/custom_button.dart';
import 'package:vet/views/widgets/custom_fields.dart';

class Home extends StatefulWidget {
  static const route = "/home";

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> specialities = [
    'consultation',
    'dermatologie',
    'cardiologie',
    'chirurgie',
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
        body: SingleChildScrollView(
          child: Container(
            color: AppTheme.mainColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SizedBox(),
                          Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.person,
                            size: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Find your desired',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Veteranian Right Now!',
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
                                              'Speciality',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            CustomButton(
                                                text: 'Filter',
                                                padding: 0,
                                                onPressed: () {})
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'City',
                                          controller: city,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'Zip code',
                                          controller: zipCode,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'Clinic name',
                                          controller: clinicName,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'Vet name',
                                          controller: vetName,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'Specialty',
                                          controller: speciality,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'Adress',
                                          controller: adress,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        VetTextField(
                                          hintText: 'Country',
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
                                'Search',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: AppTheme.mainColor,
                                    borderRadius: BorderRadius.circular(10)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Speciality',
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
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  speciality.text = specialities[index];
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectedIndex == index ? AppTheme.mainColor : Colors.white,
                                ),
                                child: Text(
                                  specialities[index],
                                  style:  TextStyle(
                                      color: selectedIndex != index ? AppTheme.mainColor : Colors.white, fontSize: 15),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            const TabBar(
                              labelColor: AppTheme.mainColor,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  text: "Veterinaires",
                                ),
                                Tab(
                                  text: "Cliniques",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: TabBarView(children: [
                                ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/veterinaire.png'),
                                            radius: 30,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Dr nassim fatmi',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Cardiologist',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '300 €',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                    ' 4.8',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              CustomButton(
                                                  text: 'Book',
                                                  padding: 0,
                                                  onPressed: () {})
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/clinic.png'),
                                            radius: 30,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Clinique name',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'adress , city , country',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '78222001',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                    ' 4.8',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              CustomButton(
                                                  text: 'Book',
                                                  padding: 0,
                                                  onPressed: () {})
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
                      ),
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
