import 'package:in_app_review/in_app_review.dart';

class Review {
  Future<void> storeReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      inAppReview.openStoreListing(
        appStoreId: '1606061004',
      );
    }
  }
}
