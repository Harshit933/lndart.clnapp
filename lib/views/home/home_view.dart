import 'package:cln_common/cln_common.dart';
import 'package:clnapp/api/api.dart';
import 'package:clnapp/model/app_model/get_info.dart';
import 'package:clnapp/utils/app_provider.dart';
import 'package:clnapp/views/app_view.dart';
import 'package:clnapp/views/home/info_view.dart';
import 'package:clnapp/views/home/paymentlist_view.dart';
import 'package:clnapp/views/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomeView extends StatefulAppView {
  const HomeView({Key? key, required AppProvider provider})
      : super(key: key, provider: provider);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  late final pages = [
    _buildMainView(context: context),
    SettingView(provider: widget.provider),
  ];

  Widget _buildMainView({required BuildContext context}) {
    return FutureBuilder<AppGetInfo>(
        future: widget.provider.get<AppApi>().getInfo(),
        builder: (context, AsyncSnapshot<AppGetInfo> snapshot) {
          String? error;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Text(
              'Loading....',
              style: TextStyle(fontSize: 20),
            ));
          }
          if (snapshot.hasError) {
            /// This error resonates with the user either not having his/her node up
            /// or the file they have chosen can't communicate with the server.
            LogManager.getInstance.error("${snapshot.error}");
            LogManager.getInstance.error("${snapshot.stackTrace}");
            error = snapshot.error!.toString();
          } else if (snapshot.hasData) {
            var getInfo = snapshot.data!;
            return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(children: <Widget>[
                  InfoView(appGetInfo: getInfo, provider: widget.provider),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.08,
                          MediaQuery.of(context).size.height * 0.01,
                          0,
                          0),
                      child: const Text(
                        "Last Transaction",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  PaymentListView(provider: widget.provider),
                ]));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/exclamation.png'),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      error!,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            ],
          );
        });
  }

  Widget _buildBottomNavigation() {
    return BottomNavyBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedIndex: _currentIndex,
      showElevation: true,
      containerHeight: 68,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        // FIXME: move this inside an Item view
        BottomNavyBarItem(
          icon: const Icon(Icons.home_filled),
          title: const Text('Home'),
          textAlign: TextAlign.center,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).highlightColor,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          textAlign: TextAlign.center,
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).highlightColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CLN App"),
        centerTitle: false,
        primary: true,
        elevation: 0,
        leading: Container(),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
