import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CupertinoApp(
    theme: CupertinoThemeData(
      primaryColor: CupertinoColors.activeBlue,
      brightness: Brightness.light,
    ),
    home: InterviewApp(),
  ));
}

class InterviewApp extends StatefulWidget {
  const InterviewApp({super.key});

  @override
  State<InterviewApp> createState() => _InterviewAppState();
}

class _InterviewAppState extends State<InterviewApp> {
  int _currentIndex = 0; // 0: Login, 1: Home, 2: Upload, 3: Chat, 4: Result, 5: History, 6: Detail
  final String _currentUserName = "王小明";

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
      case 0: return _buildLoginPage();
      case 1: return _buildHomePage();
      case 2: return _buildUploadPage();
      case 3: return _buildChatPage();
      case 4: return _buildResultPage();
      case 5: return _buildHistoryPage();
      case 6: return _buildHistoryDetailPage();
      default: return _buildLoginPage();
    }
  }

  // --- 页面 1: 登录/注册 ---
  Widget _buildLoginPage() {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.person_alt_circle_fill, size: 80, color: CupertinoColors.activeBlue),
              const SizedBox(height: 16),
              const Text("AI 面试官助手", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
              const SizedBox(height: 48),
              CupertinoTextField(
                prefix: const Padding(padding: EdgeInsets.only(left: 12), child: Icon(CupertinoIcons.person, color: CupertinoColors.inactiveGray)),
                placeholder: "用户名 / 邮箱",
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                prefix: const Padding(padding: EdgeInsets.only(left: 12), child: Icon(CupertinoIcons.lock, color: CupertinoColors.inactiveGray)),
                placeholder: "密码",
                obscureText: true,
                suffix: const Padding(padding: EdgeInsets.only(right: 12), child: Icon(CupertinoIcons.eye_slash, color: CupertinoColors.inactiveGray)),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: CupertinoButton(
                  child: const Text("登录", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () => _navigateTo(1),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(padding: EdgeInsets.zero, child: const Text("注册新账号", style: TextStyle(fontSize: 14)), onPressed: () {}),
                  CupertinoButton(padding: EdgeInsets.zero, child: const Text("忘记密码?", style: TextStyle(fontSize: 14, color: CupertinoColors.secondaryLabel)), onPressed: () {}),
                ],
              ),
              const Spacer(),
              const Text("或者通过以下方式登录", style: TextStyle(color: CupertinoColors.inactiveGray, fontSize: 12)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.apple, size: 32, color: Colors.black),
                  const SizedBox(width: 40),
                  const Icon(Icons.wechat, size: 32, color: Color(0xFF07C160)),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- 页面 2: 主页 ---
  Widget _buildHomePage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: const CircleAvatar(radius: 16, backgroundColor: CupertinoColors.systemGrey5, child: Icon(CupertinoIcons.person, size: 18)),
        middle: const Text("首页"),
        trailing: const Icon(CupertinoIcons.bell, color: CupertinoColors.activeBlue),
        border: null,
        backgroundColor: const Color(0xFFF8F9FB),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text("你好，$_currentUserName", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Text("今天也是充满动力的一天，准备好面试了吗？", style: TextStyle(color: CupertinoColors.secondaryLabel)),
                  const SizedBox(height: 24),
                  // 开始新面试大卡片
                  GestureDetector(
                    onTap: () => _navigateTo(2),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("开始新面试", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Text("让 AI 为你量身定制模拟场景", style: TextStyle(color: Colors.white70, fontSize: 14)),
                              ],
                            ),
                          ),
                          const Icon(CupertinoIcons.play_circle_fill, color: Colors.white, size: 48),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text("数据概览", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatCard("总面试次数", "12", CupertinoColors.systemBlue),
                      const SizedBox(width: 12),
                      _buildStatCard("平均得分", "88", CupertinoColors.systemGreen),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("最近活动", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      CupertinoButton(padding: EdgeInsets.zero, child: const Text("全部"), onPressed: () => _navigateTo(5)),
                    ],
                  ),
                  _buildRecentActivityCard("iOS 高级开发工程师", "2023-10-24", "85分"),
                  _buildRecentActivityCard("字节跳动 - 前端开发", "2023-10-20", "92分"),
                ],
              ),
            ),
            _buildBottomTabBar(0),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String val, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 8),
            Text(val, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityCard(String title, String date, String score) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(width: 4, height: 40, decoration: BoxDecoration(color: CupertinoColors.activeBlue, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
            ]),
          ),
          Text(score, style: const TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue)),
        ],
      ),
    );
  }

  // --- 页面 3: 上传简历 ---
  Widget _buildUploadPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("上传简历"),
        leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => _navigateTo(1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4, style: BorderStyle.solid, width: 2),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFAFAFA),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.cloud_upload, size: 64, color: CupertinoColors.activeBlue.withValues(alpha: 0.5)),
                    const SizedBox(height: 16),
                    const Text("点击上传 PDF 简历", style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const Text("支持 PDF 格式，最大 10MB", style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // 模拟上传成功状态
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.checkmark_circle_fill, color: CupertinoColors.activeGreen),
                    SizedBox(width: 12),
                    Expanded(child: Text("简历_王小明_iOS.pdf", style: TextStyle(fontWeight: FontWeight.w500))),
                    Text("上传成功", style: TextStyle(color: CupertinoColors.activeGreen, fontSize: 12)),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  child: const Text("继续"),
                  onPressed: () => _navigateTo(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 页面 4: 面试对话 (核心) ---
  Widget _buildChatPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("模拟面试 - 字节跳动"),
        leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.clear), onPressed: () => _navigateTo(1)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 阶段指示器
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: const Color(0xFFF0F4F8),
              child: Row(
                children: [
                  _buildStep(true, "开场"),
                  _buildStepIndicatorLine(true),
                  _buildStep(true, "介绍"),
                  _buildStepIndicatorLine(false),
                  _buildStep(false, "项目"),
                  _buildStepIndicatorLine(false),
                  _buildStep(false, "总结"),
                ],
              ),
            ),
            // 消息列表
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildAiMessage("你好，小明。欢迎参加今天的面试。首先请做一个简单的自我介绍吧？"),
                  _buildUserMessage("你好面试官。我是王小明，拥有 5 年 iOS 开发经验，曾主导过多个百万级 DAU 产品的架构设计..."),
                  _buildAiMessage("非常棒。在你的简历中提到了对 SwiftUI 的深度使用，能聊聊它和 UIKit 的主要区别吗？"),
                  _buildTypingIndicator(),
                ],
              ),
            ),
            // 输入区域
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: CupertinoColors.systemGrey6))),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.mic_fill, color: CupertinoColors.activeBlue),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: CupertinoTextField(
                      placeholder: "输入你的回答...",
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(color: Color(0xFFF2F2F7), borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(CupertinoIcons.arrow_up_circle_fill, size: 32),
                    onPressed: () => _navigateTo(4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(bool active, String title) {
    return Column(
      children: [
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: active ? CupertinoColors.activeBlue : CupertinoColors.systemGrey4,
            shape: BoxShape.circle,
          ),
          child: active ? const Icon(CupertinoIcons.check_mark, size: 12, color: Colors.white) : null,
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 10, color: active ? CupertinoColors.activeBlue : CupertinoColors.secondaryLabel)),
      ],
    );
  }

  Widget _buildStepIndicatorLine(bool active) {
    return Expanded(child: Container(height: 2, color: active ? CupertinoColors.activeBlue : CupertinoColors.systemGrey4, margin: const EdgeInsets.only(bottom: 14)));
  }

  Widget _buildAiMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 60),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: Color(0xFFE9E9EB), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
        child: Text(text),
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 60),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF007AFF), Color(0xFF00C6FF)]),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text("面试官正在思考...", style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel, fontStyle: FontStyle.italic)),
    );
  }

  // --- 页面 6: 面试总结 ---
  Widget _buildResultPage() {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(CupertinoIcons.person_3_fill, size: 60, color: Color(0xFFFFCC00)),
              const Text("面试完成！", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(width: 120, height: 120, child: CircularProgressIndicator(value: 0.85, strokeWidth: 10, color: CupertinoColors.activeBlue, backgroundColor: Color(0xFFE5E5EA))),
                  Column(
                    children: [
                      const Text("总评分", style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                      const Text("85", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildResultRow("自我介绍", "8.5/10"),
              _buildResultRow("项目经验", "8.0/10"),
              _buildResultRow("技术问答", "9.0/10"),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              const Align(alignment: Alignment.centerLeft, child: Text("面试反馈", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    _buildFeedbackSection("优点", "技术基础扎实，对底层原理有较深理解；沟通能力强，逻辑清晰。", CupertinoColors.activeGreen),
                    _buildFeedbackSection("待改进", "在描述高并发场景下的解决方案时，细节描述略显不足，建议补充具体的压测数据。", CupertinoColors.systemOrange),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: CupertinoButton.filled(child: const Text("返回首页"), onPressed: () => _navigateTo(1))),
              CupertinoButton(child: const Text("保存结果"), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(score, style: const TextStyle(color: CupertinoColors.activeBlue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(String title, String content, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withValues(alpha: 0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 14, height: 1.4)),
        ],
      ),
    );
  }

  // --- 页面 7: 历史列表 ---
  Widget _buildHistoryPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("面试历史"),
        trailing: const Icon(CupertinoIcons.search),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: 0,
                children: const {0: Text("按时间"), 1: Text("按评分")},
                onValueChanged: (v) {},
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildHistoryItem("iOS 开发工程师", "今天 14:30", "85", CupertinoColors.activeGreen),
                  _buildHistoryItem("高级架构师", "昨天 10:20", "92", CupertinoColors.activeGreen),
                  _buildHistoryItem("产品经理模拟", "2023-10-20", "65", CupertinoColors.systemOrange),
                  _buildHistoryItem("Java 开发", "2023-10-15", "40", CupertinoColors.systemRed),
                ],
              ),
            ),
            _buildBottomTabBar(2),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String title, String date, String score, Color scoreColor) {
    return GestureDetector(
      onTap: () => _navigateTo(6),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 5)]),
        child: Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: scoreColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(score, style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold)),
            ),
            const Icon(CupertinoIcons.chevron_right, size: 16, color: CupertinoColors.systemGrey4),
          ],
        ),
      ),
    );
  }

  // --- 页面 8: 历史详情 ---
  Widget _buildHistoryDetailPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("详情 - 2023-10-24"),
        leading: CupertinoButton(padding: EdgeInsets.zero, child: const Icon(CupertinoIcons.back), onPressed: () => _navigateTo(5)),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(
              child: Column(
                children: [
                  Text("85", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue)),
                  Text("最终评分", style: TextStyle(color: CupertinoColors.secondaryLabel)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text("完整对话回顾", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildAiMessage("首先请做一个简单的自我介绍吧？"),
            _buildUserMessage("我是王小明，拥有 5 年 iOS 开发经验..."),
            _buildAiMessage("能聊聊 SwiftUI 和 UIKit 的区别吗？"),
            _buildUserMessage("SwiftUI 是声明式的，而 UIKit 是命令式的。SwiftUI 大大减少了代码量并提供了实时预览..."),
            const SizedBox(height: 20),
            CupertinoButton.filled(child: const Text("再次练习此岗位"), onPressed: () => _navigateTo(3)),
          ],
        ),
      ),
    );
  }

  // 通用底部 TabBar
  Widget _buildBottomTabBar(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: CupertinoColors.systemGrey6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(CupertinoIcons.house_fill, "首页", index == 0, 1),
          _buildTabItem(CupertinoIcons.mic_fill, "面试", index == 1, 2),
          _buildTabItem(CupertinoIcons.clock_fill, "历史", index == 2, 5),
          _buildTabItem(CupertinoIcons.settings, "设置", index == 3, 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String label, bool active, int target) {
    return GestureDetector(
      onTap: () => _navigateTo(target),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 10, color: active ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray)),
        ],
      ),
    );
  }
}