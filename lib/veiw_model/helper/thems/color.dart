import 'package:flutter/material.dart';

Color backgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF121B22)
      : Color(0xFFE0EFEC);
}

Color colorQuranPages(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFFE0EFEC)
      : Color(0xFF121B22);
}

Color primaryColor = Color(0xFF2D9596);
const Color primaryLight = Color(0xFF9AD0C2);
const Color primaryDark = Color(0xFF1A6E7A); // غامق من اللون الرئيسي
const Color continar = Color(0xFF88BCA4); // غامق من اللون الرئيسي

// 🎨 الألوان الثانوية (Secondary Colors)
const Color accentColor = Color(0xFFF1B24A); // لون مميز (ذهبي دافئ)
const Color secondaryColor = Color(0xFFB8D8D8); // لون ثانوي هادئ

// 📝 ألوان النصوص (Text Colors)
const Color textPrimary = Color(0xFF1E3A40); // نص رئيسي (داكن مريح)
const Color textSecondary = Color(0xFF6C8A93); // نص ثانوي
const Color textDisabled = Color(0xFFA7BEC5); // نص غير نشط

// 🖼 ألوان الخلفيات والسطوح (Background & Surface)
const Color surfaceColor = Color(0xFFFFFFFF); // لون البطاقات والسطح
const Color dividerColor = Color(0xFFE0E9EC); // لون الحدود والفاصل

const Color ayahHighlight = Color(0xFFE8F4EA); // تمييز الآيات
const Color lastReadingColor = Color(0xFFF5F0E6);

/// أذكار - أخضر نعناعي فاتح (يرمز للسلام والطمأنينة)
const Color azkarColor = Color(0xFFE8F8F5);

/// القرآن الكريم - أزرق سماوي فاتح (يرمز للسكينة والروحانية)
const Color quranColor = Color(0xFFE6F3FF);

/// القبلة - بنفسجي فاتح (لطيف وغير صارخ)
const Color qiblaColor = Color(0xFFF0E6FF);

/// المفضلة - أصفر خفيف جداً (باستيلي لا يزعج العين)
const Color favoritesColor = Color(0xFFFFF8E6);
// في colors.dart (أضف هذين الثابتين)
