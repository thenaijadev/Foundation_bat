import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerLoader extends StatelessWidget {
  const HomeShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          const SizedBox(height: 15,),
          Shimmer.fromColors(
            period: const Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: const Color(0xff6F6F6F).withOpacity(0.5),
            child: Container(
              padding: const EdgeInsets.all(8), height: 170, width: double.maxFinite,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10,),
          Shimmer.fromColors(
            period: const Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: const Color(0xff6F6F6F).withOpacity(0.5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8), height: 15, width: 150,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2)),
                ),
                Container(
                  padding: const EdgeInsets.all(8), height: 15, width: 100,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Shimmer.fromColors(
            period: const Duration(seconds: 1),
            baseColor: Colors.grey.shade400,
            highlightColor: const Color(0xff6F6F6F).withOpacity(0.5),
            child: Column(
              children: [
                ...List.generate(5, (index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8), height: 100, width: 160,
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                        ),
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8), height: 15, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(height: 5,),
                            Container(
                              padding: const EdgeInsets.all(8), height: 5, width: 120,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
