import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/colors/colors.dart';
import '../../../app/styles/text_styles.dart';
import 'otp_verify_viewmodel.dart';

class OtpVerifyView extends StatelessWidget {
  const OtpVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerifyViewModel>.nonReactive(
      viewModelBuilder: () => OtpVerifyViewModel(),
      builder: (
        BuildContext context,
        OtpVerifyViewModel model,
        Widget? child,
      ) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 28.0),
                  SizedBox(
                    width: 295.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('One Time Password', style: heading1),
                        const SizedBox(height: 12.0),
                        RichText(
                          text: TextSpan(
                            text: 'Enter the One Time Password we sent to ',
                            style: heading1,
                            children: <TextSpan>[
                              TextSpan(
                                  text: (ModalRoute.of(context)!
                                          .settings
                                          .arguments! as Map)['country_code'] +
                                      (ModalRoute.of(context)!
                                          .settings
                                          .arguments! as Map)['phone_number'],
                                  style: heading1),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: 295,
                          color: AppColors.loginFieldColor,
                          child: TextField(
                            cursorColor: AppColors.black87,
                            controller: model.otpController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'OTP',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const SizedBox(height: 16.0),
                        model.isBusy
                            ? Center(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 36.0,
                                  width: 36.0,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.darkBlue_2,
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: model.matchOtpSignIn,
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.darkBlue_2,
                                  onPrimary: Colors.white,
                                  shadowColor: AppColors.darkBlue_2,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  minimumSize: const Size(100, 40),
                                ),
                                child: const Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: buttonText,
                                ),
                              ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
