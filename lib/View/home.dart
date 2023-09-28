import 'package:another_flushbar/flushbar.dart';
import 'package:buts_conductor_app/Controller/provider.dart';
import 'package:buts_conductor_app/View/bus_card.dart';
import 'package:buts_conductor_app/View/session.dart';
import 'package:buts_conductor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    try {
      Provider.of<AppProvider>(context, listen: false).getBuses();
    } catch(e) {
      Flushbar(
        message: e.toString(),
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: kYellow,
        ),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: kYellow,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, controller, child){
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'All Trips',
                    style: TextStyle(
                        fontSize: 30,
                        color: kWhite,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                        color: kAccentBlue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                    ),
                    child: controller.state == ViewState.busy
                        ? const Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(color: kBlue, strokeWidth: 2,),
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.buses.bus?.length,
                      itemBuilder: (context, index){
                        return BusCard(
                          startTime: controller.buses.bus![index].startTime!,
                          destination: controller.buses.bus![index].destination!,
                          sessionStarted: controller.buses.bus![index].sessionStart!,
                          onTap: (){
                            controller.updateSelectedIndex(index);
                            try {
                              if(!controller.buses.bus![index].sessionStart!){
                                controller.startSession();
                              }
                            } catch(e) {
                              Flushbar(
                                message: e.toString(),
                                icon: const Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: kYellow,
                                ),
                                duration: const Duration(seconds: 3),
                                leftBarIndicatorColor: kYellow,
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return SessionScreen();
                            }));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
