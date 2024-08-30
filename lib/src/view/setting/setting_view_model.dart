// import 'package:battery_todo/src/service/lang_service.dart';
// import 'package:battery_todo/src/service/notification_service.dart';
// import 'package:battery_todo/src/service/theme_service.dart';
// import 'package:battery_todo/src/view/base_view_model.dart';
// import 'package:flutter/material.dart';
//
// class SettingViewModel extends BaseViewModel {
//   SettingViewModel({
//     required this.themeService,
//     required this.langService,
//     required this.notificationService,
//   });
//
//   final ThemeService themeService;
//   final LangService langService;
//   final NotificationService notificationService;
//   bool isSchedule = false;
//
//   TimeOfDay selectedTime = TimeOfDay.now();
//
//   void onDateTimeChanged(DateTime newDateTime) {
//     selectedTime =
//         TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute);
//     notifyListeners();
//   }
//
//   void setScheduleNotify() {
//     notificationService.scheduleDailyNotification(selectedTime!);
//     notifyListeners();
//   }
//
//   void setSchedule(bool newSchedule) {
//     if (isSchedule) {
//       notificationService.cancelAllNotifications();
//     }
//     isSchedule = newSchedule;
//
//     notifyListeners();
//   }
// }
