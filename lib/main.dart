import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'upload_resume_page.dart';
import 'interview_chat_page.dart';
import 'interview_result_page.dart';
import 'interview_history_page.dart';
import 'history_detail_page.dart';

void main() {
  runApp(const AIInterviewerApp());
}

/// AI 面试官助手应用
class AIInterviewerApp extends StatelessWidget {
  const AIInterviewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI 面试官助手',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2B7FFF),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'PingFang SC',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B7FFF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // 初始路由
      initialRoute: '/login',
      // 路由配置
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/upload': (context) => const UploadResumePage(),
        '/chat': (context) => const InterviewChatPage(),
        '/result': (context) => const InterviewResultPage(),
        '/history': (context) => const InterviewHistoryPage(),
        '/history-detail': (context) => const HistoryDetailPage(),
      },
      // 处理未定义的路由
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      },
    );
  }
}
