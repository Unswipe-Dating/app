import 'package:flutter/material.dart';

class StatActivityCard extends StatelessWidget {


  const StatActivityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.bar_chart,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Last 24 hrs activity on the app",
                  style: TextStyle(
                    fontFamily: 'lato',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xffFFDEC6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Active men",
                              style: TextStyle(
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "6754",
                              style: TextStyle(
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffFFDEC6),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Active women",
                            style: TextStyle(
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "4758",
                            style: TextStyle(
                              fontFamily: 'lato',
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xffFFDEC6),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Number of matches",
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "6000",
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
