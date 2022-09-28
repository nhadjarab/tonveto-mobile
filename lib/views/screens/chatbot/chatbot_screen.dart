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
                .add(Message(isOwn: true, message: "Hello $appName chatbot"));
            setState(() {});

            Future.delayed(const Duration(seconds: 1), () {
              messages.add(
                  Message(isOwn: false, message: "Hi, How can i help you ?"));
              setState(() {});
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("Say Hello!"), Icon(Icons.send)],
          ),
        );
      case 1:
        return GestureDetector(
          onTap: () {
            messages.add(Message(isOwn: true, message: "My pet is sick ?"));
            setState(() {});

            Future.delayed(const Duration(seconds: 1), () {
              messages.add(Message(
                  isOwn: false,
                  message:
                      "Can you specify the species, please from the list ?"));
              _showSpeciesMenu = true;
              setState(() {});
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("My pet is sick"), Icon(Icons.send)],
          ),
        );
      case 2:
        messages.add(
            Message(isOwn: false, message: "Choose your $_species symptoms"));
        break;
      case 3:
        return GestureDetector(
          onTap: clear,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Question the chatbot again"),
              Icon(Icons.repeat)
            ],
          ),
        );
      default:
        return const Text("Say Hello!");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "$appName Chat-Bot",
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
                  text: "Show species list",
                  onPressed: () {
                    showSpeciesMenu();
                  })
              : _showSymptomsMenu
                  ? CustomButton(
                      text: "Show symptoms list",
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
                                  content: Text("You must choose a species")));
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
      messages.add(Message(isOwn: false, message: "Wait a moment please"));
      setState(() {});
      ChatbotViewModel chatbotViewModel = ChatbotViewModel();
      final predictedSym = await chatbotViewModel.getSymptoms(_species!);
      symptoms.addAll(predictedSym);
      _showSymptomsMenu = true;
      setState(() {});
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
                                      Text("You must choose the symptoms")));
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
      messages.add(Message(isOwn: false, message: "Wait a moment please"));
      setState(() {});

      ChatbotViewModel chatbotViewModel = ChatbotViewModel();
      final prediction =
          await chatbotViewModel.predictDisease(_species!, _selectedSymptoms);
      messages
          .add(Message(isOwn: false, message: "This is what i think about"));
      messages.add(Message(
          isOwn: false,
          message: prediction?.join(", ") ??
              "We can't find a prediction for disease"));

      currentOperation = 3;
      setState(() {});
    }
  }
}
