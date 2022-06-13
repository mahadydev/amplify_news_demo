import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';

import '../../../app/colors/colors.dart';
import '../../../app/styles/text_styles.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onDispose: (model) => model.onClose(),
      builder: (
        BuildContext context,
        LoginViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login To Your Account', style: heading1),
                const SizedBox(height: 16.0),
                Form(
                  key: model.formKey,
                  child: Container(
                    color: AppColors.loginFieldColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: IntlPhoneField(
                            showCountryFlag: false,
                            focusNode: model.loginFocus,
                            controller: model.phoneController,
                            validator: model.phoneValidator,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            onCountryChanged: model.countryCodeChange,
                            initialCountryCode: 'IN',
                            decoration: const InputDecoration(
                              hintText: 'Mobile number',
                            ),
                            cursorColor: AppColors.black,
                            disableLengthCheck: true,
                            autovalidateMode: AutovalidateMode.always,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(
                                  model.maxNumberLength),
                            ],
                            dropdownTextStyle: const TextStyle(fontSize: 16),
                            pickerDialogStyle: PickerDialogStyle(
                              countryCodeStyle: const TextStyle(fontSize: 14),
                              countryNameStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        onPressed: model.signin,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
