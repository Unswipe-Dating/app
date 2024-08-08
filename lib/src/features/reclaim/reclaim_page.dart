import 'package:flutter/material.dart';
import 'package:reclaim_sdk/flutter_reclaim.dart';
import 'package:reclaim_sdk/types.dart';
import 'dart:convert';

import '../../core/router/app_router.dart';
class ReclaimPage extends StatefulWidget {

  const ReclaimPage({super.key, required this.title});
  final String title;
  @override
  State<ReclaimPage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<ReclaimPage> {
  String data = "";
  ProofRequest proofRequest = ProofRequest(applicationId: '0x1DD4a325bD51B09C7f840D54de854266ECB4697A');
  void startVerificationFlow() async {
    final providerIds = [
      '85de83e5-5635-4768-9f76-f9f04f7661a1', // Aadhar General Info
    ];
    proofRequest.setAppCallbackUrl(CustomNavigationHelper.settingsPathBasic);
    await proofRequest
        .buildProofRequest(providerIds[0]);
    proofRequest.setSignature(proofRequest.generateSignature(
        '0xf232d1bac6350a49fd5d86015c8a1191b2e724729560fb4a18638fa9f88436d2'));
    final verificationRequest = await proofRequest.createVerificationRequest();
    final startSessionParam = StartSessionParams(
      onSuccessCallback: (proof) => setState(() {
        data = jsonEncode(proof);
      }),
      onFailureCallback: (error) => {
        setState(() {
          data = 'Error: $error';
        })
      },
    );
    await proofRequest.startSession(startSessionParam);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Prove that you have Steam ID By clicking on Verify button:',
            ),
            Text(
              data,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startVerificationFlow,
        tooltip: 'Verify ',
        child: const Text('Verify'),
      ),
    );
  }
}
