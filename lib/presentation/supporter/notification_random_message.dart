import 'dart:math' as math;

const messageList = [
  'Hey! Are you done with your TODOs for today?',
  "It's time to check your TODOs!",
  "What's your next plan? Speak it to Volcano",
  "Didn't you forget to add a TODO from voice?",
  "You're doing well! So find what's you are going to do with Volcano",
  'If you have bigger fish to fry, you can definitely do it.',
];

String genRandomNotificationMessage() {
  final random = math.Random();
  final randomInt = random.nextInt(5);
  final luckyNumber = random.nextInt(31);

  if (luckyNumber == 7) {
    return messageList[5];
  }

  return messageList[randomInt];
}
