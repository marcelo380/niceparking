import 'package:flutter/material.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/utils/consts.dart';

class EmptyState extends StatelessWidget {
  final String title;

  final String? description;
  final IconData icon;

  const EmptyState(
      {required this.title, this.description, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Icon(
                  icon,
                  size: 130,
                  color: greenPrimary1,
                ),
              ),
              CustomTypography.title20(title, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              if (description != null)
                CustomTypography.body14(description!,
                    textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
