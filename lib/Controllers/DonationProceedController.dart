import 'package:get/get.dart';

class DonationProceedController extends GetxController {
  RxInt price = 0.obs;
  RxInt itemCount = 1.obs;
  RxInt newPrice = 0.obs;

  initCustom() {
    itemCount.value = 1;
  }

  priceIncrease() {
    if(itemCount.value <= 4){
       itemCount.value += 1;
       newPrice.value = ((price.value) * (itemCount.value)) ;
    }

  }

  priceDecrease() {
    if (itemCount.value != 1) {
      itemCount.value -= 1;
      newPrice.value = (price.value * itemCount.value);
    }
  }
}
