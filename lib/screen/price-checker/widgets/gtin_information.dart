import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_retailer_portal/blocs/global/global_states_events.dart';
import 'package:gtrack_retailer_portal/blocs/share/product_information/gtin_information_bloc.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/gtin_information_model.dart';
import 'package:ionicons/ionicons.dart';

GtinInformationModel? gtinInformationModel;

class GtinInformationWidget extends StatefulWidget {
  final String gtin;
  final String codeType;
  final bool isLoading;
  const GtinInformationWidget(
      {super.key,
      required this.gtin,
      required this.codeType,
      required this.isLoading});

  @override
  State<GtinInformationWidget> createState() => _GtinInformationWidgetState();
}

class _GtinInformationWidgetState extends State<GtinInformationWidget> {
  GtinInformationBloc gtinInformationBloc = GtinInformationBloc();
  bool isLoaded = false;

  // Models

  @override
  void initState() {
    final gtin = widget.gtin.length <= 13
        ? widget.gtin
        : widget.gtin.substring(0, widget.gtin.indexOf("-"));
    gtinInformationBloc = gtinInformationBloc..add(GlobalDataEvent(gtin));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GtinInformationBloc, GlobalState>(
      bloc: gtinInformationBloc,
      listener: (context, state) {
        if (state is GlobalLoadedState) {
          gtinInformationModel = state.data as GtinInformationModel;
        } else if (state is GlobalErrorState) {
          gtinInformationModel = null;
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            // dotted border
            border: Border.all(
              color: AppColors.black.withOpacity(0.7),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BorderedRowWidget(
                        value1: "GTIN",
                        value2: gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!.gtinArr!.gtin ?? '',
                      ),
                      BorderedRowWidget(
                        value1: "Brand name",
                        value2: gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!.gtinArr!.brandName ?? '',
                      ),
                      BorderedRowWidget(
                        value1: "Product Description",
                        value2: gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!
                                    .gtinArr!.productDescription ??
                                '',
                      ),
                      BorderedRowWidget(
                        value1: "Image URL",
                        value2: gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!.gtinArr!.productImageUrl ??
                                '',
                      ),
                      BorderedRowWidget(
                        value1: "Global Product Category",
                        value2: gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!.gtinArr!.gpcCategoryCode ??
                                '',
                      ),
                      // const BorderedRowWidget(
                      //     value1: "Net Content", value2: gtinInformationModel!.gtinArr!.),
                      BorderedRowWidget(
                        value1: "Country Of Sale",
                        value2: gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!
                                    .gtinArr!.countryOfSaleCode ??
                                '',
                      ),
                      // 30.height,
                      // PaginatedDataTable(
                      //   columns: const [
                      //     DataColumn(label: Text("Allergen Info")),
                      //     DataColumn(label: Text("Nutrients Info")),
                      //     DataColumn(label: Text("Batch")),
                      //     DataColumn(label: Text("Expiry")),
                      //     DataColumn(label: Text("Serial")),
                      //     DataColumn(label: Text("Manufecturing Date")),
                      //     DataColumn(label: Text("Best Before")),
                      //   ],
                      //   source: GtinInformationSource(),
                      //   arrowHeadColor: AppColors.green,
                      //   showCheckboxColumn: false,
                      //   rowsPerPage: 5,
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 200,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: AppColors.grey,
                    //   width: 1,
                    // ),
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.contain,
                      onError: (exception, stackTrace) => const Icon(
                        Ionicons.image_outline,
                      ),
                      image: CachedNetworkImageProvider(
                        gtinInformationModel == null
                            ? ""
                            : gtinInformationModel!.gtinArr!.productImageUrl
                                .toString(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BorderedRowWidget extends StatelessWidget {
  final String value1, value2;
  const BorderedRowWidget({
    super.key,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.black,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value1,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: AutoSizeText(
                value2,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GtinInformationSource extends DataTableSource {
  List<ProductContents> data = gtinInformationModel!.productContents!;

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(rowData.productAllergenInformation.toString())),
        DataCell(Text(rowData.productNutrientsInformation.toString())),
        DataCell(Text(rowData.batch.toString())),
        DataCell(Text(rowData.expiry.toString())),
        DataCell(Text(rowData.serial.toString())),
        DataCell(Text(rowData.manufacturingDate.toString())),
        DataCell(Text(rowData.bestBeforeDate.toString())),
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
