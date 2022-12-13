// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, non_constant_identifier_names

import 'package:batnf/Screens/reset_password_page.dart';
import 'package:batnf/Screens/signin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:batnf/Screens/single_completed_project_page.dart';
import 'package:batnf/Screens/single_pending_project_page.dart';
import 'package:batnf/Screens/single_project_inprogress_page.dart';
import 'package:batnf/constants/text_style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../Models/completed_model.dart';
import '../Models/inprogress_model.dart';
// import '../Models/pending_model.dart';
import '../constants/color_constant.dart';
import '../providers/completed_provider.dart';
import '../providers/inprogress_provider.dart';
import '../providers/pending_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/change_theme_button.dart';

class ProjectPage extends StatefulWidget {
  static String id = 'projects';
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  late InprogressProvider _inprojectprovider;
  @override
  void initState() {
    // Provider.of<PendingProvider>(context, listen: false).getPendingProjects();
    _inprojectprovider =
        Provider.of<InprogressProvider>(context, listen: false);
    // Provider.of<CompletedProvider>(context, listen: false)
    //     .getCompletedProjects();
    if (_inprojectprovider.allInprogressProjects == null ||
        _inprojectprovider.allInprogressProjects!.isEmpty) {
      _inprojectprovider.allInprogressProjects;
    }
    super.initState();
  }
  Future<bool> onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          title: Text('Exist App'),
          content: Text('Do you want to Exit app ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes')),
          ],
        );
      }),
    );
    return exitApp ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'Light Theme';
    
    // CompletedProvider completedProvider =
    //     Provider.of<CompletedProvider>(context);
    // PendingProvider pendingProvider = Provider.of<PendingProvider>(context);
    InprogressProvider inprogressProvider =
        Provider.of<InprogressProvider>(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => onBackButtonPressed(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 60,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    
              // App Logo
              actions: [
                Container(
                  margin: EdgeInsets.only(left: 24.0, top: 10, bottom: 10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 40.0,
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, left: 10, bottom: 6, right: 130),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 29,
                  child: Text(
                    'Projects',
                    style: kPageHeader,
                  ),
                ),
              ],
              // Drawer Builder
              leading: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      size: 20,
                      FontAwesomeIcons.bars,
                      color: Theme.of(context).primaryColor,
                    ));
              })),
          // Drawer
          drawer: Drawer(
            width: 250,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // UserAccountsDrawerHeader(
                //   accountName: Text(),
                //   accountEmail: Text('email'),
                //   decoration: BoxDecoration(color: Colors.lightBlue),
                // ),
                SizedBox(
                  height: 50,
                ),
    
                //Header
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 26,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        FontAwesomeIcons.cogs,
                        color: Colors.red,
                        size: 24,
                      )
                    ],
                  ),
                ),
    
                SizedBox(
                  height: 50,
                ),
    
                // Change  Theme Option
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    'Change App Theme',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
                InkWell(
                  child: ListTile(
                      title: Text(
                        text,
                        style:
                            TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                      leading: ChangeThemeButtonWidget()),
                ),
    
                // User Profile
                // InkWell(
                //   onTap: () {},
                //   child: ListTile(
                //       title: Text(
                //         'User Profile',
                //         style:
                //             TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                //       ),
                //       leading: Icon(FontAwesomeIcons.userAlt,
                //           color: Colors.lightBlue)),
                // ),
    
                //Change User Password
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ResetPassword.id);
                  },
                  child: ListTile(
                      title: Text(
                        'Change Password',
                        style:
                            TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      leading: Icon(FontAwesomeIcons.userLock,
                          color: Theme.of(context).primaryColor)),
                ),
    
                //Logout option
                InkWell(
                  onTap: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('autoLogin', false);
    
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignIn.id, (Route<dynamic> route) => false);
                  },
                  child: ListTile(
                      title: Text(
                        'LogOut',
                        style:
                            TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      leading: Icon(FontAwesomeIcons.signOutAlt,
                          color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container for search box etc
              
              if (inprogressProvider.searchResult != null &&
                  inprogressProvider.searchResult!.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(left: 30, right: 20, bottom: 21, top: 15),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 45.0,
                  child: TextField(
                    onChanged: (value) {
                      _inprojectprovider.search(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 2),
                      hintText: 'e.g: Project Title',
                      hintStyle: kSearchboxhintstyle,
                      prefixIcon: Icon(
                        FontAwesomeIcons.search,
                        size: 13.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(45.0),
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: kTextfieldborderColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
    
              //Project Body
              ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: Expanded(
                  child: inprogressProvider.searchResult == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : inprogressProvider.searchResult!.isEmpty
                          ? Center(
                              child: Image.asset('assets/noitem.png.gif'),
                            )
                          : RefreshIndicator(
                              color: kGeneralbodytextColor,
                              backgroundColor: Theme.of(context).primaryColor,
                              onRefresh: () async {
                                await _inprojectprovider.getInprogressProjects();
                              },
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: inprogressProvider.searchResult!.length,
                                  itemBuilder: ((context, index) {
                                    InprogressModel inprogress =
                                        inprogressProvider.searchResult![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProgressDetails(inprogress)));
                                      },
                                      child: Container(
                                        width: 368,
                                        margin: EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          bottom: 30.0,
                                        ),
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            //Images
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    opacity: 0.2,
                                                      image: AssetImage(
                                                        'assets/Bc.png',
                                                      ),
                                                      fit: BoxFit.cover),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              height: 150,
                                              width: 310,
                                              margin: EdgeInsets.only(
                                                  bottom: 7.0, top: 7.0, left: 9.0),
                                              child: 
                                              inprogress.files!.isEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      child: Image.asset('assets/Bc.png', fit: BoxFit.cover ,))
                                                  : inprogress.files!.first
                                                              .fileExt ==
                                                          'image' &&
                                                      inprogress.files!.first
                                                          .fileUrl.isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(18),
                                                      child: CachedNetworkImage(
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Center(
                                                                child: Icon(
                                                                  Icons.error,
                                                                ),
                                                              ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                                    child: CircularProgressIndicator(),
                                                                  ),
                                                          imageUrl:
                                                              'https://www.batnf.net/${inprogress.files!.first.fileUrl}',
                                                          fit: BoxFit.cover),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(18),
                                                      child: CachedNetworkImage(
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Center(
                                                                child: Icon(
                                                                  Icons.error,
                                                                  color:
                                                                      Colors.black,
                                                                ),
                                                              ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  Center(
                                                                    child: CircularProgressIndicator(),
                                                                  ),
                                                          imageUrl:
                                                              'https://www.batnf.net/${inprogress.files!.first.thumbnail}',
                                                          fit: BoxFit.cover),
                                                    ),
                                            ),
                  
                                            // News Details
                                            Text(
                                              inprogress.projectTitle,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: 'Inter',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              // kNewsSubHeader,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Status: ',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: 'Inter',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  // kNewsSubHeader,
                                                ),
                                                Text(
                                                  inprogress.projectStatus,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontStyle: FontStyle.normal,
                                                      fontFamily: 'Inter',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  // kNewsSubHeader,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                  
                  // ListView(
                  //   children: [
                  //     //Inprogress Project
                  //     SizedBox(
                  //       height: 220,
                  //       width: 365,
                  //       child: Column(
                  //         children: [
                  //           // Inprogress Details
                  //           Expanded(
                  //             child: inprogressProvider.allInprogressProjects ==
                  //                     null
                  //                 ? Center(
                  //                     child: CircularProgressIndicator(),
                  //                   )
                  //                 : inprogressProvider
                  //                         .allInprogressProjects!.isEmpty
                  //                     ? Center(
                  //                         child:
                  //                             Image.asset('assets/noitem.png.gif'),
                  //                       )
                  //                     : ListView.builder(
                  //                         scrollDirection: Axis.horizontal,
                  //                         itemCount: inprogressProvider
                  //                             .allInprogressProjects!.length,
                  //                         itemBuilder: ((context, index) {
                  //                           InprogressModel inprogress =
                  //                               inprogressProvider
                  //                                   .allInprogressProjects![index];
                  //                           return GestureDetector(
                  //                             onTap: () {
                  //                               // Navigator.pushNamed(
                  //                               //     context, InprogressPage.id);
                  //                               Navigator.push(
                  //                                   context,
                  //                                   MaterialPageRoute(
                  //                                       builder: (context) =>
                  //                                           ProgressDetails(
                  //                                               inprogress)));
                  //                             },
                  //                             child: Container(
                  //                               color: Colors.transparent,
                  //                               width: 368,
                  //                               margin: EdgeInsets.only(
                  //                                 right: 10,
                  //                                 bottom: 30.0,
                  //                               ),
                  //                               child: Column(
                  //                                 children: [
                  //                                   // Inprogress Images
                  //                                   Container(
                  //                                    height: 150,
                  //                                     width: 310,
                  //                                     margin: EdgeInsets.only(
                  //                                         bottom: 7.0,
                  //                                         top: 7.0,
                  //                                         left: 9.0),
                  //                                     child: inprogress.files!.first
                  //                                                     .fileExt ==
                  //                                                 'image' &&
                  //                                             inprogress
                  //                                                 .files!
                  //                                                 .first
                  //                                                 .fileUrl
                  //                                                 .isNotEmpty
                  //                                         ? ClipRRect(
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(18),
                  //                                             child:
                  //                                                 CachedNetworkImage(
                  //                                                     errorWidget:
                  //                                                         (context,
                  //                                                                 url,
                  //                                                                 error) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     placeholder:
                  //                                                         (context,
                  //                                                                 url) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     imageUrl:
                  //                                                         'https://www.batnf.net/${inprogress.files!.first.fileUrl}',
                  //                                                     fit: BoxFit
                  //                                                         .cover),
                  //                                           )
                  //                                         : ClipRRect(
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(18),
                  //                                             child:
                  //                                                 CachedNetworkImage(
                  //                                                     errorWidget:
                  //                                                         (context,
                  //                                                                 url,
                  //                                                                 error) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     placeholder:
                  //                                                         (context,
                  //                                                                 url) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     imageUrl:
                  //                                                         'https://www.batnf.net/${inprogress.files!.first.thumbnail}',
                  //                                                     fit: BoxFit
                  //                                                         .cover),
                  //                                           ),
                  //                                   ),
                  
                  //                                   // Inprogress Information
                  //                                   Text(
                  //                                     inprogress.projectTitle,
                  //                                     style: kNewsSubHeader,
                  //                                   ),
                  //                                   // Text.rich(
                  //                                   //     textAlign:
                  //                                   //         TextAlign.justify,
                  //                                   //     overflow: TextOverflow
                  //                                   //         .ellipsis,
                  //                                   //     maxLines: 4,
                  //                                   //     TextSpan(
                  //                                   //         text: 'Title: ',
                  //                                   //         style:
                  //                                   //             kNewsSubHeader,
                  //                                   //         // ignore: prefer_const_literals_to_create_immutables
                  //                                   //         children: [
                  //                                   //           TextSpan(
                  //                                   //             style:
                  //                                   //                 kNewsDateSTyle,
                  //                                   //             text: inprogress
                  //                                   //                 .projectDescription,
                  //                                   //           )
                  //                                   //         ])),
                  //                                   Row(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment
                  //                                             .center,
                  //                                     children: [
                  //                                       Text(
                  //                                         'Status: ',
                  //                                         style:
                  //                                             kNewsSubHeader,
                  //                                       ),
                  //                                       Text(
                  //                                         inprogress
                  //                                             .projectStatus,
                  //                                         style:
                  //                                             kNewsSubHeader,
                  //                                         overflow:
                  //                                             TextOverflow
                  //                                                 .ellipsis,
                  //                                         maxLines: 1,
                  //                                       )
                  //                                     ],
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           );
                  //                         }),
                  //                       ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  
                  //     //Completed Project
                  //     SizedBox(
                  //       height: 230,
                  //       width: 365,
                  //       child: Column(
                  //         children: [
                  //           Expanded(
                  //             child: completedProvider.allCompletedProjects == null
                  //                 ? Center(
                  //                     child: CircularProgressIndicator(),
                  //                   )
                  //                 : completedProvider.allCompletedProjects!.isEmpty
                  //                     ? Center(
                  //                         child:
                  //                             Image.asset('assets/noitem.png.gif'),
                  //                       )
                  //                     : ListView.builder(
                  //                         scrollDirection: Axis.horizontal,
                  //                         itemCount: completedProvider
                  //                             .allCompletedProjects!.length,
                  //                         itemBuilder: ((context, index) {
                  //                           CompletedModel completed =
                  //                               completedProvider
                  //                                   .allCompletedProjects![index];
                  //                           return GestureDetector(
                  //                             onTap: () {
                  //                               // Navigator.pushNamed(
                  //                               //     context, CompletedPage.id);
                  //                               Navigator.push(
                  //                                   context,
                  //                                   MaterialPageRoute(
                  //                                       builder: (context) =>
                  //                                           CompletedProjectDetails(
                  //                                               completed)));
                  //                             },
                  //                             child: Container(
                  //                               color: Colors.transparent,
                  //                               width: 368,
                  //                               margin: EdgeInsets.only(
                  //                                 right: 10,
                  //                                 bottom: 30.0,
                  //                               ),
                  //                               child: Column(
                  //                                 children: [
                  //                                   // Completed Image
                  //                                   Container(
                  //                                     height: 150,
                  //                                     width: 310,
                  //                                     margin: EdgeInsets.only(
                  //                                         bottom: 7.0,
                  //                                         top: 7.0,
                  //                                         left: 9.0),
                  //                                     child: completed.files!.first
                  //                                                     .fileExt ==
                  //                                                 'image' &&
                  //                                             completed
                  //                                                 .files!
                  //                                                 .first
                  //                                                 .fileUrl
                  //                                                 .isNotEmpty
                  //                                         ? ClipRRect(
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(18),
                  //                                             child:
                  //                                                 CachedNetworkImage(
                  //                                                     errorWidget:
                  //                                                         (context,
                  //                                                                 url,
                  //                                                                 error) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     placeholder:
                  //                                                         (context,
                  //                                                                 url) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     imageUrl:
                  //                                                         'https://www.batnf.net/${completed.files!.first.fileUrl}',
                  //                                                     fit: BoxFit
                  //                                                         .cover),
                  //                                           )
                  //                                         : ClipRRect(
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(18),
                  //                                             child:
                  //                                                 CachedNetworkImage(
                  //                                                     errorWidget:
                  //                                                         (context,
                  //                                                                 url,
                  //                                                                 error) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     placeholder:
                  //                                                         (context,
                  //                                                                 url) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     imageUrl:
                  //                                                         'https://www.batnf.net/${completed.files!.first.thumbnail}',
                  //                                                     fit: BoxFit
                  //                                                         .cover),
                  //                                           ),
                  //                                   ),
                  
                  //                                   // Completed Project Info
                  //                                   Text(
                  //                                     completed.projectTitle,
                  //                                     style: kNewsSubHeader,
                  //                                   ),
                  //                                   // project Start Date
                  //                                   // Text.rich(
                  //                                   //     textAlign:
                  //                                   //         TextAlign.justify,
                  //                                   //     overflow: TextOverflow
                  //                                   //         .ellipsis,
                  //                                   //     maxLines: 4,
                  //                                   //     TextSpan(
                  //                                   //         text: 'Title: ',
                  //                                   //         style:
                  //                                   //             kNewsSubHeader,
                  //                                   //         // ignore: prefer_const_literals_to_create_immutables
                  //                                   //         children: [
                  //                                   //           TextSpan(
                  //                                   //             text: completed
                  //                                   //                 .projectDescription,
                  //                                   //             style:
                  //                                   //                 kNewsDateSTyle,
                  //                                   //           )
                  //                                   //         ])),
                  
                  //                                   //Project Status
                  //                                   Text.rich(TextSpan(
                  //                                       text: 'Status: ',
                  //                                       style: kNewsSubHeader,
                  //                                       // ignore: prefer_const_literals_to_create_immutables
                  //                                       children: [
                  //                                         TextSpan(
                  //                                           text: completed
                  //                                               .projectStatus,
                  //                                           style:
                  //                                               kNewsDateSTyle,
                  //                                         )
                  //                                       ]))
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           );
                  //                         }),
                  //                       ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  
                  //     // Pending Progress label
                  //     SizedBox(
                  //       height: 220,
                  //       width: 365,
                  //       child: Column(
                  //         children: [
                  //           Expanded(
                  //             child: pendingProvider.allPendingProjects == null
                  //                 ? Center(
                  //                     child: CircularProgressIndicator(),
                  //                   )
                  //                 : pendingProvider.allPendingProjects!.isEmpty
                  //                     ? Center(
                  //                         child:
                  //                             Image.asset('assets/noitem.png.gif'),
                  //                       )
                  //                     : ListView.builder(
                  //                         scrollDirection: Axis.horizontal,
                  //                         itemCount: pendingProvider
                  //                             .allPendingProjects!.length,
                  //                         itemBuilder: (((context, index) {
                  //                           PendingModel pending = pendingProvider
                  //                               .allPendingProjects![index];
                  //                           return GestureDetector(
                  //                             onTap: () {
                  //                               // Navigator.pushNamed(
                  //                               //     context, PendingPage.id);
                  //                               Navigator.push(
                  //                                   context,
                  //                                   MaterialPageRoute(
                  //                                       builder: (context) =>
                  //                                           PendingDetails(
                  //                                               pending)));
                  //                             },
                  //                             child: Container(
                  //                               color: Colors.transparent,
                  //                               width: 368,
                  //                               margin: EdgeInsets.only(
                  //                                 right: 10,
                  //                                 bottom: 30.0,
                  //                               ),
                  //                               child: Column(
                  //                                 children: [
                  //                                   //pending Project Image
                  //                                   Container(
                  //                                      height: 150,
                  //                                     width: 310,
                  //                                     margin: EdgeInsets.only(
                  //                                         bottom: 7.0,
                  //                                         top: 7.0,
                  //                                         left: 9.0),
                  //                                     child: pending.files!.first
                  //                                                     .fileExt ==
                  //                                                 'image' &&
                  //                                             pending
                  //                                                 .files!
                  //                                                 .first
                  //                                                 .fileUrl
                  //                                                 .isNotEmpty
                  //                                         ? ClipRRect(
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(18),
                  //                                             child:
                  //                                                 CachedNetworkImage(
                  //                                                     errorWidget:
                  //                                                         (context,
                  //                                                                 url,
                  //                                                                 error) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     placeholder:
                  //                                                         (context,
                  //                                                                 url) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     imageUrl:
                  //                                                         'https://www.batnf.net/${pending.files!.first.fileUrl}',
                  //                                                     fit: BoxFit
                  //                                                         .cover),
                  //                                           )
                  //                                         : ClipRRect(
                  //                                             borderRadius:
                  //                                                 BorderRadius
                  //                                                     .circular(18),
                  //                                             child:
                  //                                                 CachedNetworkImage(
                  //                                                     errorWidget:
                  //                                                         (context,
                  //                                                                 url,
                  //                                                                 error) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     placeholder:
                  //                                                         (context,
                  //                                                                 url) =>
                  //                                                             Center(
                  //                                                               child:
                  //                                                                   Text(
                  //                                                                 'Loading',
                  //                                                                 style: TextStyle(color: Colors.black),
                  //                                                               ),
                  //                                                             ),
                  //                                                     imageUrl:
                  //                                                         'https://www.batnf.net/${pending.files!.first.thumbnail}',
                  //                                                     fit: BoxFit
                  //                                                         .cover),
                  //                                           ),
                  //                                   ),
                  
                  //                                   //Pending Project Details
                  //                                   Text(pending.projectTitle,
                  //                                       style:
                  //                                           kNewsSubHeader),
                  
                  //                                   //Project Begin Date
                  //                                   // Text.rich(
                  //                                   //     textAlign:
                  //                                   //         TextAlign.justify,
                  //                                   //     overflow: TextOverflow
                  //                                   //         .ellipsis,
                  //                                   //     maxLines: 4,
                  //                                   //     TextSpan(
                  //                                   //         text: 'Title: ',
                  //                                   //         style:
                  //                                   //             kNewsSubHeader,
                  //                                   //         children: [
                  //                                   //           TextSpan(
                  //                                   //             text: pending
                  //                                   //                 .projectDescription,
                  //                                   //             style:
                  //                                   //                 kNewsDateSTyle,
                  //                                   //           ),
                  //                                   //         ])),
                  //                                   Text.rich(TextSpan(
                  //                                       text: 'Status: ',
                  //                                       style: kNewsSubHeader,
                  //                                       children: [
                  //                                         TextSpan(
                  //                                           text: pending
                  //                                               .projectStatus,
                  //                                           style:
                  //                                               kNewsDateSTyle,
                  //                                         ),
                  //                                       ]))
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           );
                  //                         })),
                  //                       ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  
                  //     SizedBox(
                  //       height: 15,
                  //     )
                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
