import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

class ReplaceMealRecipeItem {
  final String id;
  final String name;
  final double rating;
  final int pantryMatch;
  final int prepMinutes;
  final int calories;
  final String description;
  final String imageUrl;
  final bool isBookmarked;

  const ReplaceMealRecipeItem({
    required this.id,
    required this.name,
    required this.rating,
    required this.pantryMatch,
    required this.prepMinutes,
    required this.calories,
    required this.description,
    required this.imageUrl,
    this.isBookmarked = false,
  });
}

class ReplaceMealRecipeCard extends StatefulWidget {
  final ReplaceMealRecipeItem item;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkToggle;

  const ReplaceMealRecipeCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onBookmarkToggle,
  });

  @override
  State<ReplaceMealRecipeCard> createState() => _ReplaceMealRecipeCardState();
}

class _ReplaceMealRecipeCardState extends State<ReplaceMealRecipeCard> {
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.item.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image with Floating Bookmark Icon
            Stack(
              children: [
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Image.network(
                    widget.item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFEAEAEA),
                      child: const Center(
                        child: Icon(Icons.restaurant,
                            color: Colors.grey, size: 40,),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 14.h,
                  right: 14.w,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _bookmarked = !_bookmarked;
                      });
                      widget.onBookmarkToggle?.call();
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        _bookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_rounded,
                        color: _bookmarked
                            ? AppColors.primary
                            : const Color(0xFF374151),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Card Content Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1F2937),
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            widget.item.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // Pantry match tag
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5EE),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          color: AppColors.primary,
                          size: 13,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${widget.item.pantryMatch}% pantry match',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Metadata: Time & Calories
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 15,
                        color: Color(0xFF4B5563),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${widget.item.prepMinutes} min',
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          '•',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.local_fire_department_outlined,
                        size: 16,
                        color: Color(0xFF4B5563),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${widget.item.calories} kcal',
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Description
                  Text(
                    widget.item.description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF6B7280),
                      height: 1.35,
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
}
