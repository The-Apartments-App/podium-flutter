import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/building_amenities/building_amenities.dart';
import 'package:podium/src/home/home.dart';
import 'package:podium/src/service_requests/service_requests.dart';
import 'package:podium/src/splash/splash.dart';
import 'package:podium/src/user_documents/user_documents.dart';
import 'package:podium/src/user_payments/user_payments.dart';
import 'package:podium/src/user_settings/user_settings.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppPage page,
  List<Page<dynamic>> pages,
) {
  switch (page) {
    case AppPage.userLogin:
      return [SplashPage.page()];
    case AppPage.userHome:
      return [HomePage.page()];
    case AppPage.userPayments:
      return [PaymentsPage.page()];
    case AppPage.userDocuments:
      return [DocumentsPage.page()];
    case AppPage.userSettings:
      return [UserSettingsPage.page()];
    case AppPage.serviceRequest:
      return [ServiceRequestPage.page()];
    case AppPage.buildingAmenities:
      return [BuildingAmenitiesPage.page()];
  }
}
