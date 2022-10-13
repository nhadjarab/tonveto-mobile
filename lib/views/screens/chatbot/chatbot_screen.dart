import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/consts.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/message_model.dart';
import 'package:tonveto/viewmodels/chatbot_viewmodel.dart';
import 'package:tonveto/views/widgets/custom_button.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  List<Message> messages = [];

  int currentOperation = 0;

  bool _showSpeciesMenu = false;
  bool _showSymptomsMenu = false;

  String? _species;
  final List<String> _selectedSymptoms = [];

  List symptoms = [];

  clear() {
    currentOperation = 0;
    messages.clear();
    _showSpeciesMenu = false;
    _species = null;
    _showSymptomsMenu = false;
    _selectedSymptoms.clear();
    setState(() {});
  }

  Widget? getOperation() {
    switch (currentOperation) {
      case 0:
        // Say Hello
        return GestureDetector(
          onTap: () {
            currentOperation = 1;
            messages
                .add(Message(isOwn: true, message: "Bonjour"));
            setState(() {});

            Future.delayed(const Duration(seconds: 1), () {
              messages.add(
                  Message(isOwn: false, message: "Bonjour. Je suis Roxane, l'assistante Tonveto. Comment puis-je vous aider ?"));
              setState(() {});
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("Bonjour"), Icon(Icons.send)],
          ),
        );
      case 1:
        return GestureDetector(
          onTap: () {
            messages.add(Message(isOwn: true, message: "Je veux avoir un diagnostic"));
            setState(() {});

            Future.delayed(const Duration(seconds: 1), () {
              messages.add(Message(
                  isOwn: false,
                  message:
                      "Quelle est l'espèce de votre animal ?"));
              _showSpeciesMenu = true;
              setState(() {});
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("Je veux avoir un diagnostic"), Icon(Icons.send)],
          ),
        );
      case 2:
        messages.add(
            Message(isOwn: false, message: "Quelles sont les symptômes que présentent votre $_species ?"));
        break;
      case 3:
        return GestureDetector(
          onTap: clear,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Voulez-vous un autre diagnostic ?"),
              Icon(Icons.repeat)
            ],
          ),
        );
      default:
        return const Text("Bonjour");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chatbot",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppTheme.mainColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                return Row(
                  mainAxisAlignment: message.isOwn
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 70.w),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: message.isOwn
                            ? Colors.grey[300]
                            : AppTheme.mainColor,
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: message.isOwn ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _showSpeciesMenu
              ? CustomButton(
                  text: "Liste des animaux",
                  onPressed: () {
                    showSpeciesMenu();
                  })
              : _showSymptomsMenu
                  ? CustomButton(
                      text: "Liste des symptômes",
                      onPressed: () {
                        showSymptomsMenu();
                      })
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 15),
                      color: Colors.grey[100],
                      child: getOperation() ?? const SizedBox())
        ],
      ),
    );
  }

  // species bottom menu
  void showSpeciesMenu() async {
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: 60.h,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      itemCount: species.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<String?>(
                          value: species[index],
                          onChanged: (value) {
                            setState(() {
                              _species = value;
                            });
                          },
                          groupValue: _species,
                          title: Text(species[index]),
                        );
                      },
                    )),
                    CustomButton(
                      text: "Confirmer",
                      onPressed: () {
                        if (_species != null) {
                          Navigator.pop(context);
                          _showSpeciesMenu = false;
                          currentOperation = 2;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("")));
                        }
                      },
                    ),
                    const SizedBox(height: AppTheme.divider)
                  ],
                ),
              ),
            );
          });
        });
    if (_species != null) {
      messages.add(Message(isOwn: true, message: _species!));
      messages.add(Message(isOwn: false, message: "Un instant s'il vous plait. Je récupère la liste des symptômes"));
      setState(() {});

      try {
        ChatbotViewModel chatbotViewModel = ChatbotViewModel();
        final predictedSym = await chatbotViewModel.getSymptoms(_species!);
        symptoms.addAll(predictedSym);
        _showSymptomsMenu = true;
        setState(() {});
      } on SocketException {
        currentOperation = 1;
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Vous êtes hors ligne',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        messages.add(Message(isOwn: false, message: "Vous êtes hors ligne."));

        setState(() {});
      }
    }
  }

  void showSymptomsMenu() async {
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: 60.h,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      itemCount: symptoms.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: _selectedSymptoms.contains(symptoms[index]),
                          onChanged: (value) {
                            if (value != null && value) {
                              setState(() {
                                _selectedSymptoms.add(symptoms[index]);
                              });
                            } else {
                              setState(() {
                                _selectedSymptoms.remove(symptoms[index]);
                              });
                            }
                          },
                          title: Text(symptoms[index]),
                        );
                      },
                    )),
                    CustomButton(
                      text: "Confirmer",
                      onPressed: () {
                        if (_selectedSymptoms.isNotEmpty) {
                          Navigator.pop(context);
                          _showSymptomsMenu = false;
                          currentOperation = 3;
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Vous devez choisir au moins un symptôme.")));
                        }
                      },
                    ),
                    const SizedBox(height: AppTheme.divider)
                  ],
                ),
              ),
            );
          });
        });
    if (_selectedSymptoms.isNotEmpty) {
      messages.add(Message(isOwn: true, message: _selectedSymptoms.join(", ")));
      messages.add(Message(isOwn: false, message: "Un instant s'il vous plait..."));
      setState(() {});

      try {
        ChatbotViewModel chatbotViewModel = ChatbotViewModel();
        final prediction =
            await chatbotViewModel.predictDisease(_species!, _selectedSymptoms);
        messages
            .add(Message(isOwn: false, message: "Voilà ce que j'ai trouvé. Votre $_species pourrait avoir la maladie suivante :"));
        messages.add(Message(
            isOwn: false,
            message: prediction?.join(", ") ??
                "Désolé,je n'ai pas trouvé de maladie."));

        currentOperation = 3;
        setState(() {});
      } on SocketException {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Vous êtes hors ligne',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}
