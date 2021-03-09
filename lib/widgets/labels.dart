import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String title;
  final String subTitle;
  final String route;

  const Labels({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.title,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, this.route),
            child: Text(
              this.subTitle,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
