import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildOfferCard(String img, String rating, String title, String subtitle, String price, String commition) {

  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16.0.h),
    child: Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.r)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          SizedBox(
            height: 150.h,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey,
                      child: Icon(Icons.broken_image, size: 50, color: Colors.white),
                    ),
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 8.r,
                  left: 8.r,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.r),
                        SizedBox(width: 4.w),
                        Text(
                          rating,
                          style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text and button section
          Padding(
            padding: EdgeInsets.all(12.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title and subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0.h),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                // Arrow button
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 16.r),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Button action here
                    },
                  ),
                ),
              ],
            ),
          ),

          // Price and off section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.r, vertical: 8.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${price}',
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
                Text(
                  'Off: \$${commition}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
