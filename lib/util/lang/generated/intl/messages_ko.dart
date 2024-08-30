// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dark": MessageLookupByLibrary.simpleMessage("다크"),
        "disableHintText": MessageLookupByLibrary.simpleMessage("충전이 필요합니다."),
        "en": MessageLookupByLibrary.simpleMessage("영어"),
        "enableHintText":
            MessageLookupByLibrary.simpleMessage("해야 할 일을 입력해 주세요."),
        "ko": MessageLookupByLibrary.simpleMessage("한국어"),
        "language": MessageLookupByLibrary.simpleMessage("언어"),
        "light": MessageLookupByLibrary.simpleMessage("라이트"),
        "onboardingCondition": MessageLookupByLibrary.simpleMessage(
            "휴대폰 배터리가 100%일 때만 투두를 작성할 수 있어요. 배터리가 꽉 찼을 때 새로운 할 일을 추가해보세요!"),
        "onboardingDelete": MessageLookupByLibrary.simpleMessage(
            "투두를 왼쪽으로 스와이프하면 삭제할 수 있어요. 필요 없는 항목은 쉽게 제거하세요."),
        "onboardingDone": MessageLookupByLibrary.simpleMessage(
            "투두를 오른쪽으로 스와이프하면 완료 표시를 할 수 있어요."),
        "onboardingImportant": MessageLookupByLibrary.simpleMessage(
            "중요한 투두는 두 번 터치하여 강조할 수 있어요. 중요한 일은 눈에 띄게 표시해두세요."),
        "onboardingNotification": MessageLookupByLibrary.simpleMessage(
            "알람 권한을 허락해 주시면 앱 아이콘에서도 남은 투두를 확인할 수 있어요. 권한을 허용하여 할 일을 더 쉽게 관리해보세요."),
        "onboardingWelcome": MessageLookupByLibrary.simpleMessage(
            "환영합니다! 이 앱을 사용하여 효과적으로 할 일을 관리해보세요. 간단한 안내를 통해 앱의 주요 기능을 소개해드릴게요."),
        "setting": MessageLookupByLibrary.simpleMessage("설정"),
        "theme": MessageLookupByLibrary.simpleMessage("테마")
      };
}
