// import 'package:flutter/material.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ZoomTapAnimation(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: context.primaryColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.abc),
//                       SizedBox(width: 20.w),
//                       Text(
//                         'تيست',
//                         style: context.bodyMedium.copyWith(fontSize: 22.sp),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
