class AppRegex {
  static final RegExp emailRegex = RegExp(
    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
  );
  static final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*]).*$');
}
