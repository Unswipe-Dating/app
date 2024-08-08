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
  ProofRequest proofRequest = ProofRequest(applicationId: '');
  void startVerificationFlow() async {
    final providerIds = [
      '', // Aadhar General Info
    ];
    proofRequest.setAppCallbackUrl(CustomNavigationHelper.settingsPathBasic);
    await proofRequest
        .buildProofRequest(providerIds[0]);
    proofRequest.setSignature(proofRequest.generateSignature(
        ''));
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
