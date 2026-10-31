import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/features/cart/view/cart_screen.dart';
import 'package:shoply_app/features/favourite/view/favourite_screen.dart';
import 'package:shoply_app/features/home/view/home_screen.dart';
import 'package:shoply_app/features/main/repo/main_repo.dart';
import 'package:shoply_app/features/main/view_model/state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState()) {
    _initMain();
  }
  final _mainRepo = MainRepo();
  int navBarIndex = 0;
  int cartCount = 0;
  int favouriteCount = 0;

  List<Widget> page = [
    HomeScreen(),
    FavouriteScreen(),
    CartScreen(),
    Center(child: Text('Profile')),
  ];

  Future<void> _initMain() async {
    await Future.wait([getCartCount(), _getFavouriteCount()]);
  }

  void changeNavBarIndex({required int index}) {
    navBarIndex = index;
    emit(MainChangeNavBarIndexState());
  }

  Future<void> getCartCount() async {
    final result = await _mainRepo.getCartCount();
    result.fold((_) {}, (cartCount) {
      this.cartCount = cartCount;
      emit(MainChangeCartCountState());
    });
  }

  Future<void> _getFavouriteCount() async {
    final result = await _mainRepo.getFavouriteCount();
    result.fold((_) {}, (favouriteCount) {
      this.favouriteCount = favouriteCount;
      emit(MainChangeFavouriteCountState());
    });
  }

  Future<void> logout() async {
    LocalStorage.instance.setIsLogin(isLogin: false);
    LocalStorageUser.instance.clearUserData();
    await _mainRepo.logout();
  }

  void decrementCartCount() {
    cartCount--;
    emit(MainChangeCartCountState());
  }

  void removeCartCount() {
    cartCount = 0;
    emit(MainChangeCartCountState());
  }

  void incrementFavouriteCount() {
    favouriteCount++;
    emit(MainChangeFavouriteCountState());
  }

  void decrementFavouriteCount() {
    favouriteCount--;
    emit(MainChangeFavouriteCountState());
  }
}
