const photoUserDefault = 'https://firebasestorage.googleapis.com/v0/b/beautix-54f94.appspot.com/o/app%2Fdefault_small.jpg?alt=media&token=9b9929b8-e7e6-45cb-8c39-834f30c0c90f';
// cambio 310 x 414
/*
final double paramImageProfileRatio = 1.8;
final int paramImageProfileHeight = 310; // 300 * 1.3
final int paramImageProfileWidth = (paramImageProfileHeight * paramImageProfileRatio).round();

final double paramImageServiceRatio = 2.29;
final int paramImageServiceHeight = 144; // 327 * 2.27
final int paramImageServiceWidth = (paramImageServiceHeight * paramImageServiceRatio).round(); //403.0

final double paramImageSubServiceRatio = 2.0;
final int paramImageSubServiceHeight = 310; // 300 * 1.3
final int paramImageSubServiceWidth = (paramImageSubServiceHeight * paramImageSubServiceRatio).round();

final double paramImageOfferRatio = 1.7;
final int paramImageOfferHeight = 310; // 300 * 1.3
final int paramImageOfferWidth = (paramImageOfferHeight * paramImageOfferRatio).round();
final int paramImageOfferSmallHeight = 90; // 300 * 1.3
final int paramImageOfferSmallWidth = (paramImageOfferSmallHeight * paramImageOfferRatio).round();
*/
/* **** */
const int _maxW = 414;
const double paramImageProfileRatio = 1.8;
const int paramImageProfileWidth = _maxW;
final int paramImageProfileHeight = (paramImageProfileWidth / paramImageProfileRatio).round();

const double paramImageServiceRatio = 2.29;
const int paramImageServiceWidth = _maxW; // 327 * 2.27
final int paramImageServiceHeight = (paramImageServiceWidth / paramImageServiceRatio).round(); //403.0

const double paramImageSubServiceRatio = 2.0;
const int paramImageSubServiceWidth = _maxW;
final int paramImageSubServiceHeight = (paramImageSubServiceWidth / paramImageSubServiceRatio).round();

final double paramImageOfferRatio = 1.7;
const int paramImageOfferWidth = _maxW;
final int paramImageOfferHeight = (paramImageOfferWidth / paramImageOfferRatio).round();

final int paramImageOfferSmallHeight = 90; // 300 * 1.3
final int paramImageOfferSmallWidth = (paramImageOfferSmallHeight * paramImageOfferRatio).round();

/* **** */
final int controllerNameCount = 30;
final int controllerPassWordCount = 30;

final int controllerPhoneCount = 20;
final int controllerMailCount = 40;
final int controllerAddressCount = 100;
final int controllerCityCount = 100;
final int controllerZipCodeCount = 20;

final int controllerBioCount = 250;
final int controllerServiceNameCount = 30;
final String emailLog = "beautixApp@hotmail.com";
final String emailPasswordLog = "beautix_App54667531m";
final int controllerDescriptionItemCount = 100;
final int controllerOfferTitleCount = 17;
final int controllerOfferPriceCount = 15;
final int controllerOfferDescriptionItemCount = 255;
