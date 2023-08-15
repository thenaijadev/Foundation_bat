import 'package:batnf/core/state/view_state.dart';
import 'package:batnf/features/home/data/projects/controller/controller.dart';
import 'package:batnf/features/home/presentation/widgets/news_item.dart';
import 'package:batnf/features/home/presentation/widgets/see_all_button.dart';
import 'package:batnf/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectsTabPage extends StatefulWidget {
  const ProjectsTabPage({super.key});

  @override
  State<ProjectsTabPage> createState() => _ProjectsTabPageState();
}

class _ProjectsTabPageState extends State<ProjectsTabPage> {
final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller ){
      return Builder(builder: (context){
        if(controller.projectDateStateView.state == ResponseState.loading){
          return const CupertinoActivityIndicator();
        }else if(controller.projectDateStateView.state == ResponseState.complete){
          if(controller.projectDateStateView.data!.isEmpty){
            return Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                Image.asset("assets/images/no-data.png", height: 80, width: 80,),
                const SizedBox(height: 15,),
                Text("You do not have any project", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black,
                    fontSize: 15, fontWeight: FontWeight.w500),),
              ],
            );
          }else{
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: Column(
                children: [
                  ...List.generate(controller.projectDateStateView.data!.length, (index){
                    return Flexible(
                      child: NewsItem(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.projectDetails),
                          image: const AssetImage(
                            "assets/images/events.jpg",
                          ),
                          title: "Farmers Market",
                          subTitle:
                          "Lorem ipsum dolor sit amet consectetur. Volutpat mattis habitasse nunc vulputate"),
                    );
                  }),
                  SeeAllBtn(
                    onTap: () {},
                  )
                ],
              ),
            );
          }
        } else if(controller.projectDateStateView.state == ResponseState.error){
          return Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60,),
              Image.asset("assets/images/error.png", height: 80, width: 80,),
              const SizedBox(height: 15,),
              Text("Network Error", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black,
                  fontSize: 15, fontWeight: FontWeight.w500),),
            ],
          );
        }
        return const SizedBox.shrink();
      });
    });
  }

  @override
  void initState() {
    _controller.getAllProjects();
    super.initState();
  }
}
