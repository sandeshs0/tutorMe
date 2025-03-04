import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JitsiWebViewScreen extends StatefulWidget {
  final String roomUrl;

  const JitsiWebViewScreen({super.key, required this.roomUrl});

  @override
  State<JitsiWebViewScreen> createState() => _JitsiWebViewScreenState();
}

class _JitsiWebViewScreenState extends State<JitsiWebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.roomUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Tutoring Session'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to SessionView
          },
        ),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
