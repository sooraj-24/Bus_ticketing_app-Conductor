import 'package:buts_conductor_app/Controller/provider.dart';
import 'package:buts_conductor_app/View/scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, controller, child){
        return Scaffold(
          backgroundColor: kAccentBlue,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      height: MediaQuery.of(context).size.height*0.2,
                      alignment: const Alignment(0,-0.4),
                      decoration: const BoxDecoration(
                          color: kDarkBlue,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child: const SafeArea(
                        child: Text(
                          'Current Trip',
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 20,
                      right: 20,
                      bottom: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(4, 4), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(-4, -4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Scan QR',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ScanScreen();
                                }));
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: const BoxDecoration(
                                    color: kYellow,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.qr_code_scanner,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.63,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(-4, -4), // changes position of shadow
                      ),
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Passengers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(thickness: 1,),
                    Expanded(
                      child: controller.state == ViewState.busy
                          ? const Center(
                            child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(strokeWidth: 2, color: kBlue,),
                      ),
                          )
                          : controller.userData[controller.selectedIndex].status == null
                          ? Center(child: Text("Session in progress"))
                      : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.userData[controller.selectedIndex].users?.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.circle, size: 10, color: Colors.black54,),
                                Text(
                                    '${controller.userData[controller.selectedIndex].users?[index].email?.substring(0, controller.userData[controller.selectedIndex].users?[index].email?.indexOf('@')).toUpperCase()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

