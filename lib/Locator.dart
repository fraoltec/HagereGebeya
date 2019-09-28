import 'package:HagereGebeya/provider/CRUDModel.dart';
import 'package:HagereGebeya/provider/user_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:HagereGebeya/service/Api.dart';



GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton (() => Api('products'));
  locator.registerLazySingleton(() => CRUDModel()) ;
  locator.registerLazySingleton(() => UserProvider.initialize());
}