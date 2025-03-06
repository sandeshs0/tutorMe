import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

class KhaltiWebView extends StatefulWidget {
  final String paymentUrl;
  final String pidx;
  final String transactionId;
  
  const KhaltiWebView({
    super.key,
    required this.paymentUrl,
    required this.pidx,
    required this.transactionId,
  });

  @override
  State<KhaltiWebView> createState() => _KhaltiWebViewState();
}

class _KhaltiWebViewState extends State<KhaltiWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (url.contains("payment-callback")) {
              debugPrint("Payment Completed! Verifying transaction...");
              _verifyTransaction();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _verifyTransaction() {
    context.read<WalletBloc>().add(
          VerifyTransaction(
            pidx: widget.pidx,
            transactionId: widget.transactionId,
          ),
        );

    Navigator.pop(context); 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
