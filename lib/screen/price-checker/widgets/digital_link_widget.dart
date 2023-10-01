import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/constants/app_icons.dart';
import 'package:gtrack_retailer_portal/controller/product_information/product_information_controller.dart';
import 'package:gtrack_retailer_portal/controller/product_information/safety_informaiton_controller.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/leaflets_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/location_origin_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/packaging_composition_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/product_contents_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/product_recall_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/promotional_offer_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/recipe_model.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/safety_information_model.dart';
import 'package:nb_utils/nb_utils.dart';

// Some global variables
List<SafetyInfromationModel> safetyInformation = [];
List<PromotionalOfferModel> promotionalOffer = [];
List<ProductContentsModel> productContents = [];
List<LocationOriginModel> locationOrigin = [];
List<ProductRecallModel> productRecall = [];
List<RecipeModel> recipe = [];
List<PackagingCompositionModel> packagingComposition = [];
List<LeafletsModel> leaflets = [];

class DigitalLinkScreen extends StatefulWidget {
  final String gtin;
  final String codeType;
  const DigitalLinkScreen({
    Key? key,
    required this.gtin,
    required this.codeType,
  }) : super(key: key);

  @override
  State<DigitalLinkScreen> createState() => _DigitalLinkScreenState();
}

class _DigitalLinkScreenState extends State<DigitalLinkScreen> {
  final List data = [
    "Safety Information",
    "Product Recall",
    "Promotional Offers",
    "Recipe",
    "Product Contents",
    "Packaging Composition",
    "Product Location Of Origin",
    "Electronic Leaflets",
  ];

  final List<Widget> screens = [];
  String? gtin;

  // Default Radio Button Selected Item When App Starts.
  int selectedIndex = 0;
  @override
  void initState() {
    if (widget.codeType == "1D") {
      gtin = widget.gtin;
    } else {
      gtin = widget.gtin.substring(1, 14);
    }
    screens.insert(0, SafetyInformation(gtin: gtin ?? ""));
    screens.insert(1, ProductRecall(gtin: gtin ?? ""));
    screens.insert(2, PromotionalOffers(gtin: gtin ?? ""));
    screens.insert(3, Recipe(gtin: gtin ?? ""));
    screens.insert(4, ProductContents(gtin: gtin ?? ""));
    screens.insert(5, PackagingComposition(gtin: gtin ?? ""));
    screens.insert(6, ProductLocationOfOrigin(gtin: gtin ?? ""));
    screens.insert(7, ElectronicLeaflets(gtin: gtin ?? ""));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              tileColor: AppColors.green.withOpacity(0.2),
              leading: Image.asset(AppIcons.gs1Logo),
              title: const Text("Complete Data"),
              subtitle: const Text("The number is registered to Company"),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.orange,
                border: Border.all(
                  color: AppColors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "Digital Link Information",
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Create list of radio list based on above data variable but we will be able to select only one at a time.
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: context.isPortrait ? 9.0 : 6.0,
              ),
              shrinkWrap: true,
              itemCount: data.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? AppColors.primary
                          : index == 1
                              ? AppColors.skyBlue
                              : index == 2
                                  ? Colors.blue
                                  : index == 3
                                      ? AppColors.danger
                                      : index == 4
                                          ? Colors.blue[900]
                                          : index == 5
                                              ? AppColors.green
                                              : index == 6
                                                  ? AppColors.danger
                                                  : index == 7
                                                      ? Colors.red[900]
                                                      : AppColors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      data[index],
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(horizontal: 5),
            ),
            const Divider(thickness: 2, color: AppColors.green),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: context.width(),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: const Text(
                "Detailed Information",
                style: TextStyle(
                  fontSize: 25,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            screens[selectedIndex],
          ],
        ),
      ),
    );
  }
}

class SafetyInformation extends StatefulWidget {
  final String gtin;
  const SafetyInformation({Key? key, required this.gtin}) : super(key: key);

  @override
  State<SafetyInformation> createState() => _SafetyInformationState();
}

class _SafetyInformationState extends State<SafetyInformation> {
  bool isLoaded = false;
  @override
  void initState() {
    setState(() {
      SafetyInfromationController.getSafeInfromation(widget.gtin).then((value) {
        safetyInformation = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                    value1: "Safety Information",
                    value2:
                        safetyInformation[0].safetyDetailedInformation ?? ""),
                KeyValueWidget(
                    value1: "Link Type",
                    value2: safetyInformation[0].linkType ?? ""),
                KeyValueWidget(
                    value1: "Target Url",
                    value2: safetyInformation[0].targetURL ?? ""),
                KeyValueWidget(
                    value1: "Company Name",
                    value2: safetyInformation[0].companyName ?? ""),
              ],
            ),
          );
  }
}

class SafetyInformationSource extends DataTableSource {
  List<SafetyInfromationModel> data = safetyInformation;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.safetyDetailedInformation.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.lang.toString())),
        DataCell(Text(rowData.targetURL.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.logo.toString())),
        DataCell(Text(rowData.companyName.toString())),
        DataCell(Text(rowData.process.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class PromotionalOffers extends StatefulWidget {
  final String gtin;
  const PromotionalOffers({Key? key, required this.gtin}) : super(key: key);

  @override
  State<PromotionalOffers> createState() => _PromotionalOffersState();
}

class _PromotionalOffersState extends State<PromotionalOffers> {
  bool isLoaded = false;
  @override
  void initState() {
    setState(() {
      ProductInformationController.getPromotionalOffer(widget.gtin)
          .then((value) {
        promotionalOffer = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                    value1: "Promotional Offers",
                    value2: promotionalOffer[0].promotionalOffers ?? ""),
                KeyValueWidget(
                    value1: "Link Type",
                    value2: promotionalOffer[0].linkType ?? ""),
                KeyValueWidget(
                    value1: "Target URL",
                    value2: promotionalOffer[0].targetURL ?? ""),
                KeyValueWidget(
                  value1: "Price",
                  value2: promotionalOffer[0].price.toString() == "null"
                      ? "0"
                      : promotionalOffer[0].price.toString(),
                ),
              ],
            ),
          );
  }
}

class PromotionalOfferSource extends DataTableSource {
  List<PromotionalOfferModel> data = promotionalOffer;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.promotionalOffers.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.lang.toString())),
        DataCell(Text(rowData.targetURL.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.expiryDate.toString())),
        DataCell(Text(rowData.price.toString())),
        DataCell(Text(rowData.banner.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class ProductContents extends StatefulWidget {
  final String gtin;
  const ProductContents({Key? key, required this.gtin}) : super(key: key);

  @override
  State<ProductContents> createState() => _ProductContentsState();
}

class _ProductContentsState extends State<ProductContents> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      ProductInformationController.getProductContents(widget.gtin)
          .then((value) {
        productContents = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                  value1: "Product Allergen Informaion",
                  value2: productContents[0].productAllergenInformation ?? "",
                ),
                KeyValueWidget(
                  value1: "Allergen Info",
                  value2: productContents[0].allergenInfo ?? "",
                ),
                KeyValueWidget(
                  value1: "Ingredients",
                  value2: productContents[0].ingredients ?? "",
                ),
                KeyValueWidget(
                  value1: "Manufacturing Date",
                  value2: productContents[0].manufacturingDate ?? "",
                ),
                KeyValueWidget(
                  value1: "Best before Date",
                  value2: productContents[0].bestBeforeDate ?? "",
                ),
              ],
            ),
          );
  }
}

class ProductContentsSource extends DataTableSource {
  List<ProductContentsModel> data = productContents;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.productAllergenInformation.toString())),
        DataCell(Text(rowData.productNutrientsInformation.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.batch.toString())),
        DataCell(Text(rowData.expiry.toString())),
        DataCell(Text(rowData.serial.toString())),
        DataCell(Text(rowData.manufacturingDate.toString())),
        DataCell(Text(rowData.bestBeforeDate.toString())),
        DataCell(Text(rowData.gLNIDFrom.toString())),
        DataCell(Text(rowData.unitPrice.toString())),
        DataCell(Text(rowData.ingredients.toString())),
        DataCell(Text(rowData.allergenInfo.toString())),
        DataCell(Text(rowData.calories.toString())),
        DataCell(Text(rowData.sugar.toString())),
        DataCell(Text(rowData.salt.toString())),
        DataCell(Text(rowData.fat.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class ProductLocationOfOrigin extends StatefulWidget {
  final String gtin;
  const ProductLocationOfOrigin({Key? key, required this.gtin})
      : super(key: key);

  @override
  State<ProductLocationOfOrigin> createState() =>
      _ProductLocationOfOriginState();
}

class _ProductLocationOfOriginState extends State<ProductLocationOfOrigin> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      ProductInformationController.getProductLocationOrigin(widget.gtin)
          .then((value) {
        locationOrigin = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                  value1: "Product Location Origin",
                  value2: locationOrigin[0].productLocationOrigin ?? "",
                ),
                KeyValueWidget(
                  value1: "Link Type",
                  value2: locationOrigin[0].linkType ?? "",
                ),
                KeyValueWidget(
                  value1: "GTIN",
                  value2: locationOrigin[0].gTIN ?? "",
                ),
                // KeyValueWidget(
                //   value1: "Manufacturing Date",
                //   value2: locationOrigin[0]. ?? "",
                // ),
              ],
            ),
          );
  }
}

class ProductLocationOriginSource extends DataTableSource {
  List<LocationOriginModel> data = locationOrigin;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.productLocationOrigin.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.lang.toString())),
        DataCell(Text(rowData.targetURL.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.expiryDate.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class ProductRecall extends StatefulWidget {
  final String gtin;
  const ProductRecall({Key? key, required this.gtin}) : super(key: key);

  @override
  State<ProductRecall> createState() => _ProductRecallState();
}

class _ProductRecallState extends State<ProductRecall> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      ProductInformationController.getProductRecallByGtin(widget.gtin)
          .then((value) {
        productRecall = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                    value1: "Product Recall",
                    value2: productRecall[0].productRecall ?? ""),
                KeyValueWidget(
                    value1: "GTIN", value2: productRecall[0].gTIN ?? ""),
                KeyValueWidget(
                    value1: "Link Type",
                    value2: productRecall[0].linkType ?? ""),
                KeyValueWidget(
                    value1: "Expiry Date",
                    value2: productRecall[0].expiryDate ?? ""),
              ],
            ),
          );
  }
}

class ProductRecallSource extends DataTableSource {
  List<ProductRecallModel> data = productRecall;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.productRecall.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.lang.toString())),
        DataCell(Text(rowData.targetURL.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.expiryDate.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class Recipe extends StatefulWidget {
  final String gtin;
  const Recipe({Key? key, required this.gtin}) : super(key: key);

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      ProductInformationController.getRecipeByGtin(widget.gtin).then((value) {
        recipe = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(value1: "Title", value2: recipe[0].title ?? ""),
                KeyValueWidget(
                    value1: "Description", value2: recipe[0].description ?? ""),
                KeyValueWidget(
                    value1: "Ingredients", value2: recipe[0].ingredients ?? ""),
                KeyValueWidget(
                    value1: "Link Type", value2: recipe[0].linkType ?? ""),
              ],
            ),
          );
  }
}

class RecipeSource extends DataTableSource {
  List<RecipeModel> data = recipe;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.logo.toString())),
        DataCell(Text(rowData.title.toString())),
        DataCell(Text(rowData.description.toString())),
        DataCell(Text(rowData.ingredients.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.gTIN.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class PackagingComposition extends StatefulWidget {
  final String gtin;
  const PackagingComposition({Key? key, required this.gtin}) : super(key: key);

  @override
  State<PackagingComposition> createState() => _PackagingCompositionState();
}

class _PackagingCompositionState extends State<PackagingComposition> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      ProductInformationController.getPackagingCompositionByGtin(widget.gtin)
          .then((value) {
        packagingComposition = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                  value1: "Packaging Composition",
                  value2: packagingComposition[0].packaging ?? "",
                ),
                KeyValueWidget(
                  value1: "Link Type",
                  value2: packagingComposition[0].linkType ?? "",
                ),
                KeyValueWidget(
                  value1: "Recyclability",
                  value2: packagingComposition[0].recyclability ?? "",
                ),
                KeyValueWidget(
                  value1: "Material",
                  value2: packagingComposition[0].material ?? "",
                ),
              ],
            ),
          );
  }
}

class PackagingCompositionSource extends DataTableSource {
  List<PackagingCompositionModel> data = packagingComposition;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.logo.toString())),
        DataCell(Text(rowData.title.toString())),
        DataCell(Text(rowData.consumerProductVariant.toString())),
        DataCell(Text(rowData.packaging.toString())),
        DataCell(Text(rowData.material.toString())),
        DataCell(Text(rowData.recyclability.toString())),
        DataCell(Text(rowData.productOwner.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.brandOwner.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class ElectronicLeaflets extends StatefulWidget {
  final String gtin;
  const ElectronicLeaflets({Key? key, required this.gtin}) : super(key: key);

  @override
  State<ElectronicLeaflets> createState() => _ElectronicLeafletsState();
}

class _ElectronicLeafletsState extends State<ElectronicLeaflets> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      ProductInformationController.getLeafletsByGtin(widget.gtin).then((value) {
        leaflets = value;
        setState(() {
          isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded != true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: context.width(),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                KeyValueWidget(
                  value1: "Product Leaflet Information",
                  value2: leaflets[0].productLeafletInformation ?? "",
                ),
                KeyValueWidget(
                  value1: "Link Type",
                  value2: leaflets[0].linkType ?? "",
                ),
                KeyValueWidget(
                  value1: "Language",
                  value2: leaflets[0].lang ?? "",
                ),
                KeyValueWidget(
                  value1: "GTIN",
                  value2: leaflets[0].gTIN ?? "",
                ),
                // KeyValueWidget(
                //   value1: "Manufacturing Date",
                //   value2: locationOrigin[0]. ?? "",
                // ),
              ],
            ),
          );
  }
}

class LeafletsSource extends DataTableSource {
  List<LeafletsModel> data = leaflets;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.iD.toString())),
        DataCell(Text(rowData.productLeafletInformation.toString())),
        DataCell(Text(rowData.lang.toString())),
        DataCell(Text(rowData.linkType.toString())),
        DataCell(Text(rowData.targetURL.toString())),
        DataCell(Text(rowData.gTIN.toString())),
        DataCell(Text(rowData.pdfDoc.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class KeyValueWidget extends StatelessWidget {
  final String value1, value2;
  const KeyValueWidget({
    super.key,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value1,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.cyan.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Colon between key and value
          const Text(
            ":   ",
            style: TextStyle(
              fontSize: 15,
              color: AppColors.cyan,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SelectableText(
              value2,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
