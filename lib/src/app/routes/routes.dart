import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/community_manager_tool/dashboard/views/community_manager_dashboard.dart';
import 'package:podium/src/general_pages/error_page/error_page.dart';
import 'package:podium/src/general_pages/stripe_web_redirect_pages/stripe_web_widgets.dart';
import 'package:podium/src/maintenance_tech_tool/dashboard/dashboard.dart';
import 'package:podium/src/owner_portal/dashboard/building_owner_dashboard.dart';
import 'package:podium/src/resident_portal/building_amenities/building_amenities.dart';
import 'package:podium/src/resident_portal/profile_page/profile_page_index.dart';
import 'package:podium/src/resident_portal/service_requests/service_requests.dart';
import 'package:podium/src/resident_portal/user_documents/user_documents.dart';
import 'package:podium/src/resident_portal/user_payments/user_payments.dart';
import 'package:podium/src/resident_portal/user_settings/user_settings.dart';
import 'package:podium/src/website/blog_story_page/blog_story_page.dart';
import 'package:podium/src/website/website_pages_index.dart';

class RouterClass {
  RouterClass()
      : goRouter = GoRouter(
          routes: getRoutes(),
          errorPageBuilder: (context, state) {
            // This will be invoked when no other route matches
            return MaterialPage(
              child: ErrorPage('Invalid route: ${state.location}'),
            );
          },
        );

  static List<GoRoute> getRoutes() {
    return [
      // ** ~~~~ Website Routes ~~~~
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SplashPage()),
      ),
      GoRoute(
        path: '/blogs/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return MaterialPage(child: BlogStoryPage(blogId: id));
        },
      ),

      // ** ~~~~ Resident Portal Routes ~~~~
      GoRoute(
        path: '/residentProfile',
        pageBuilder: (context, state) => const MaterialPage(
          child: ProfilePage(),
        ),
      ),
      GoRoute(
        path: '/userPayments',
        pageBuilder: (context, state) =>
            const MaterialPage(child: PaymentsPage()),
      ),
      GoRoute(
        path: '/userDocuments',
        pageBuilder: (context, state) =>
            const MaterialPage(child: DocumentsPage()),
      ),
      GoRoute(
        path: '/userSettings',
        pageBuilder: (context, state) =>
            const MaterialPage(child: UserSettingsPage()),
      ),
      GoRoute(
        path: '/serviceRequest',
        pageBuilder: (context, state) =>
            const MaterialPage(child: ServiceRequestPage()),
      ),
      GoRoute(
        path: '/buildingAmenities',
        pageBuilder: (context, state) =>
            const MaterialPage(child: BuildingAmenitiesPage()),
      ),

      // ** ~~~~ Building Owner Routes ~~~~
      GoRoute(
        path: '/ownerHome',
        pageBuilder: (context, state) => const MaterialPage(
          child: BuildingOwnerDashboard(),
        ),
      ),
      GoRoute(
        path: '/ownerLedgers',
        pageBuilder: (context, state) => const MaterialPage(
          child: Text('OWNER LEDGERS PAGE'),
        ),
      ),
      GoRoute(
        path: '/ownerBuildingInfo',
        pageBuilder: (context, state) => const MaterialPage(
          child: Text('OWNER BUILDING INFO PAGE'),
        ),
      ),
      GoRoute(
        path: '/ownerBuildingInspections',
        pageBuilder: (context, state) => const MaterialPage(
          child: Text('OWNER BUILDING INSPECTIONS PAGE'),
        ),
      ),

      // ** ~~~~ Community Manager Routes ~~~~
      GoRoute(
        path: '/communityManager',
        pageBuilder: (context, state) => const MaterialPage(
          child: CommunityManagerDashboard(),
        ),
      ),

      // ** ~~~~  Maintenance Tech Routes ~~~~
      GoRoute(
        path: '/maintenanceTech',
        pageBuilder: (context, state) => const MaterialPage(
          child: MaintenanceTechDashboard(),
        ),
      ),

      // ** ~~~~ Payment Confirmation Routes ~~~~
      GoRoute(
        path: '/success',
        pageBuilder: (context, state) => const MaterialPage(
          child: SuccessPage(),
        ),
      ),
      GoRoute(
        path: '/failure',
        pageBuilder: (context, state) => const MaterialPage(
          child: FailurePage(),
        ),
      ),
    ];
  }

  final GoRouter goRouter;
}
