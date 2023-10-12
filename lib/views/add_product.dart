import 'dart:io';

import 'package:farm_city/constants/constant.dart';
import 'package:farm_city/controllers/product_controller.dart';
import 'package:farm_city/helpers/helpers.dart';
import 'package:farm_city/models/product_upload.dart';
import 'package:farm_city/widgets/top_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
//import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController = ProductController();
  ProductUpload productUpload =
      ProductUpload(productName: '', price: 0, description: '', categoryId: 1);
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //productController.init();
  }

  @override
  void dispose() {
    super.dispose();
    productController.dispose();
  }

  //List<Uint8List> images = [];
  String? imagePath;

  String selectedFile = '';

  late Uint8List selectedImageInBytes;
  List<XFile> images = [];

  pickImageFromDevice(bool imageFrom) async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();

    if (filePickerResult != null) {
      //images.add(filePickerResult.files.first.bytes!);
      setState(() {
        selectedFile = filePickerResult.files.first.name;
        selectedImageInBytes = filePickerResult.files.first.bytes!;
        images.add(XFile.fromData(filePickerResult.files.first.bytes!));
      });

      XFile xFile = XFile.fromData(filePickerResult.files.first.bytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whiteBG,
        title: NavBar(),
      ),
      body: ChangeNotifierProvider.value(
        value: productController,
        child: Consumer<ProductController>(
          builder: (_, model, child) {
            return Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    color: Constants.greyBG,
                    width: size.width / 1.2,
                    height: 80,
                    child: Row(
                      children: const [
                        Text(DefaultStrings.home),
                        SizedBox(
                          width: 10,
                        ),
                        Text('/'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          DefaultStrings.addProduct,
                          style: TextStyle(color: Constants.greenBG),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: SizedBox(
                        width: size.width / 1.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              DefaultStrings.addProduct,
                              style: TextStyle(
                                color: Constants.blackBG,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(DefaultStrings.productDetails),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 1,
                              width: size.width / 1.2,
                            ),
                            const SizedBox(height: 20),
                            const Text('Photos'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(
                                      images.length,
                                      (index) => Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    images[index].path,
                                                    height: 100,
                                                    fit: BoxFit.fitWidth,
                                                    width: 100,
                                                  ),
                                                ),
                                                Positioned.fill(
                                                    child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        images.removeAt(index);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 24,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          )),
                                ),
                                Visibility(
                                    visible: images.length == 8 ? false : true,
                                    child: GestureDetector(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Constants.greenBG,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.all(10),
                                        child: const Center(
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        pickImageFromDevice(true);
                                      },
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Product Name'),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: size.width / 2,
                              child: TextFormField(
                                initialValue: productUpload.productName,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onSaved: (val) {
                                  productUpload.productName = val!;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'product name is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Product name',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor)),
                              child: DropdownButton(
                                  isExpanded: true,
                                  value: 1,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text('Perishable'),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text('Non Perishable'),
                                    )
                                  ],
                                  onChanged: (selected) {
                                    setState(() {
                                      productUpload.categoryId = selected!;
                                    });
                                  },
                                  underline: Container()),
                            ),
                            const SizedBox(height: 10),
                            const Text('Price'),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: size.width / 2,
                              child: TextFormField(
                                initialValue: productUpload.price.toString(),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onSaved: (val) {
                                  productUpload.price = int.parse(val!);
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'price is required';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Price',
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('Description'),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: size.width / 2,
                              child: TextFormField(
                                initialValue: productUpload.description,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onSaved: (val) {
                                  productUpload.description = val!;
                                },
                                maxLines: 5,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () => {
                                  if (formkey.currentState!.validate())
                                    {
                                      formkey.currentState!.save(),
                                      if (images.isEmpty)
                                        {
                                          MethodHelpers
                                              .showErrorBarWithNoActionButton(
                                                  "Please upload some images for this product."),
                                        }
                                      else
                                        {
                                          model.submit(
                                              productUpload,
                                              images
                                                  .map((e) => e.path)
                                                  .toList()),
                                        }
                                    }
                                },
                                child: const Center(
                                  child: Text(DefaultStrings.addProduct),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
