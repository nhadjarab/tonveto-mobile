import 'package:tonveto/services/chatbot_service.dart';

class ChatbotViewModel {
  Future getSymptoms(String species) async {
    try {
      final ChatbotService chatbotService = ChatbotService();
      return await chatbotService.getSymptoms(species);
    } catch (e) {
      return [];
    }
  }

  Future predictDisease(String species, List symptoms) async {
    try {
      final ChatbotService chatbotService = ChatbotService();
      return await chatbotService.predictDisease(species, symptoms);
    } catch (e) {
      return [];
    }
  }
}
