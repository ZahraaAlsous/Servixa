import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';

class SliversDemoPage extends StatelessWidget {
  const SliversDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // نستخدم CustomScrollView كجسم أساسي للصفحة لتفعيل الـ Slivers
      body: CustomScrollView(
        slivers: <Widget>[
          // 1. شريط علوي مرن يتقلص عند التمرير لأعلى
          SliverAppBar(
            expandedHeight: 200.0, // الارتفاع الأقصى للشريط
            floating: false, // هل يظهر الشريط فوراً عند التمرير لأسفل؟
            pinned: true, // هل يبقى الشريط مثبتاً في الأعلى بعد التقلص؟
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'تجربة Slivers',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.asset(
                ImageApp.placeholder, // صورة عشوائية للخلفية
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. عنوان فرعي (تحويل أداة عادية إلى Sliver باستخدام Adapter)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'قسم الشبكة (SliverGrid):',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // 3. شبكة عناصر مرنة تعتمد على الـ Slivers
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد الأعمدة
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0, // نسبة العرض إلى الارتفاع للبطاقة
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  color: Colors.amber[100 * (index % 9)],
                  child: Center(child: Text('مربع $index')),
                );
              },
              childCount: 4, // عدد عناصر الشبكة
            ),
          ),

          // 4. عنوان فرعي آخر للقائمة
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'قسم القائمة (SliverList):',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // 5. قائمة عناصر ممتدة تعتمد على الـ Slivers
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('${index + 1}'),
                    ),
                    title: Text('العنصر رقم ${index + 1}'),
                    subtitle: const Text(
                      'هذا العنصر يتم إنشاؤه بذكاء عند التمرير',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
              childCount: 20, // عدد عناصر القائمة
            ),
          ),
          // هذا السليفر سيكون دائماً في النهاية ويظهر عند السكرول لآخر الصفحة
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child:
                  CircularProgressIndicator(), // مؤشر تحميل، أو أي ودجت تريدها
            ),
          ),
        ],
      ),
    );
  }
}
