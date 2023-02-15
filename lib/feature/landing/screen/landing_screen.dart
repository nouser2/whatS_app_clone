import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatuoop_cl/common/widgets/custom_button.dart';
import 'package:whatuoop_cl/feature/auth/screen/login_screen.dart';
import 'package:whatuoop_cl/size_config.dart';

class LandingPage extends StatelessWidget {
  SizeConfig size = SizeConfig();
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.getProportionateScreenHeight(84),
            ),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.getProportionateScreenHeight(99.5)),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF00A884),
                borderRadius: BorderRadius.circular(
                    size.getProportionateScreenWidth(260)),
              ),
              child: Image.asset(
                'lib/assets/images/first_page_background1.png',
                height: size.getProportionateScreenWidth(260),
                width: size.getProportionateScreenWidth(260),
                fit: BoxFit.fitWidth,
              ),
            ),
            // Center(
            //   child: SvgPicture.asset(
            //     'lib/assets/images/first_page_background.svg',
            //     fit: BoxFit.fill,
            //     height: size.getProportionateScreenHeight(340),
            //     width: size.getProportionateScreenWidth(340),
            //   ),
            // ),
            SizedBox(height: size.getProportionateScreenHeight(55.5)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Read our ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C42CC),
                      ),
                    ),
                    TextSpan(text: ' Tap "Agree and continue" to accept the '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C42CC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.getProportionateScreenHeight(24)),
            SizedBox(
              width: size.getProportionateScreenWidth(300),
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                height: size.getProportionateScreenHeight(39),
                width: size.getProportionateScreenWidth(300),
              ),
            ),
            SizedBox(height: size.getProportionateScreenHeight(70)),
            const Text(
              'from',
              style: TextStyle(
                  color: Color(0xFF867373),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            const Text(
              'FACEBOOK',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
