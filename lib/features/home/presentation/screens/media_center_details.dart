import 'package:batnf/core/state/view_state.dart';
import 'package:batnf/features/home/data/projects/controller/news_details_controller.dart';
import 'package:batnf/features/home/presentation/widgets/error_widget.dart';
import 'package:batnf/features/home/presentation/widgets/loading_widget.dart';
import 'package:batnf/universal.dart/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaCenterDetails extends StatefulWidget {
  final String id;
  const MediaCenterDetails({super.key, required this.id});

  @override
  State<MediaCenterDetails> createState() => _MediaCenterDetailsState();
}

class _MediaCenterDetailsState extends State<MediaCenterDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0,
          title:   Image.asset(
            "assets/images/logo.png",
            width: 50,
          ),
          leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back, color: Colors.black,)),),
      body: GetBuilder<NewsDetailsController>(
          init: NewsDetailsController(),
          builder: (controller){
            return Builder(builder: (context){
              if(controller.newsDetailsDateStateView.state == ResponseState.loading){
                return const LoadingWidget();
              }else if(controller.newsDetailsDateStateView.state == ResponseState.complete){
                return Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .40, width: double.maxFinite,
                          child: controller.newsDetailsDateStateView.data!.files![0].fileExt ==
                              'image/png' && controller.newsDetailsDateStateView.data!.files![0].fileUrl!.isNotEmpty
                              ? ClipRRect(
                            borderRadius:
                            BorderRadius.circular(0),
                            child: CachedNetworkImage(
                                errorWidget: (context, url,
                                    error) =>
                                const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.black,
                                  ),
                                ),
                                placeholder:
                                    (context, url) =>
                                const Center(
                                  child:
                                  CupertinoActivityIndicator(),
                                ),
                                imageUrl: 'https://www.batnf.net/${controller.newsDetailsDateStateView.data!.files![0].fileUrl}',
                                fit: BoxFit.cover),
                          )
                              : ClipRRect(
                            borderRadius:
                            BorderRadius.circular(0),
                            child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                const Center(
                                  child: Icon(Icons.error, color: Colors.black,),),
                                placeholder: (context, url) =>
                                const Center(child: CupertinoActivityIndicator(),),
                                imageUrl: 'https://www.batnf.net/${controller.newsDetailsDateStateView.data!.files![0].thumbnail}',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .60,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              const SizedBox(height: 20,),
                              TextWidget(
                                text: controller.newsDetailsDateStateView.data?.title ?? "",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                text: controller.newsDetailsDateStateView.data?.information ?? "",
                                fontSize: 15,
                              ),
                              const SizedBox(height: 30,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }else if(controller.newsDetailsDateStateView.state == ResponseState.error){
                return const ErrorScreen();
              }
              return const SizedBox.shrink();
            });
          })
    );
  }
final _homeController = Get.put(NewsDetailsController());
  @override
  void initState() {
    _homeController.getNewsById(id: widget.id);
    super.initState();
  }
}
