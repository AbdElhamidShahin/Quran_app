import 'package:flutter/material.dart';
import 'package:quran_app/veiw/wedgit/CustomAppBar.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'عن التطبيق'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✨ مميزات تطبيق "قرآننا":',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('''
      ⏰ مواقيت الصلاة بدقة عالية  
      يعرض لك التطبيق مواقيت الصلاة حسب موقعك الجغرافي، بدقة وواجهة مريحة، مع إمكانية التنبيه بأوقات الأذان.
      
      📖 قراءة القرآن الكريم بسهولة وأناقة  
      واجهة مصممة بعناية لتمنحك تجربة قراءة ممتعة، مع خطوط مريحة للعين وخيارات تصفح مرنة.
      
      📍 متابعة القراءة من حيث توقفت  
      ميزة "آخر قراءة" تتيح لك العودة مباشرة إلى الصفحة أو السورة التي توقفت عندها دون الحاجة للبحث.
      
      🔵 السبحة الإلكترونية  
      عدد غير محدود من التسبيحات، مع تصميم هادئ يساعدك على الذكر في أي وقت، بدون تشتيت.
      
      🤲 مجموعة أذكار شاملة ومنظمة  
      أذكار الصباح والمساء، وأذكار بعد الصلاة، والنوم، والاستيقاظ، وغيرها الكثير، كلها مرتبة وسهلة التصفح.
      
      🧭 تحديد اتجاه القبلة بدقة  
      بوصلة ذكية تساعدك على معرفة اتجاه القبلة أينما كنت.
      
      📌 تجربة استخدام سلسة وواجهة باللغة العربية بالكامل
                  ''', style: TextStyle(fontSize: 18, height: 1.6)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
