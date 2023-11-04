import 'package:appbook/shared/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Row(
            children: [
                SizedBox(
                  width: getProportionateScreenWidth(88),
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage('assets/images/image_2.png')
                        )
                      ),
                    ),
                  ),
                ),
              SizedBox(width: getProportionateScreenWidth(20),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Class", style: TextStyle(fontSize: 16, color: Colors.black, ),maxLines: 2,),
                  SizedBox(height: 10,),
                  Text.rich(TextSpan(
                    text: "\$9999",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                    children: [
                      TextSpan(
                        text: " x2",
                        style: TextStyle(
                          color: Colors.grey
                        )
                      )
                    ]
                  ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
