class ErrorHandleHelper {
  static String getCustomErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      case 'email-already-in-use':
        return 'This email address is already registered.';
      case 'weak-password':
        return 'The password entered is too weak. Try a longer combination.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This user account has been disabled. Contact support.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}
