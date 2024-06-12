import 'package:flutter/material.dart';
import 'package:reclaim_sdk/flutter_reclaim.dart';
import 'package:reclaim_sdk/types.dart';
import 'dart:convert'; // to use jsonEncode()

class ReclaimScreen extends StatefulWidget {
  const ReclaimScreen({super.key, required this.title});
  final String title;

  @override
  State<ReclaimScreen> createState() => _ReclaimScreenState();

}

class _ReclaimScreenState extends State<ReclaimScreen> {
  String data = "";
  ProofRequest proofRequest = ProofRequest(applicationId: 'YOUR_APPLICATION_ID_HERE');

  void startVerificationFlow() async {
    final providerId = 'YOUR_PROVIDER_ID_HERE';

    final appDeepLink = 'YOUR_APP_DEEP_LINK_HERE'; //TODO: replace with your app deep link
    proofRequest.setAppCallbackUrl(appDeepLink);


    await proofRequest.buildProofRequest(providerId);

    proofRequest.setSignature(
        proofRequest.generateSignature(
            'YOUR_APP_SECRET_HERE'
        )
    );

    final verificationRequest = await proofRequest.createVerificationRequest();

    final startSessionParam = StartSessionParams(
      onSuccessCallback: (proof) => {
      setState(() {
      //data = jsonEncode(proof.extractedParameterValues);
      final jsonContext = jsonDecode(proof.claimData.context) as Map<String, dynamic>;
      data = jsonContext["extractedParameters"];
      })
    },
      onFailureCallback: (error) => {
      setState(() {
      data = 'Error: $error';
      })
    },
    );

    await proofRequest.startSession(startSessionParam);
  }

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