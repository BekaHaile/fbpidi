import 'package:flutter/material.dart';

class IconBtnWithCounter extends StatelessWidget {
  final int numOfItems;
  final Icon buttonicon;
  final GestureTapCallback press;
  const IconBtnWithCounter(
      {Key key, this.numOfItems, this.buttonicon, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        children: [
          Container(
              width: size.width * 0.12,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: CSecondaryColor.withOpacity(0.1)
              ),
              child: buttonicon),
          Positioned(
            right: 0,
            top: 2,
            child: numOfItems >= 1
                ? Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFA53E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5)),
                    child: Center(
                      child: Text(
                        numOfItems.toString(),
                        style: TextStyle(
                          height: 1,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Center(),
          )
        ],
      ),
    );
  }
}
