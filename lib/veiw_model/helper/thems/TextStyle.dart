import 'package:flutter/material.dart';
import 'color.dart';

  // 1. اسم السورة بالعربي (مصمم للعناوين الكبيرة)
   TextStyle surahNameArStyle() {
    return TextStyle(
      fontFamily: 'Lalezar',
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: textPrimary, // تم التغيير إلى textPrimary
      letterSpacing: 0.5,
    );
  }

  // 2. اسم السورة بالإنجليزي (نص مساعد)
   TextStyle surahNameEnStyle() {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: textSecondary, // تم التغيير إلى textSecondary
      letterSpacing: 0.3,
    );
  }

  // 3. عدد الآيات (معلومات إضافية)
   TextStyle ayahCountStyle() {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: 13,
      color: textDisabled, // تم التغيير إلى textDisabled
    );
  }

  // 4. الخط الرئيسي للنصوص العامة
   TextStyle appBodyStyle() {
    return const TextStyle(
      fontFamily: 'Cairo',
      fontSize: 16,
      height: 1.6,
      color: textPrimary, // تم التغيير إلى textPrimary
    );
  }

  // 5. عنوان AppBar (بارز ولكن ليس صارخاً)
   TextStyle appBarTitleStyle() {
    return TextStyle(
      fontFamily: 'Lalezar',
      fontSize: 26,
      color: primaryColor, // تم التغيير إلى primaryColor
      letterSpacing: 1.0,
    );
  }

  // 6. عناوين الأقسام الرئيسية
   TextStyle sectionHeaderStyle() {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: primaryDark, // تم التغيير إلى primaryDark
      height: 1.4,
    );
  }

  // 7. نصوص الأزرار (واضحة ومقروءة)
   TextStyle buttonTextStyle() {
    return const TextStyle(
      fontFamily: 'Cairo',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: 0.5,
    );
  }

  // 8. نصوص الترجمة (مريحة للقراءة الطويلة)
   TextStyle translationTextStyle() {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: 15,
      height: 1.7,
      color: textPrimary.withOpacity(0.8), // تم التغيير إلى textPrimary
    );
  }

  // 9. رقم السورة في الدائرة (بارز ولكن متناسق)
   TextStyle surahNumberCircleStyle() {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  // 10. خط المصحف العثماني (مخصص لآيات القرآن)
   TextStyle quranAyahStyle() {
    return const TextStyle(
      fontFamily: 'KFGQPC Uthmanic',
      fontSize: 24,
      height: 2.2,
      color: textPrimary, // تم التغيير إلى textPrimary
    );
  }

  // 11. نص الآية عند التحديد (إضافة جديدة)
   TextStyle selectedAyahStyle() {
    return TextStyle(
      fontFamily: 'KFGQPC Uthmanic',
      fontSize: 24,
      height: 2.2,
      color: primaryColor, // تم التغيير إلى primaryColor
      backgroundColor: primaryColor.withOpacity(0.1),
    );
  }

  // 12. نص تفسير الآيات (إضافة جديدة)
   TextStyle tafsirTextStyle() {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: 15,
      height: 1.8,
      color: textPrimary.withOpacity(0.9), // تم التغيير إلى textPrimary
    );
  }

  // 13. أسلوب خاص بعلامات السجود (إضافة جديدة)
   TextStyle sajdaMarkerStyle() {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: primaryColor, // تم التغيير إلى primaryColor
    );
  }

  // 14. أسلوب خاص بأرقام الأجزاء (إضافة جديدة)
   TextStyle juzNumberStyle() {
    return TextStyle(
      fontFamily: 'Lalezar',
      fontSize: 20,
      color: accentColor, // تم التغيير إلى accentColor
    );
  }
