import 'package:get/get.dart';

class CustomTextFieldController extends GetxController {
  final isFocused = false.obs;
  final isObscure = false.obs;

  void setFocus(bool focus) => isFocused.value = focus;
  void toggleObscure() => isObscure.value = !isObscure.value;
}