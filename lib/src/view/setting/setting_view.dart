// import 'package:battery_todo/src/repository/setting_repository.dart';
// import 'package:battery_todo/src/service/lang_service.dart';
// import 'package:battery_todo/src/service/notification_service.dart';
// import 'package:battery_todo/src/service/theme_service.dart';
// import 'package:battery_todo/src/view/base_view.dart';
// import 'package:battery_todo/src/view/setting/setting_view_model.dart';
// import 'package:battery_todo/theme/component/time_picker.dart';
// import 'package:battery_todo/util/helper/intl_helper.dart';
// import 'package:battery_todo/util/lang/generated/l10n.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// ///나중에 설정값들이 많아지면 사용할 페이지 현재는 사용하지 않음.
//
// class SettingView extends StatelessWidget {
//   const SettingView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseView(
//       viewModel: SettingViewModel(
//         themeService: context.read<ThemeService>(),
//         langService: context.read<LangService>(),
//         notificationService: context.read<NotificationService>(),
//       ),
//       builder: (BuildContext context, SettingViewModel viewModel) => Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text(S.current.setting),
//           titleSpacing: 20,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: context.color.hintContainer,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.close),
//                 ),
//               ),
//             )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 '알림 설정',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey,
//                 ),
//               ),
//               ListTile(
//                 tileColor: context.color.hintContainer,
//                 title: Row(
//                   children: [
//                     Text('할 일 정리 시간'),
//                     Switch(
//                       value: true,
//                       onChanged: (value) {
//                         // 스위치 액션
//                         context
//                             .read<NotificationService>()
//                             .cancelAllNotifications();
//                       },
//                     ),
//                   ],
//                 ),
//                 subtitle: Row(
//                   children: [
//                     Text('할 '),
//                     GestureDetector(
//                       onTap: () {},
//                       child: Text(
//                         //이부분을 초기화하기//포메팅하기
//                         viewModel.selectedTime.toString(),
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     viewModel.notificationService
//                         .scheduleDailyNotification(viewModel.selectedTime!);
//                     viewModel.setScheduleNotify();
//                   },
//                   child: Text('예약'),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   '테마',
//                   style: context.typo.headline3,
//                 ),
//                 tileColor: context.color.hintContainer,
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     viewModel.themeService.toggleTheme();
//                   },
//                   child: Text('theme'),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   S.current.language,
//                   style: context.typo.headline3,
//                 ),
//                 tileColor: context.color.hintContainer,
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     viewModel.langService.toggleLang();
//                   },
//                   child: Text('lang'),
//                 ),
//               ),
//               Text(viewModel.selectedTime.toString()),
//               SwitchListTile(
//                 value: viewModel.isSchedule,
//                 onChanged: (value) {
//                   viewModel.setSchedule(value);
//                   if (value) {
//                     showCupertinoModalPopup(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return TimePicker(
//                             selectedTime:
//                                 viewModel.selectedTime ?? TimeOfDay.now(),
//                             onDateTimeChanged: viewModel.onDateTimeChanged);
//                       },
//                     );
//                   }
//                 },
//                 title: Text('알람 설정'),
//               ),
//               ListTile(
//                 title: Text(
//                     '할 일 정리 시간: ${IntlHelper.extractTime(viewModel.notificationService.getScheduleTime())}'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
