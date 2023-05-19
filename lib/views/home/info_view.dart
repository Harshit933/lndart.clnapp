import 'package:clnapp/model/app_model/get_info.dart';
import 'package:clnapp/utils/app_provider.dart';
import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../pay/pay_view.dart';

class InfoView extends StatefulWidget {
  final AppGetInfo appGetInfo;
  final AppProvider provider;
  const InfoView({Key? key, required this.appGetInfo, required this.provider})
      : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.appGetInfo.alias,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Available balance",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            "${widget.appGetInfo.totOffChainMsat} sats",
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Container(
                height: 5,
                width: 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Container(
                height: 3,
                width: 3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            MainCircleButton(
              icon: Icons.send_outlined,
              label: "Send",
              onPress: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PayView(provider: widget.provider))),
              },
            ),
            MainCircleButton(
                icon: Icons.call_received_outlined,
                label: "Request",
                onPress: () {}),
          ])
        ]));
  }
}
