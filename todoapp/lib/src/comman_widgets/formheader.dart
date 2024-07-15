import 'package:flutter/material.dart';
import 'package:todoapp/src/constants/size.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key? key,
    required this.size,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Size size;
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.22,
        ),
        const SizedBox(height: dFormHeight),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
