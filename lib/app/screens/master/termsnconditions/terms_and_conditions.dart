import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:las_warehouse/app/data/controller/termsnconditions_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/models/termsnConditions_model.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';

class TermsnConditions extends StatefulWidget {
  const TermsnConditions({super.key});

  @override
  State<TermsnConditions> createState() => TermsnConditionsState();
}

class TermsnConditionsState extends State<TermsnConditions> {
  String? textData;
  HtmlEditorController controller = HtmlEditorController();
  final termsnConditionsController = Get.put(TermsnConditionsController());
  TermsDetails termsDetails = TermsDetails();

  @override
  void initState() {
    super.initState();
  }

  _willpop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_1,
      appBar: BaseAppBar(),
      endDrawer: const DrawerMenu(),
      body: WillPopScope(
        onWillPop: () => _willpop(),
        child: Obx(() {
          termsDetails = termsnConditionsController.termsDetails.value;
          return termsnConditionsController.load.value
              ? LoaderWidget('')
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 5, left: 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Terms and Conditions",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.80,
                          color: Colors.white,
                          child: HtmlEditor(
                            htmlToolbarOptions: const HtmlToolbarOptions(
                              toolbarType: ToolbarType.nativeExpandable,
                              toolbarPosition: ToolbarPosition.aboveEditor,
                              buttonBorderWidth: 1.2,
                              renderBorder: true,
                              initiallyExpanded: false,
                              // renderSeparatorWidget: false,
                              toolbarItemHeight: 25,
                              // gridViewHorizontalSpacing: 8,
                              // gridViewVerticalSpacing: 3,
                              //toolbarType: ToolbarType.nativeGrid
                            ),
                            otherOptions: OtherOptions(
                              height: MediaQuery.of(context).size.height * 0.80,
                            ),
                            controller: controller, //required
                            htmlEditorOptions: HtmlEditorOptions(
                              shouldEnsureVisible: true,
                              hint: "Start Writing...",
                              initialText:
                                  "${termsDetails.termsConditions ?? ''}",
                              // initialText: "You are hereby requested to complete work order under the following terms &Conditions:<br>Proceedings:<br><br> Shifting of material should commence on DD.MM.YYYY.<br>2. Delivery Schedule: Within 48 four hours after receiving work order.<br>3. Equipments: You should be well equipped with all necessary tools & items for the Shifting of Materials. All required materials will be provided by you time to time during transportation. M/s ABCD has no responsibility to provide you any kind of items for the shifting.<br>4. Documentation: You will provide your past experience certificates from renowned organization along with your invoice to us.<br>5. Payment Schedule: We treat your quotation dated DD.MM.YYYY is the full and final quotation value for which 50% advance will be made upon your acceptance of this WO and against your Invoice to us. Balance payment will be released after completion of work. No further claim negotiation will be entertained afterwards. Payment will be made vide Online Transfer/Cheque/DD in favour of M/s XYZ.<br>6. Confidentiality and secrecy: The Contractor commits herself to treat all non-public information confided to her during her professional activities for the shifting with strict confidentiality and her obligation to treat all information in connection with the transportation confidentially and execute the transportation in accordance with good practices. The Contractor will also impose the pledge to secrecy on all third parties involved in the execution of the order. Any and all data relating to the contract as well as any other information of which the contractor becomes aware in the course of performing the contract must be treated as confidential even beyond the term of the contract. The contractor shall not be permitted to make use of any such data and information for the contractor's own purposes.<br>7. Quality of work and services: The work and services to be provided must comply with the recognized state of the art and the generally accepted rules of technology as well as being consistent with the general strategy of the ultimate commissioning party/client. They must be of excellent quality.The work and services and the necessary work results must take into account the local conditions in accordance to the relevant law and order of the State/[country] Govt., the financing possibilities and the general, special and social impacts of the measure.<br>8. Subcontracts: Any subcontracting of work and services by the contractor to third parties shall require the prior written approval of ABCD, unless the contract stipulates that such work or services be procured by the contractor.<br>9. Obligations: The contractor shall at all times act in an impartial and loyal manner. The contractor shall ensure that the staff it employs as well as its subcontractors comply with the provisions of these Terms and Conditions and the con-tract, where applicable.<br>10. Termination: ABCD may terminate the contract at any time either wholly or in respect of individual parts of the work and services or with regard to individual experts.<br>11. Liability: The contractor's contractual liability is limited to [currency] 1,00,000.00. If the total con-tract value exceeds this figure, the contractor's contractual liability shall be limited to the total contract value. This limitation of liability shall not apply in the event of the contractor's intent or gross negligence.   It further does not apply to loss of life, bodily injury or damage to health. ABCD shall be entitled to claim for loss or damage suffered by the recipient of the work and services as a result of non-compliance with the contractor's contractual obligations.<br>12. Working Hours: The working hours of the contractor and assigned expert shall be determined by the ABCD representative on the basis of requirements of the measure and the conditions in the regional aspects of assignment.<br>13. Jurisdiction: The place of jurisdiction will be  [name of city] ",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryblue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(),
                            ),
                          ),
                          onPressed: () async {
                            var txt = await controller.getText();

                            setState(() {
                              textData = txt;
                            });
                            await termsnConditionsController
                                .addTermsnConditionsAPI(textData!)
                                .then((value) {
                              if (value['result'] == true) {
                                Get.toNamed('/termsnconditions');
                              }
                            });
                          },
                          child: const Text(
                            'SAVE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
