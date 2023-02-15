import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/common/utils/utils.dart';
import 'package:whatuoop_cl/common/widgets/custom_button.dart';
import 'package:whatuoop_cl/feature/auth/controller/auth_controller.dart';
import 'package:whatuoop_cl/size_config.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  final SizeConfig size = SizeConfig();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
//    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              left: size.getProportionateScreenWidth(41),
              right: size.getProportionateScreenWidth(41)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.getProportionateScreenHeight(91),
              ),
              const Text(
                'Enter your phone number',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.getProportionateScreenHeight(35),
              ),
              //    const Text('WhatsApp will need to verify your phone number.'), WhatsApp will need to verify your phone number. What’s    my number?
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'WhatsApp will need to verify your phone number.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' What ’s  \n  my number?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C42CC),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.getProportionateScreenHeight(40)),
              TextButton(
                onPressed: pickCountry,
                child: country == null
                    ? const Text(
                        'Pick County',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Text(
                        '        ${country!.name}        .',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
              ),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.getProportionateScreenWidth(290),
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 90,
                child: CustomButton(
                  onPressed: sendPhoneNumber,
                  text: 'NEXT',
                ),
              ),
              SizedBox(height: size.getProportionateScreenHeight(56)),
            ],
          ),
        ),
      ),
    );
  }
}
