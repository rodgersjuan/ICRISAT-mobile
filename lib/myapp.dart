import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_uikit/ui/page/dashboard/dashboard_one.page.dart';
import 'package:flutter_uikit/ui/page/dashboard/dashboard_two_page.dart';
import 'package:flutter_uikit/ui/page/home_page.dart';
//import 'package:flutter_uikit/ui/page/login/login_page.dart';
import 'package:flutter_uikit/ui/page/login/login_two_page.dart';
import 'package:flutter_uikit/ui/page/notfound/notfound_page.dart';
import 'package:flutter_uikit/ui/page/profile/profile_one_page.dart';
import 'package:flutter_uikit/ui/page/profile/profile_two_page.dart';
import 'package:flutter_uikit/ui/page/settings/settings_one_page.dart';
import 'package:flutter_uikit/ui/page/timeline/timeline_one_page.dart';
import 'package:flutter_uikit/ui/page/timeline/timeline_two_page.dart';
import 'package:flutter_uikit/utils/translations.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_uikit/ui/page/collection/collection_state_machine.dart';
import 'package:flutter_uikit/ui/page/collection_viewer/collection_viewer.dart';
import 'package:flutter_uikit/ui/page/collection/recipe_editor.dart';
import 'package:flutter_uikit/ui/page/recipe_viewer/recipe_viewer.dart';
import 'package:flutter_uikit/model/consumption_data.dart';

//The main running of the app
//Starting by asking the interviewer info, Login

//If want a more secure mean, then can use a fingerprint on Android, or on iOS
//this is done using local_auth, and does not collect data to the userbase

class MyApp extends StatelessWidget {
  Widget materialApp(Person enumerator) => MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: UIData.quickFont,
          primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: ((enumerator?.employeeNumber ?? null) != null)
          ? HomePage()
          : LoginPage(),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "US"), //english US, deals with languages
        const Locale("hi", "IN"), //hindu India
      ],
      // initialRoute: UIData.notFoundRoute,

      //routes
      routes: <String, WidgetBuilder>{
        UIData.homeRoute: (BuildContext context) => HomePage(),
        UIData.newCollectionSessionRoute: (BuildContext context) =>
            CollectionStateMachine(),
        UIData.ViewDataRoute: (BuildContext context) => CollectionViewer(),
        UIData.NewRecipeRoute: (BuildContext context) => RecipeEditingCard(),
        UIData.ViewRecipeRoute: (BuildContext context) => RecipeViewer(),
        UIData.profileOneRoute: (BuildContext context) => ProfileOnePage(),
        UIData.profileTwoRoute: (BuildContext context) => ProfileTwoPage(),
        UIData.timelineOneRoute: (BuildContext context) => TimelineOnePage(),
        UIData.timelineTwoRoute: (BuildContext context) => TimelineTwoPage(),
        UIData.notFoundRoute: (BuildContext context) => NotFoundPage(),
        UIData.settingsOneRoute: (BuildContext context) => SettingsOnePage(),
        UIData.loginRoute: (BuildContext context) => LoginPage(),
        UIData.dashboardOneRoute: (BuildContext context) => DashboardOnePage(),
        UIData.dashboardTwoRoute: (BuildContext context) => DashboardTwoPage(),
      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
                icon: FontAwesomeIcons.solidSmile,
                title: UIData.coming_soon,
                message: "Under Development",
                iconColor: Colors.green,
              )));

  void redirectToLoginScreen(BuildContext context) async {
    Person enumerator = await Person.getEnumeratorFromSharedPrefs(); //this is to collect the enumerator information
    print(enumerator.employeeNumber);
    if (enumerator.employeeNumber == null) {
      Navigator.pushReplacementNamed(context, UIData.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
      future: Person.getEnumeratorFromSharedPrefs(),
      builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
        return materialApp(snapshot.data);
      },
    );
  }
}
