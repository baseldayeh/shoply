import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoply_app/core/model/login/response_login.dart';

class LocalStorageUser {
  static LocalStorageUser? _instance;
  static FlutterSecureStorage? _secureStorage;

  static String? _uid;
  static String? _email;
  static String? _fullName;
  static String? _address;
  static String? _userName;
  static String? _profileImage;

  String get email => _email ?? '';
  String get uid => _uid ?? '';
  String get fullName => _fullName ?? '';
  String get userName => _userName ?? '';
  String get address => _address ?? '';
  String get profileImage => _profileImage ?? '';

  LocalStorageUser._init() {
    _instance = this;
    _secureStorage = FlutterSecureStorage();
  }

  static LocalStorageUser get instance {
    if (_instance == null) {
      LocalStorageUser._init();
    }
    return _instance!;
  }

  Future<void> _setUid({required String uid}) async {
    _secureStorage?.write(key: 'uid', value: uid);
  }

  Future<String?> _getUid() async {
    return await _secureStorage?.read(key: 'uid');
  }

  Future<void> _setEmail({required String email}) async {
    _secureStorage?.write(key: 'email', value: email);
  }

  Future<String?> _getEmail() async {
    return await _secureStorage?.read(key: 'email');
  }

  Future<void> _setFullName({required String fullName}) async {
    _secureStorage?.write(key: 'fullName', value: fullName);
  }

  Future<String?> _getFullName() async {
    return await _secureStorage?.read(key: 'fullName');
  }

  Future<void> _setUserName({required String userName}) async {
    _secureStorage?.write(key: 'userName', value: userName);
  }

  Future<String?> _getUserName() async {
    return await _secureStorage?.read(key: 'userName');
  }

  Future<void> _setAddress({required String address}) async {
    _secureStorage?.write(key: 'address', value: address);
  }

  Future<String?> _getAddress() async {
    return await _secureStorage?.read(key: 'address');
  }

  Future<void> _setProfileImage({required String profileImage}) async {
    _secureStorage?.write(key: 'profileImage', value: profileImage);
  }

  Future<String?> _getProfileImage() async {
    return await _secureStorage?.read(key: 'profileImage');
  }

  Future<void> setUserData({required ResponseLogin responseLogin}) async {
    await _setUid(uid: responseLogin.uid ?? '');
    await _setEmail(email: responseLogin.email ?? '');
    await _setFullName(fullName: responseLogin.fullName ?? '');
    await _setUserName(userName: responseLogin.userName ?? '');
    await _setAddress(address: responseLogin.address ?? '');
    await _setProfileImage(profileImage: responseLogin.profileImage ?? '');
  }

  Future<ResponseLogin> getUserData() async {
    final uid = await _getUid();
    final email = await _getEmail();
    final fullName = await _getFullName();
    final userName = await _getUserName();
    final address = await _getAddress();
    final profileImage = await _getProfileImage();
    return ResponseLogin(
      profileImage: profileImage,
      uid: uid,
      email: email,
      address: address,
      fullName: fullName,
      userName: userName,
    );
  }

  void setUserinfo({required ResponseLogin responseLogin}) {
    _uid = responseLogin.uid;
    _email = responseLogin.email;
    _fullName = responseLogin.fullName;
    _userName = responseLogin.userName;
    _address = responseLogin.address;
    _profileImage = responseLogin.profileImage;
  }

  Future<void> clearUserData() async {
    _email = null;
    _uid = null;
    _address = null;
    _fullName == null;
    _userName = null;
    _profileImage = null;
    await _secureStorage?.deleteAll();
  }
}
