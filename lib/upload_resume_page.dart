import 'package:flutter/material.dart';

/// AI 面试官助手 - 简历上传页面
/// 基于 Figma 设计实现
class UploadResumePage extends StatefulWidget {
  const UploadResumePage({super.key});

  @override
  State<UploadResumePage> createState() => _UploadResumePageState();
}

class _UploadResumePageState extends State<UploadResumePage> {
  bool _hasUploadedFile = false;
  String? _uploadedFileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            _buildTopBar(context),

            // 主体内容
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 说明文字
                    _buildDescription(),
                    const SizedBox(height: 24),

                    // 上传区域
                    _buildUploadArea(),
                    const SizedBox(height: 16),

                    // 格式提示
                    _buildFormatHint(),
                    const SizedBox(height: 32),

                    // 上传提示列表
                    _buildUploadTips(),
                  ],
                ),
              ),
            ),

            // 底部按钮
            _buildBottomButtons(context),
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
            onTap: () => Navigator.pop(context),
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

          // 标题
          const Text(
            '上传简历',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E2939),
            ),
          ),
        ],
      ),
    );
  }

  /// 说明文字
  Widget _buildDescription() {
    return const Text(
      '上传您的简历，AI 面试官将根据您的背景进行针对性面试',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF6A7282),
        height: 1.5,
      ),
    );
  }

  /// 上传区域
  Widget _buildUploadArea() {
    return GestureDetector(
      onTap: _handleUpload,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hasUploadedFile
                ? const Color(0xFF2B7FFF)
                : const Color(0xFFE5E7EB),
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 上传图标
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _hasUploadedFile
                    ? const Color(0xFF2B7FFF).withValues(alpha: 0.1)
                    : const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _hasUploadedFile ? Icons.description : Icons.cloud_upload_outlined,
                size: 32,
                color: const Color(0xFF2B7FFF),
              ),
            ),
            const SizedBox(height: 16),

            // 文字提示
            Text(
              _hasUploadedFile ? _uploadedFileName ?? '已上传文件' : '点击上传 PDF 简历',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _hasUploadedFile
                    ? const Color(0xFF2B7FFF)
                    : const Color(0xFF1E2939),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _hasUploadedFile ? '点击重新上传' : '或拖拽文件到此处',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF99A1AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 格式提示
  Widget _buildFormatHint() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline,
          size: 16,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 6),
        Text(
          '支持 PDF 格式，最大 10MB',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  /// 上传提示列表
  Widget _buildUploadTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '上传提示',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E2939),
            ),
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            '请确保简历内容清晰完整，包含教育背景和工作经验',
            const Color(0xFF2B7FFF),
          ),
          const SizedBox(height: 12),
          _buildTipItem(
            'AI 将分析您的简历并生成针对性的面试问题',
            const Color(0xFF00C950),
          ),
          const SizedBox(height: 12),
          _buildTipItem(
            '您的简历信息仅用于面试练习，我们会严格保护隐私',
            const Color(0xFFF0B100),
          ),
        ],
      ),
    );
  }

  /// 提示项
  Widget _buildTipItem(String text, Color dotColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A5565),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// 底部按钮
  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 继续按钮
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _hasUploadedFile ? () => _navigateToChat(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B7FFF),
                disabledBackgroundColor: const Color(0xFFE5E7EB),
                foregroundColor: Colors.white,
                disabledForegroundColor: const Color(0xFF99A1AF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                _hasUploadedFile ? '继续' : '请先上传简历',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 跳过按钮
          TextButton(
            onPressed: () => _navigateToChat(context),
            child: const Text(
              '跳过此步骤',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6A7282),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 处理上传
  void _handleUpload() {
    // TODO: 实现文件选择功能
    setState(() {
      _hasUploadedFile = true;
      _uploadedFileName = '我的简历.pdf';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('文件上传功能待实现'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// 导航到面试对话页
  void _navigateToChat(BuildContext context) {
    Navigator.pushNamed(context, '/chat');
  }
}
