import 'package:flutter/material.dart';

/// AI 面试官助手 - 面试对话页面
/// 基于 Figma 设计实现
class InterviewChatPage extends StatefulWidget {
  const InterviewChatPage({super.key});

  @override
  State<InterviewChatPage> createState() => _InterviewChatPageState();
}

class _InterviewChatPageState extends State<InterviewChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 面试阶段
  int _currentStage = 2; // 1-开场, 2-自我介绍, 3-项目经验, 4-技术问答, 5-总结
  final List<String> _stages = ['开场', '自我介绍', '项目经验', '技术问答', '总结'];

  // 模拟对话消息
  final List<ChatMessage> _messages = [
    ChatMessage(
      isAI: true,
      content: '你好！欢迎参加今天的模拟面试。我是你的AI面试官。首先，请做一个简单的自我介绍吧。',
      time: '14:30',
    ),
  ];

  // 计时器
  int _elapsedSeconds = 2; // 已进行的秒数

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            _buildTopBar(context),

            // 进度指示器
            _buildProgressIndicator(),

            // 对话区域
            Expanded(
              child: _buildChatArea(),
            ),

            // 输入区域
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  /// 顶部导航栏
  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: () => _showExitDialog(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Color(0xFF1E2939),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 标题和当前阶段
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '模拟面试',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E2939),
                  ),
                ),
                Text(
                  _stages[_currentStage - 1],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6A7282),
                  ),
                ),
              ],
            ),
          ),

          // 计时和问题数
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '已进行 ${_formatTime(_elapsedSeconds)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6A7282),
                ),
              ),
              const Text(
                '问题',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6A7282),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // 结束面试按钮
          TextButton(
            onPressed: () => _endInterview(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              backgroundColor: const Color(0xFFFFE8E8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '结束面试',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 进度指示器
  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        children: List.generate(5, (index) {
          final stageNumber = index + 1;
          final isCompleted = stageNumber < _currentStage;
          final isCurrent = stageNumber == _currentStage;
          // 是否是后续阶段（目前未使用但保留以便后续扩展）
          final _ = stageNumber > _currentStage;

          return Expanded(
            child: Row(
              children: [
                // 阶段圆点和标签
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? const Color(0xFF00C950)
                              : isCurrent
                                  ? const Color(0xFF2B7FFF)
                                  : const Color(0xFFE5E7EB),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : Text(
                                  '$stageNumber',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isCurrent
                                        ? Colors.white
                                        : const Color(0xFF99A1AF),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _stages[index],
                        style: TextStyle(
                          fontSize: 10,
                          color: isCurrent
                              ? const Color(0xFF2B7FFF)
                              : const Color(0xFF6A7282),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // 连接线
                if (index < 4)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: isCompleted
                          ? const Color(0xFF00C950)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// 对话区域
  Widget _buildChatArea() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  /// 消息气泡
  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isAI ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isAI) ...[
            // AI 头像
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF2B7FFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.smart_toy,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
          ],

          // 消息内容
          Flexible(
            child: Column(
              crossAxisAlignment:
                  message.isAI ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: message.isAI ? Colors.white : const Color(0xFF2B7FFF),
                    borderRadius: BorderRadius.circular(16).copyWith(
                      topLeft: message.isAI ? const Radius.circular(4) : null,
                      topRight: !message.isAI ? const Radius.circular(4) : null,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      fontSize: 15,
                      color: message.isAI ? const Color(0xFF1E2939) : Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF99A1AF),
                  ),
                ),
              ],
            ),
          ),

          if (!message.isAI) ...[
            const SizedBox(width: 12),
            // 用户头像
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.person,
                size: 20,
                color: Color(0xFF6A7282),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 输入区域
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 语音按钮
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.mic,
              size: 22,
              color: Color(0xFF6A7282),
            ),
          ),
          const SizedBox(width: 12),

          // 输入框
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: '输入你的回答...',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF99A1AF),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 发送按钮
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2B7FFF), Color(0xFF4F39F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2B7FFF).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.send,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 发送消息
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        isAI: false,
        content: text,
        time: _getCurrentTime(),
      ));
      _messageController.clear();
    });

    // 滚动到底部
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // 模拟 AI 回复
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            isAI: true,
            content: '谢谢你的回答！让我们继续下一个问题。能否介绍一下你最近参与的一个项目？',
            time: _getCurrentTime(),
          ));
        });

        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  /// 格式化时间
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  /// 获取当前时间
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  /// 显示退出对话框
  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认退出'),
        content: const Text('退出后本次面试进度将丢失，确定要退出吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              '确定退出',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// 结束面试
  void _endInterview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('结束面试'),
        content: const Text('确定要结束本次面试吗？结束后将生成面试报告。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('继续面试'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/result');
            },
            child: const Text('结束面试'),
          ),
        ],
      ),
    );
  }
}

/// 聊天消息模型
class ChatMessage {
  final bool isAI;
  final String content;
  final String time;

  ChatMessage({
    required this.isAI,
    required this.content,
    required this.time,
  });
}
