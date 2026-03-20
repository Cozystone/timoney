import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../core/design/app_colors.dart';
import '../features/home/root_tab_scaffold.dart';
import '../features/onboarding/onboarding_screen.dart';

class TimoneyApp extends StatefulWidget {
const TimoneyApp({super.key});

@override
State<TimoneyApp> createState() => _TimoneyAppState();
}

class _TimoneyAppState extends State<TimoneyApp> {
bool started = false;

@override
Widget build(BuildContext context) {
return CupertinoApp(
debugShowCheckedModeBanner: false,
title: 'Timevest',
theme: const CupertinoThemeData(
scaffoldBackgroundColor: AppColors.bg,
primaryColor: AppColors.accent,
),
builder: (context, child) {
if (!kIsWeb) return child ?? const SizedBox.shrink();

// 웹에서는 아이폰 프레임으로 감싸기
return Container(
color: const Color(0xFFEFF3FB),
alignment: Alignment.center,
child: Container(
width: 410,
height: 864,
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: const Color(0xFF111111),
borderRadius: BorderRadius.circular(44),
boxShadow: const [
BoxShadow(
color: Color(0x33000000),
blurRadius: 36,
offset: Offset(0, 18),
),
],
),
child: Stack(
children: [
ClipRRect(
borderRadius: BorderRadius.circular(34),
child: child ?? const SizedBox.shrink(),
),
Positioned(
top: 2,
left: 0,
right: 0,
child: Center(
child: Container(
width: 150,
height: 30,
decoration: BoxDecoration(
color: const Color(0xFF111111),
borderRadius: BorderRadius.circular(18),
),
),
),
),
],
),
),
);
},
home: started
? const RootTabScaffold()
: OnboardingScreen(onStart: () => setState(() => started = true)),
);
}
}