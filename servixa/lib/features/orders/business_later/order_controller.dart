import 'package:get/get.dart' hide Trans;
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/orders/data_layer/models/orders_model.dart';

class OrderController extends GetxController {
  RxBool isSelectedMyOrders = true.obs;
  RxList<OrdersModel> myOrders = <OrdersModel>[].obs;
  RxList<OrdersModel> receivedOrders = <OrdersModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyOrders();
    getReceivedOrders();
  }

  void getMyOrders() {
    myOrders.addAll([
      OrdersModel(
        id: 1,
        requestDate: "requestDate",
        details:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",

        account: BusinessAccountModel(
          id: 1,
          businessNameArabic: "businessNameArabic",
          businessNameEnglish: "businessNameEnglish",
          typeBusinessAccount: "typeBusinessAccount",
          licenseNumber: 11111,
          city: "city",
          addressDetail: "addressDetail",
          location: "location",
          activities: "activities",
          details:
              "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",
          doc: [],
          status: "status",
        ),
        status: "status",
        quantity: 1,
      ),

      OrdersModel(
        id: 2,
        requestDate: "requestDate2",
        details:
            "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",

        account: BusinessAccountModel(
          id: 1,
          businessNameArabic: "businessNameArabic",
          businessNameEnglish: "businessNameEnglish",
          typeBusinessAccount: "typeBusinessAccount",
          licenseNumber: 11111,
          city: "city",
          addressDetail: "addressDetail",
          location: "location",
          activities: "activities",
          details:
              "Specialize in delivering high-quality construction solutions tailored to meet the unique needs of residential, commercia",
          doc: [],
          status: "status",
        ),
        status: "status",
        quantity: 1,
      ),
    ]);
  }

  void getReceivedOrders() {
    receivedOrders.addAll([
      OrdersModel(
        id: 3,
        requestDate: "requestDate3",
        details: "details3",
        account: BusinessAccountModel(
          id: 1,
          businessNameArabic: "businessNameArabic",
          businessNameEnglish: "businessNameEnglish",
          typeBusinessAccount: "typeBusinessAccount",
          licenseNumber: 11111,
          city: "city",
          addressDetail: "addressDetail",
          location: "location",
          activities: "activities",
          details: "details",
          doc: [],
          status: "status",
        ),
        status: "status",
        quantity: 1,
      ),

      OrdersModel(
        id: 4,
        requestDate: "requestDate4",
        details: "details4",
        account: BusinessAccountModel(
          id: 1,
          businessNameArabic: "businessNameArabic",
          businessNameEnglish: "businessNameEnglish",
          typeBusinessAccount: "typeBusinessAccount",
          licenseNumber: 11111,
          city: "city",
          addressDetail: "addressDetail",
          location: "location",
          activities: "activities",
          details: "details",
          doc: [],
          status: "status",
        ),
        status: "status",
        quantity: 1,
      ),
    ]);
  }
}
