// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "disableHintText":
            MessageLookupByLibrary.simpleMessage("It needs to be charged."),
        "en": MessageLookupByLibrary.simpleMessage("English"),
        "enableHintText":
            MessageLookupByLibrary.simpleMessage("Enter what you need to do."),
        "ko": MessageLookupByLibrary.simpleMessage("Korean"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "onboardingCondition": MessageLookupByLibrary.simpleMessage(
            "You can only create to-dos when your phone battery is at 100%. Add new tasks when your battery is fully charged!"),
        "onboardingDelete": MessageLookupByLibrary.simpleMessage(
            "Swipe left on a to-do to delete it. Easily remove unnecessary items."),
        "onboardingDone": MessageLookupByLibrary.simpleMessage(
            "Swipe right on a to-do to mark it as done."),
        "onboardingImportant": MessageLookupByLibrary.simpleMessage(
            "Double tap a to-do to mark it as important. Highlight crucial tasks to keep them visible."),
        "onboardingNotification": MessageLookupByLibrary.simpleMessage(
            "By allowing notification permissions, you can see your remaining to-dos from the app icon. Enable permissions for easier task management."),
        "onboardingWelcome": MessageLookupByLibrary.simpleMessage(
            "Welcome! Use this app to manage your tasks effectively. Here’s a quick guide to the main features of the app."),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme")
      };
}
