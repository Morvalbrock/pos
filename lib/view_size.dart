import 'package:flutter/material.dart';

class View_size extends StatefulWidget {
  View_size({super.key, required Map<String, dynamic> this.sizeInfo});
  final Map<String, dynamic> sizeInfo;
  @override
  State<View_size> createState() => _View_productState();
}

class _View_productState extends State<View_size> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(236, 133, 36, 1),
        title: Text(
          'View Size Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 24.0,
            ),
            // alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 34, right: 34.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  'Size Name',
                                  style: TextStyle(
                                    color: Color(0xFF303030),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.01,
                                  ),
                                ),
                              ),
                              //  this.id,
//     this.comp_id,
//     this.sz_id,
//     this.sz_name,
//     this.sz_short,
//     this.sz_status,
//     this.created_at,
//     this.update_at,
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  widget.sizeInfo['sz_name'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFF183BB7),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.02,
                                  ),
                                ),
                              ),
                              Container(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit_note_sharp,
                                            size: 25,
                                          )),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete,
                                            size: 25,
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  'Size Short',
                                  style: TextStyle(
                                    color: Color(0xFF303030),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.01,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  widget.sizeInfo['sz_short'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFF183BB7),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.02,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.10,
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  'Size Status',
                                  style: TextStyle(
                                    color: Color(0xFF303030),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.01,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Text(
                                  widget.sizeInfo['sz_status'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFF183BB7),
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.02,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.10,
                                child: Align(heightFactor: 0.6),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
