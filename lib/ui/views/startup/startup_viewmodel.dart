import 'package:stacked/stacked.dart';
import 'package:character_finder/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import '../character_list /character_list_page.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _navigationService.navigateToView(CharacterListPage());
  }
}
