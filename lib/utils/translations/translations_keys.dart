import 'package:get/get.dart';

import 'translate.dart';

class TranslationsKeys extends Translations {
  final Translate key = Translate();

  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          key.appTitle: 'Random Spin',
          key.settings: 'Settings',
          key.language: 'Language',
          key.arabic: 'Arabic',
          key.english: 'English',
          key.addNamesFirst: 'Add Names First !',
          key.addOneMoreName: 'Add One More Name !',
          key.enterTheName: 'Enter The Name',
          key.cancel: 'Cancel',
          key.add: 'Add',
          key.writeHere: 'Write here...',
          key.spin: 'Spin',
          key.wins: 'WINS!',
          key.remove: 'Remove',
          key.continues: 'Continue',
          key.useInstructions: 'Use instructions',
          key.aboutUs: 'About us',
          key.youCanSpinTheWheel: 'You can spin the wheel or press to "spin" .',
          key.doubleClickOnNameToDelete: 'Double click on name to delete it .',
          key.youCanMuteWheelSoundFromTheSettings:
              'You can mute wheel sound from the settings .',
          key.sound: 'Sound',
          key.versionNumber: 'Version number',
          key.developerInfo: 'Developer info',
          key.name: 'Name',
          key.email: 'Email',
          key.somethingWrongTryAgain: 'Something wrong, Try again!',
        },
        'ar': {
          key.appTitle: 'عجلة الحظ',
          key.settings: 'الإعدادات',
          key.language: 'اللغة',
          key.arabic: 'العربية',
          key.english: 'الإنجليزية',
          key.addNamesFirst: 'أضف الأسماء أولاً !',
          key.addOneMoreName: 'أضف اسماً آخر !',
          key.enterTheName: 'أدخل الاسم',
          key.cancel: 'إلغاء',
          key.add: 'إضافة',
          key.writeHere: 'اكتب هنا...',
          key.spin: 'اسحب',
          key.wins: 'فاز',
          key.remove: 'حذف',
          key.continues: 'أكمل',
          key.useInstructions: 'تعليمات الاستخدام',
          key.aboutUs: 'عن التطبيق',
          key.youCanSpinTheWheel: 'يمكنك تدوير العجلة أو الضغط على "اسحب" .',
          key.doubleClickOnNameToDelete: 'اضغط مرتين على الاسم لحذفه .',
          key.youCanMuteWheelSoundFromTheSettings:
              'يمكنك كتم صوت العجلة من الإعدادات .',
          key.sound: 'الصوت',
          key.versionNumber: 'رقم الإصدار',
          key.developerInfo: 'معلومات المطور',
          key.name: 'الاسم',
          key.email: 'البريد الالكتروني',
          key.somethingWrongTryAgain: 'حدث خطأ، أعد المحاولة !',
        }
      };
}
