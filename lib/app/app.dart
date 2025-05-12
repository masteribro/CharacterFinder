import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:character_finder/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:character_finder/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:character_finder/ui/views/startup/startup_view.dart';
import 'package:character_finder/ui/views/character_gallery/character_gallery_view.dart';

// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: CharacterGalleryView),

// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
