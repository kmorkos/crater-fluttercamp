import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {

  final Function onClick;
  final Widget body;
  final Color color;
  final double size;

  const BasicButton({
    Key key,
    @required this.onClick,
    @required this.body,
    @required this.color,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: <BoxShadow>[
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(0.0, 2.0),
              blurRadius: 4.0,
            )
          ]
        ),
        child: Center(child: body,),
      ),
    );
  }

}