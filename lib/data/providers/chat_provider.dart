import 'package:flutter_riverpod/legacy.dart';
import '../models/chat_message.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState(messages: [], isTyping: false));

  Future<void> sendMessage(String message) async {
    final userMessage = ChatMessage(text: message, timestamp: DateTime.now(), isUser: true);
    state = ChatState(messages: [...state.messages, userMessage], isTyping: true);

    // Simulate AI response
    await Future.delayed(const Duration(seconds: 1));
    final botMessage = ChatMessage(
      text: 'Thanks for your message! This is a simulated AI response. Your app now has full authentication, onboarding, optimization, insights, alerts, and chat features.',
      timestamp: DateTime.now(),
      isUser: false,
    );
    state = ChatState(messages: [...state.messages, botMessage], isTyping: false);
  }
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;

  const ChatState({
    required this.messages,
    required this.isTyping,
  });
}
