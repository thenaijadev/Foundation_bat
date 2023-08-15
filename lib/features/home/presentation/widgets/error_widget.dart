import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/error.png", height: 80, width: 80,),
          const SizedBox(height: 15,),
          Text("Network Error", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black,
              fontSize: 15, fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}
