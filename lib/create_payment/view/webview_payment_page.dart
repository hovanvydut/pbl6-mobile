import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/payment/payment.dart';
import 'package:platform_helper/platform_helper.dart';

class WebviewPaymentPage extends StatelessWidget {
  const WebviewPaymentPage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        onLoadStop: (controller, uri) async {
          if (uri!.host == 'node-2.silk-cat.software') {
            await controller
                .evaluateJavascript(
              source: 'document.documentElement.innerHTML',
            )
                .then((data) {
              (data as String).splitMapJoin(
                RegExp('{(?:[^{}]*|(R))*}'),
                onMatch: (p0) {
                  ToastHelper.showToast('Nạp tiền thành công');
                  context
                    ..pop()
                    ..pop();
                  context.read<AuthenticationBloc>().add(GetUserInformation());
                  context.read<PaymentBloc>().add(PaymentPageStarted());
                  return '';
                },
              );
            });
          }
        },
      ),
    );
  }
}
