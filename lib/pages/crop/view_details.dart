// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/custom_Elevated_Button.dart';
import 'package:flutter_agro_new/component/text_Input_field.dart';
import 'package:flutter_agro_new/component/top_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/cropPorgramModel.dart';

final GlobalKey<FormState> _form = GlobalKey<FormState>();

late CropProgramModel cropdata;
String WeekSelected = 'Select Category';
var weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'];
String CategorySelected = 'Select Category';
var categories = ['Select Category', 'Cat1', 'Cat2', 'Cat3', 'Cat4', 'Cat5'];
String ActiveIngridientSelected = 'Select Category';
var active = [
  'Active Ingridient 1',
  'Active Ingridient 2',
  'Active Ingridient 3',
  'Active Ingridient 4',
  'Active Ingridient 5'
];
String StatusSelected = 'Select Category';
var status = ['To Do', 'On Going', 'Completed'];
String UnitsSelected = 'Select Category';
var units = ['Kilogram', 'Gram', 'Liter', "Milliliter", "Pounds", "Tonnes"];

class ViewDetails extends StatefulWidget {
  ViewDetails({Key? key, this.weeks, this.id}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();

  String? weeks;
  final String? id;
  int? initial;
}

class _ViewDetailsState extends State<ViewDetails> {
  TextEditingController controller = TextEditingController();
  bool sort = true;
  List<Data>? filterData;

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        filterData!.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }
  }

  Future<CropProgramModel> fetchCropProgram() async {
    var client = http.Client();
    final response = await client
        .get(Uri.parse('https://agromate.website/laravel/api/get/program'));
    final parsed = jsonDecode(response.body);
    print(response.body);
    cropdata = CropProgramModel.fromJson(parsed);

    return cropdata;
  }

  @override
  void initState() {
    filterData = myData;
    super.initState();
  }

  buildPin() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 25, right: 25, bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel_outlined))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Add New Task",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Weeks",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
                                        fontFamily: 'Helvetica',
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                    isExpanded: true,
                                    value: WeekSelected,
                                    iconEnabledColor:
                                        Colors.transparent, // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff327C04),
                                    ),
                                    iconSize: 30,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                        fontFamily: 'Helvetica'),
                                    items: categories.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        WeekSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
                                        fontFamily: 'Helvetica',
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                    isExpanded: true,
                                    value: StatusSelected,
                                    iconEnabledColor:
                                        Colors.transparent, // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff327C04),
                                    ),
                                    iconSize: 30,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                        fontFamily: 'Helvetica'),
                                    items: categories.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        StatusSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 300,
                                    child: TextInputField(
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       25),
                                        //   FilteringTextInputFormatter.allow(
                                        //       RegExp('[a-zA-Z]')),
                                        // ],
                                        // textEditingController:
                                        //     cropTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Enter Title";
                                          }
                                          return null;
                                        },
                                        validatorText: ""))
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 300,
                                    child: TextInputField(
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       6),
                                        //   FilteringTextInputFormatter
                                        //       .digitsOnly
                                        // ],
                                        // textEditingController:
                                        //     yieldTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Enter Description";
                                          }
                                          return null;
                                        },
                                        validatorText: ""))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
                                        fontFamily: 'Helvetica',
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                    isExpanded: true,
                                    value: CategorySelected,
                                    iconEnabledColor:
                                        Colors.transparent, // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff327C04),
                                    ),
                                    iconSize: 30,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                        fontFamily: 'Helvetica'),
                                    items: categories.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        CategorySelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chemical",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 300,
                                    child: TextInputField(
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       6),
                                        //   FilteringTextInputFormatter
                                        //       .digitsOnly
                                        // ],
                                        // textEditingController:
                                        //     weeksTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Chemical";
                                          }
                                          return null;
                                        },
                                        validatorText: "")),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Active Ingridient",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 300,
                                  child: DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
                                        fontFamily: 'Helvetica',
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                    isExpanded: true,
                                    value: ActiveIngridientSelected,
                                    iconEnabledColor:
                                        Colors.transparent, // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff327C04),
                                    ),
                                    iconSize: 30,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                        fontFamily: 'Helvetica'),
                                    items: categories.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        ActiveIngridientSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                    width: 140,
                                    child: TextInputField(
                                        // inputFormatters: [
                                        //   LengthLimitingTextInputFormatter(
                                        //       6),
                                        //   FilteringTextInputFormatter
                                        //       .digitsOnly
                                        // ],
                                        // textEditingController:
                                        //     weeksTextEditingController,
                                        hintText: "",
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return "Please Enter Quantity";
                                          }
                                          return null;
                                        },
                                        validatorText: "")),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Units",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 140,
                                  child: DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xff327C04)
                                            .withOpacity(0.5),
                                        fontFamily: 'Helvetica',
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      errorStyle: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xff327C04),
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                    isExpanded: true,
                                    value: WeekSelected,
                                    iconEnabledColor:
                                        Colors.transparent, // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff327C04),
                                    ),
                                    iconSize: 30,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                        fontFamily: 'Helvetica'),
                                    items: categories.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        WeekSelected = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 296,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  final isValid =
                                      _form.currentState?.validate();
                                  if (isValid!) {
                                    // setState(() {
                                    //   addCropProgram().then((value) =>
                                    //       Navigator.pushNamed(
                                    //           context, '/table_view_crop'));
                                    // });
                                  } else {
                                    Flushbar(
                                      duration: const Duration(seconds: 2),
                                      message: "Please Enter All Details",
                                    ).show(context);
                                  }
                                  // addCropProgram();
                                  // Navigator.pop(context);
                                },
                                title: "Add",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: widget.initial ?? 0,
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            const SizedBox(height: 10),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            InkWell(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff327C04),
                              ),
                            ),
                            // const SizedBox(width: 10),
                            const Text(
                              'Crop Program Details',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                buildPin();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF327C04),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 9),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Color(0xffffffff),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      const Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xffffffff)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: SizedBox(
                                width: 250,
                                child: CupertinoSearchTextField(
                                  onChanged: (value) {
                                    // setState(() {
                                    //   myData = cropdata.data!
                                    //       .where(
                                    //         (element) => element.crop!
                                    //             .toLowerCase()
                                    //             .contains(
                                    //               value.toLowerCase(),
                                    //             ),
                                    //       )
                                    //       .toList();
                                    // });
                                  },
                                  controller: controller,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF327C04),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xff327C04)
                                        .withOpacity(0.11),
                                  ),
                                  itemSize: 25,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                  prefixInsets:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10, 8, 0, 8),
                                  placeholder: 'Search',
                                  suffixInsets:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 15, 2),
                                  placeholderStyle: TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.38),
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    top: 0,
                                    bottom: 0,
                                    right: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(
              width: 300,
              height: 50,
              child: TabBar(
                indicatorColor: Color(0xFF327C04),
                labelColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Color(0xFF6B6B6B)),
                labelStyle: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                tabs: [
                  Tab(
                    text: 'Grid',
                  ),
                  Tab(
                    text: 'Table',
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.7,
              child: TabBarView(children: [
                _gridview(context),
                FutureBuilder<CropProgramModel>(
                  future: fetchCropProgram(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return datatable(widget.weeks = 12.toString());
                      } else {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  datatable(weeks) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        height: screenSize.height * 0.6,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0.0),
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: PaginatedDataTable(
                    sortColumnIndex: 0,
                    sortAscending: sort,
                    source: RowSource(
                      weeks: int.parse(weeks),
                      myData: myData,
                      count: myData.length,
                    ),
                    rowsPerPage: 8,
                    columnSpacing: 0,
                    headingRowHeight: 50,
                    horizontalMargin: 0,
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Inventory Type",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Stock Code",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Inventory Class",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Description",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Unit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Stock Level",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Required",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Pre PI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff327C04).withOpacity(0.11),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "PI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      for (int length = 1;
                          length <= int.parse(widget.weeks!);
                          length++)
                        DataColumn(
                          label: Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xff327C04).withOpacity(0.11),
                              ),
                              child: Center(
                                child: Text(
                                  "W${length}",
                                  // "w",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W2",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W3",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W4",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // DataColumn(
                      //   label: Expanded(
                      //     child: Container(
                      //       height: 50,
                      //       decoration: BoxDecoration(
                      //         color: const Color(0xff327C04).withOpacity(0.11),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           "W5",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w500, fontSize: 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_gridview(context) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: _buildgridview(context),
  );
}

Widget _buildgridview(context) {
  final screenSize = MediaQuery.of(context).size;

  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (0.5 / 0.8),
          crossAxisCount: 4,
          mainAxisSpacing: 2,
          crossAxisSpacing: 3),
      itemCount: 12,
      itemBuilder: (BuildContext ctx, index) {
        //  var element = CropProgram.cropPrograms.elementAt(index);
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Week"),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: const Color(0xFFEBF2EB),
                  child: SizedBox(
                    height: screenSize.height * 0.2,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17, left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "GAP Questions",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Answer these Questions",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                child: FlutterLogo(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "22/12/22",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: const Color(0xFFEBF2EB),
                  child: SizedBox(
                    height: screenSize.height * 0.2,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17, left: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Title",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                child: FlutterLogo(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "22/22/22",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

class RowSource extends DataTableSource {
  var myData;
  final count;
  int weeks;
  RowSource({
    required this.myData,
    required this.count,
    required this.weeks,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData![index], weeks);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(var data, int weeks) {
  return DataRow(
    cells: [
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10), child: Text(data.name ?? "Name")))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.stockCode.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.inventory.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10), child: Text(data.desc.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10), child: Text(data.unit.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.stockL.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.required.toString())))),
      DataCell(Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(data.prepi.toString())))),
      DataCell(
          Align(alignment: Alignment.center, child: Text(data.pi.toString()))),
      for (int length = 1; length <= weeks; length++)
        DataCell(Align(
            alignment: Alignment.center,
            child: Padding(padding: EdgeInsets.all(10), child: Text("500")))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w2.toString()))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w3.toString()))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w4.toString()))),
      // DataCell(
      //     Align(alignment: Alignment.center, child: Text(data.w5.toString()))),
    ],
  );
}

class Data {
  String? name;
  String? stockCode;
  String? inventory;
  String? desc;
  String? unit;
  String? stockL;
  String? required;
  String? prepi;
  String? pi;
  String? w1;
  String? w2;
  String? w3;
  String? w4;
  String? w5;

  Data({
    required this.name,
    required this.stockCode,
    required this.inventory,
    required this.desc,
    required this.unit,
    required this.stockL,
    required this.required,
    required this.prepi,
    required this.pi,
    required this.w1,
    required this.w2,
    required this.w3,
    required this.w4,
    required this.w5,
  });
}

List<Data> myData = [
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
  Data(
    name: "Buffer",
    stockCode: '4BL01',
    inventory: 'Chemical',
    desc: 'Bladbuff - ml',
    unit: 'ml',
    stockL: '678.6',
    required: '678.6',
    prepi: '',
    pi: '500',
    w1: '500',
    w2: '500',
    w3: '500',
    w4: '500',
    w5: '500',
  ),
];
