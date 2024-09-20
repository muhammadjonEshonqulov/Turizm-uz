// import 'package:ecomly/core/common/app/cache_helper.dart';
// import 'package:ecomly/core/common/singletons/cache.dart';
// import 'package:ecomly/core/services/injection_container.dart';
// import 'package:ecomly/src/auth/presentation/views/forgot_password_screen.dart';
// import 'package:ecomly/src/auth/presentation/views/login_screen.dart';
// import 'package:ecomly/src/auth/presentation/views/register_screen.dart';
// import 'package:ecomly/src/auth/presentation/views/reset_password_screen.dart';
// import 'package:ecomly/src/auth/presentation/views/home_screen.dart';
// import 'package:ecomly/src/auth/presentation/views/verify_otp_screen.dart';
// import 'package:ecomly/src/cart/presentation/app/cart_cubit_adapter/cart_provider.dart';
// import 'package:ecomly/src/cart/presentation/views/cart_view.dart';
// import 'package:ecomly/src/dashboard/presentation/views/dashboard_screen.dart';
// import 'package:ecomly/src/explore/presentation/views/explore_view.dart';
// import 'package:ecomly/src/home/presentation/views/home_view.dart';
// import 'package:ecomly/src/on_boarding/views/on_boarding_screen.dart';
// import 'package:ecomly/src/product/domain/entities/category.dart';
// import 'package:ecomly/src/product/domain/entities/product.dart';
// import 'package:ecomly/src/product/features/reviews/presentation/views/product_reviews.dart';
// import 'package:ecomly/src/product/presentation/app/category_cubit_notifier/category_cubit.dart';
// import 'package:ecomly/src/product/presentation/app/product_cubit_provider/product_cubit.dart';
// import 'package:ecomly/src/product/presentation/views/all_new_arrivals_view.dart';
// import 'package:ecomly/src/product/presentation/views/all_popular_products_view.dart';
// import 'package:ecomly/src/product/presentation/views/categorized_products_view.dart';
// import 'package:ecomly/src/product/presentation/views/product_details_view.dart';
// import 'package:ecomly/src/product/presentation/views/search_view.dart';
// import 'package:ecomly/src/user/features/profile/presentation/views/profile_view.dart';
// import 'package:ecomly/src/wishlist/presentation/views/wishlist_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../src/auth/presentation/app/bloc/profile_bloc.dart';
// import '../../src/product/presentation/app/gender_age_category_cubit_notifier/gender_age_category_notifier.dart';
//
// /// For routes that should NOT have the bottom nav bar
// final _rootNavigatorKey = GlobalKey<NavigatorState>();
//
// /// For routes that SHOULD have the bottom nav bar
// final _shellNavigatorKey = GlobalKey<NavigatorState>();
//
// final router = GoRouter(
//   debugLogDiagnostics: true,
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: '/',
//   routes: [
//     GoRoute(
//         path: '/',
//         redirect: (context, state) {
//           /// First we check if session exists and user exists, if either is
//           /// missing, we check if they're first timers, because their session
//           /// could be gone but they aren't first timers, so, we take them to
//           /// login, but if they are first timers, we return null which pushes us
//           /// to the builder
//           final cacheHelper = sl<CacheHelper>()
//             ..getSessionToken()
//             ..getUserId();
//           if ((Cache.instance.sessionToken == null ||
//                   Cache.instance.userId == null) &&
//               !cacheHelper.isFirstTime()) {
//             return LoginScreen.path;
//           }
//           if (state.extra == 'home'){
//             return   HomeView.path;
//           }
//           return null;
//         },
//         builder: (context, state) {
//           /// Now that we're here, we check again if the user is first timer,
//           /// so, if they were first timer from that push in the redirect,
//           /// then we catch it here and take em to onboarding, else, we go
//           /// ahead and check if when we pushed to '/', we added the <home>
//           /// extra, if we did, then we were trying to go home, else, we just
//           /// go to the splashscreen, where the OTP gets verified, if it's
//           /// still valid, we go home, else, we go back to login.
//           final cacheHelper = sl<CacheHelper>()
//             ..getSessionToken()
//             ..getUserId();
//           if (cacheHelper.isFirstTime()) {
//             return const OnBoardingScreen();
//           }
//
//           return const SplashScreen();
//         }),
//     GoRoute(
//       path: LoginScreen.path,
//       builder: (context, state) => BlocProvider(
//         create: (_) => sl<AuthBloc>(),
//         child: const
//         LoginScreen(),
//       ),
//     ),
//     GoRoute(
//       path: RegisterScreen.path,
//       builder: (context, state) => BlocProvider(
//         create: (_) => sl<AuthBloc>(),
//         child: const
//         RegisterScreen(),
//       ),
//     ),
//     GoRoute(
//       path: ForgotPasswordScreen.path,
//       builder: (context, state) =>  BlocProvider(
//         create: (_) => sl<AuthBloc>(),
//         child: const
//         ForgotPasswordScreen(),
//       ),
//     ),
//     GoRoute(
//       path: VerifyOTPScreen.path,
//       builder: (context, state) =>  BlocProvider(
//         create: (_) => sl<AuthBloc>(),
//         child:
//         VerifyOTPScreen(email: state.extra as String),
//       ),
//     ),
//     GoRoute(
//       path: ResetPasswordScreen.path,
//       builder: (context, state) => BlocProvider(
//         create: (_) => sl<AuthBloc>(),
//         child:
//         ResetPasswordScreen(email: state.extra as String),
//       ),
//     ),
//     GoRoute(
//       path: SearchView.path,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (_, __) => BlocProvider(create:(_)=>sl<GenderAgeCategoryNotifier>(), child: const SearchView(),),
//     ),
//     GoRoute(
//       path: '/products/:productId',
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (_, state) => BlocProvider(create: (_)=>sl<ProductPopularCubit>(),child: ProductDetailsView(
//         state.pathParameters['productId'] as String,
//       ),),
//     ),
//     GoRoute(
//       path: '/products/:productId/reviews',
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (_, state) {
//         return ProductReviews(state.extra as Product);
//       },
//     ),
//     ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       builder: (context, state, child) {
//         return DashboardScreen(state: state, child: child);
//       },
//       routes: [
//         GoRoute(
//           path: HomeView.path,
//           // OBVIOUSLY, but making a point
//           parentNavigatorKey: _shellNavigatorKey,
//           builder: (context, state) {
//             return const HomeView();
//           },
//           routes: [
//             GoRoute(
//               path: AllNewArrivalsView.path,
//               builder: (context, state) => BlocProvider(
//                 create: (_)=>sl<ProductPopularCubit>(),
//                 child: const AllNewArrivalsView(),
//               ),
//             ),
//             GoRoute(
//               path: AllPopularProductsView.path,
//               builder: (context, state) =>  BlocProvider(
//                   create: (_)=>sl<CategoryNotifier>(),
//                 child: const AllPopularProductsView(),
//
//               ),
//             ),
//           ],
//         ),
//         GoRoute(
//           path: ExploreView.path,
//           builder: (context, state) => BlocProvider(create: (_)=>sl<ProductPopularCubit>(),
//           child: const ExploreView(),),
//         ),
//         GoRoute(
//           path: WishlistView.path,
//           builder: (context, state) => const WishlistView(),
//         ),
//       ],
//     ),
//     GoRoute(
//       path: ProfileView.path,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) => const ProfileView(),
//     ),
//     GoRoute(
//       path: CartView.path,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (_, __) => BlocProvider(create: (_)=>sl<CartAdapter>(), child: const CartView(),),
//     ),
//     GoRoute(
//       path: '/:category_name',
//       redirect: (_, state) {
//         if (state.extra is! ProductCategory) return '/home';
//         return null;
//       },
//       builder: (_, state) {
//         return CategorizedProductsView(state.extra as ProductCategory);
//       },
//     ),
//   ],
// );
