import 'package:flutter/material.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:lottie/lottie.dart';

class EmptyFailureNoInternetView extends StatelessWidget {
  const EmptyFailureNoInternetView({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  final String title, description, buttonText, image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                image,
                height: 300,
                width: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 30 * MediaQuery.of(context).textScaleFactor,
                  color: MyColors.primaryred,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15 * MediaQuery.of(context).textScaleFactor,
                  color: MyColors.primaryred,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedElevatedButton(
                width: 200,
                onPressed: onPressed,
                childText: buttonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.childText,
  });

  final double width;
  final VoidCallback onPressed;
  final String childText;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          elevation: 10,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
        ),
        child: Text(
          childText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18 * MediaQuery.of(context).textScaleFactor,
          ),
        ),
      ),
    );
  }
}
