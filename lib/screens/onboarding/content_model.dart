class OnboardingContent {
  String? discription;
  String? image;
  String? title;

  OnboardingContent({this.image, this.title, this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Pay Bills and Send Money with ease',
    image: 'assets/images/fago(1).png',
    discription:
        'You can now send money to friends and family conveniently with free transfer charges.',
  ),
  OnboardingContent(
    title: 'Manage your Businesses with Joy and comfort ',
    image: 'assets/images/fago(2).png',
    discription:
        'Create invoices, keep customer records and their credits, and create sub accounts.',
  ),
  OnboardingContent(
    title: 'Shop conveniently with your virtual card',
    image: 'assets/images/fago(3).png',
    discription:
        'Pay for your online purchases from anywhere around the world with your FagoCard.',
  ),
];
