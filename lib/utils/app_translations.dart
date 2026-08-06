import 'package:get/get.dart';

import 'app_strings.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      AppStrings.appName: 'FND Store',
      AppStrings.selectLanguage: 'Select Language',
      AppStrings.english: 'English',
      AppStrings.arabic: 'Arabic',
      AppStrings.arabicSymbol: 'ض',
      AppStrings.continueText: 'Continue',
      AppStrings.onboardingWelcome: 'Welcome to F.N.D Store',
      AppStrings.onboardingDescription:
          'Lorem Ipsum is simply dummy text of the printing\n'
          'and typesetting industry.',
      AppStrings.skip: 'Skip',
      AppStrings.next: 'Next',
      AppStrings.back: 'Back',
      AppStrings.getStarted: 'Get Started',
      AppStrings.selectCountry: 'Select Country',
      AppStrings.searchCountry: 'Search country',
      AppStrings.error: 'Error',
      AppStrings.completeProfile: 'Complete Profile',
      AppStrings.addProfilePhotoOptional: 'Add profile photo (optional)',
      AppStrings.chooseFromLibrary: 'Choose from Photo Library',
      AppStrings.takePhoto: 'Take Photo',
      AppStrings.cancel: 'Cancel',
      AppStrings.firstName: 'First name',
      AppStrings.firstNameHint: 'Mily',
      AppStrings.lastName: 'Last name',
      AppStrings.lastNameHint: 'Deo',
      AppStrings.email: 'Email',
      AppStrings.emailHint: 'milydeo123@gmail.com',
      AppStrings.phoneNumber: 'Phone Number',
      AppStrings.phoneHint: '50 000 0000',
      AppStrings.agreeWith: 'I agree with the ',
      AppStrings.termsAndConditions: 'Terms & Conditions.',
      AppStrings.alreadyHaveAccount: 'Already have an account? ',
      AppStrings.signIn: 'Sign In',
      AppStrings.loginPhoneTitle: 'Phone Number',
      AppStrings.loginPhoneDescription:
          'Please enter your valid phone number. We will send\n'
          'you a 4-digit code to verify your account.',
      AppStrings.phonePrivacyNote: "We'll never share your number",
      AppStrings.loginPhoneHint: '1234567890',
      AppStrings.orContinueWith: 'Or continue with',
      AppStrings.dontHaveAccount: "Don't have an account? ",
      AppStrings.signUp: 'Sign Up',
      AppStrings.verificationCode: 'Verification Code',
      AppStrings.verificationDescription:
          "Type the verification code\nwe've sent you",
      AppStrings.resendIn: 'Resend in',
      AppStrings.resendCode: 'Resend code',
      AppStrings.storeDetails: 'Store Details',
      AppStrings.storeName: 'Store Name',
      AppStrings.storeNameHint: 'F.N.D Online',
      AppStrings.storeLocation: 'Store Location',
      AppStrings.storeLocationHint: 'Dubai, UAE',
      AppStrings.accountCreated: 'Account Created',
      AppStrings.accountCreatedDescription:
          'Your account has been created\nsuccessfully.',
      AppStrings.home: 'Home',
      AppStrings.bookings: 'Bookings',
      AppStrings.profile: 'Profile',
      AppStrings.settings: 'Settings',
      AppStrings.homeGreeting: 'Hey, Mark! 👋',
      AppStrings.happyCollecting: 'Happy Collecting!',
      AppStrings.noDeliveryRequests: 'No Delivery Requests Yet!',
      AppStrings.noDeliveryRequestsDescription:
          "You haven't created any delivery requests today. Start\n"
          'by creating a new request and assign it to a driver.',
      AppStrings.createRequest: 'Create Request',
      AppStrings.recipientDetail: 'Recipient Detail',
      AppStrings.customerName: 'Customer Name',
      AppStrings.enter: 'Enter',
      AppStrings.packageDetails: 'Package Details',
      AppStrings.productImage: 'Product Image',
      AppStrings.upload: 'Upload',
      AppStrings.pickupLocation: 'Pickup Location',
      AppStrings.dropoffLocation: 'Dropoff Location',
      AppStrings.enterLocation: 'Enter location',
      AppStrings.date: 'Date',
      AppStrings.time: 'Time',
      AppStrings.select: 'Select',
      AppStrings.packageInstructions: 'Package Instructions',
      AppStrings.enterHere: 'Enter here...',
      AppStrings.create: 'Create',
      AppStrings.totalDelivered: 'Total Delivered',
      AppStrings.todaysBookings: "Today's Bookings",
      AppStrings.viewAll: 'View All',
      AppStrings.orderId: 'Order ID',
      AppStrings.orderPickedUp: 'Order picked up',
      AppStrings.driverOnWay: 'Driver on the way',
      AppStrings.pickup: 'Pickup',
      AppStrings.dropoff: 'Drop-off',
      AppStrings.downtownHub: 'Downtown Hub',
      AppStrings.westsideTerminal: 'Westside Terminal',
      AppStrings.eastPort: 'East Port',
      AppStrings.centralStorage: 'Central Storage',
      AppStrings.today1430: 'Today, 14:30 PM',
      AppStrings.today1615: 'Today, 16:15 PM',
      AppStrings.track: 'Track',
      AppStrings.ongoing: 'Ongoing',
      AppStrings.upcoming: 'Upcoming',
      AppStrings.completed: 'Completed',
      AppStrings.schedule: 'Schedule',
      AppStrings.details: 'Details',
      AppStrings.delivered: 'Delivered',
      AppStrings.centralLogisticsHub: 'Central Logistics Hub, Gate 4',
      AppStrings.bakerStreet: '122 Baker St, Marylebone',
      AppStrings.docklandsWarehouse: 'Docklands Warehouse A',
      AppStrings.regentsPark: "77 Regent's Park Rd",
      AppStrings.urbanFreshGrocery: 'Urban Fresh Grocery',
      AppStrings.privateResidence: 'Private Residence, SW1 4XY',
      AppStrings.mainDistributionCenter:
          'Main Distribution Center, East Wing 4',
      AppStrings.urbanHeightsResidence: 'Urban Heights Residency, Unit 402',
      AppStrings.evergreenTerrace: '742 Evergreen Terrace, Springfield',
      AppStrings.industrialWay: '123 Industrial Way, Shelbyville',
      AppStrings.tomorrow0900: 'Tomorrow, 09:00 AM',
      AppStrings.october26Schedule: 'Oct 26, 10:00 AM',
      AppStrings.october12Date: 'Oct 12, 2023 • 14:30',
      AppStrings.bookingDetails: 'Booking Details',
      AppStrings.orderStatus: 'Order Status',
      AppStrings.inTransit: 'In Transit',
      AppStrings.recipientDetailTitle: 'Recipient Detail',
      AppStrings.customerNameValue: 'Mohamed Rashid',
      AppStrings.customerPhoneValue: '(+971) 50 123 4567',
      AppStrings.packagePhoto: 'Product Image',
      AppStrings.bookingPickupAddress:
          'Warehouse 4, Al Quoz Industrial Area 3, Dubai',
      AppStrings.bookingDropoffAddress:
          'Burjuman Tower, Office 1204, Bur Dubai',
      AppStrings.bookingDateValue: '24 Oct 2023',
      AppStrings.bookingTimeValue: '10:30 AM - 12:00 PM',
      AppStrings.packageInstructionsValue:
          '“Fragile item inside. Please handle with care and do not stack other boxes on top. Call the customer upon arrival.”',
      AppStrings.deliveryCharges: 'Delivery Charges',
      AppStrings.delivery: 'Delivery',
      AppStrings.deliveryPrice: 'OMR 25.00',
      AppStrings.driverDetails: 'Driver Details',
      AppStrings.driverName: 'Alex Johnson',
      AppStrings.driverVehicle: 'Delivery Van - Plate XYZ 123',
      AppStrings.callDriver: 'Call Driver',
      AppStrings.trackDelivery: 'Track Delivery',
      AppStrings.currentStatus: 'Current Status',
      AppStrings.headingToPickup: 'Heading to Pickup',
      AppStrings.driverOnTheWay: 'Driver is on the way',
      AppStrings.estimatedArrival: 'Estimated Arrival',
      AppStrings.fiveMinutesAway: '5 min away',
      AppStrings.trackedDriverName: 'Alex',
      AppStrings.trackedDriverStats: '4.9     •     1,200+ Deliveries',
      AppStrings.trackedVehicle: 'White Electric Scooter • XYZ 8821',
      AppStrings.viewOrderDetails: 'View Order Details',
      AppStrings.pickupShort: "Pickup: Mutter's Bakery",
      AppStrings.customerShort: 'Customer: David L.',
      AppStrings.driverShort: 'Driver: Sarah K.',
      AppStrings.orderDeliveredSuccessfully: 'Order Delivered Successfully',
      AppStrings.packageDeliveredSafely:
          'Your package has been safely delivered!',
      AppStrings.timeOfDelivery: 'TIME OF DELIVERY',
      AppStrings.deliveredTime: 'Oct 24, 2:45 PM',
      AppStrings.deliveryLocation: 'DELIVERY LOCATION',
      AppStrings.deliveredLocation:
          '4517 Washington Ave. Manchester, Kentucky 39495',
      AppStrings.backToHome: 'Back to Home',
      AppStrings.rateDelivery: 'Rate Delivery',
      AppStrings.deliveryDate: 'Delivery Date',
      AppStrings.ratingDeliveryDate: 'Oct 24, 2023 • 2:45 PM',
      AppStrings.howWasDelivery: 'How was your delivery?',
      AppStrings.ratingDescription:
          'Your feedback helps us improve our service for everyone.',
      AppStrings.whatWentWell: 'What went well?',
      AppStrings.onTime: 'On Time',
      AppStrings.friendlyDriver: 'Friendly Driver',
      AppStrings.packageSafe: 'Package Safe',
      AppStrings.greatService: 'Great Service',
      AppStrings.goodUpdates: 'Good Updates',
      AppStrings.tellMoreExperience: 'Tell us more about your experience',
      AppStrings.reviewHint:
          'Optional: Mention any specific highlights or areas for improvement...',
      AppStrings.submitReview: 'Submit Review',
      AppStrings.driverReviews: 'Driver Reviews',
      AppStrings.reviewsTotal: '128 reviews total',
      AppStrings.latestReviews: 'LATEST REVIEWS',
      AppStrings.mostRecent: 'Most Recent',
      AppStrings.reviewerSarah: 'Sarah W.',
      AppStrings.reviewerMark: 'Mark R.',
      AppStrings.reviewerJames: 'James L.',
      AppStrings.twoDaysAgoReview: '2 days ago',
      AppStrings.oneWeekAgo: '1 week ago',
      AppStrings.twoWeeksAgo: '2 weeks ago',
      AppStrings.reviewOne:
          'Very professional and arrived on time! Alex was incredibly helpful and ensured my fragile items were secured correctly in the vehicle. Highly recommended!',
      AppStrings.reviewTwo:
          'Great service, handled the package with care. Communication was perfect from pickup to drop-off.',
      AppStrings.reviewThree:
          'Quick delivery and very polite driver. Alex made the whole process stress-free.',
      AppStrings.loadMoreReviews: 'Load More Reviews',
      AppStrings.updateInformation: 'Update Information',
      AppStrings.editProfile: 'Edit Profile',
      AppStrings.changeProfilePhoto: 'Change Profile Photo',
      AppStrings.emailAddress: 'Email Address',
      AppStrings.saveChanges: 'Save Changes',
      AppStrings.appSettings: 'App Settings',
      AppStrings.appSettingsDescription: 'Configure your store experience',
      AppStrings.preferences: 'Preferences',
      AppStrings.notifications: 'Notifications',
      AppStrings.legalAndSupport: 'Legal & Support',
      AppStrings.changeLanguage: 'Change Language',
      AppStrings.privacyPolicies: 'Privacy Policies',
      AppStrings.contactUs: 'Contact Us',
      AppStrings.accountActions: 'Account Actions',
      AppStrings.logout: 'Logout',
      AppStrings.deleteAccount: 'Delete Account',
      AppStrings.appVersion: 'F.N.D Store v2.4.0',
      AppStrings.managedBy: 'Managed by Logistics Core Systems',
      AppStrings.privacyPolicyTitle: 'Privacy Policies',
      AppStrings.lastUpdated: 'Last updated: October 24, 2023',
      AppStrings.privacyNotice:
          'Please read these privacy policies carefully before using the '
          'F.N.D Store logistics platform operated by Delivery Pro. Your '
          'access to and use of the service is conditioned on your acceptance '
          'of and compliance with these policies.',
      AppStrings.termsNotice:
          'Please read these terms and conditions carefully before using the '
          'F.N.D Store logistics platform operated by Delivery Pro. Your '
          'access to and use of the service is conditioned on your acceptance '
          'of and compliance with these terms.',
      AppStrings.introduction: '1. Introduction',
      AppStrings.introductionBody:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim '
          'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut '
          'aliquip ex ea commodo consequat. Duis aute irure dolor in '
          'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
          'pariatur.\n\nExcepturi sint occaecat cupidatat non proident, sunt in '
          'culpa qui officia deserunt mollit anim id est laborum. Curabitur '
          'pretium tincidunt lacus. Nulla gravida orci a odio.',
      AppStrings.responsibilities: '2. User Responsibilities',
      AppStrings.responsibilitiesBody:
          'Integer vitae justo eget magna fermentum iaculis eu non diam. '
          'Phasellus vestibulum lorem sed risus ultricies tristique nulla. '
          'Donec ac odio tempor orci dapibus ultrices in iaculis nunc.',
      AppStrings.responsibilityOne:
          'Users must maintain valid identification for all logistics operations.',
      AppStrings.responsibilityTwo:
          'Account security is the sole responsibility of the merchant.',
      AppStrings.responsibilityThree:
          'Delivery Pro reserves the right to terminate access for misuse.',
      AppStrings.cmsPrivacySection: '3. Privacy Policy',
      AppStrings.cmsPrivacyBody:
          'Morbi tristique senectus et netus et malesuada fames ac turpis '
          'egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, '
          'tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. '
          'Aenean ultricies mi vitae est. Mauris placerat eleifend leo.\n\n'
          'Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat '
          'wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean '
          'fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, '
          'sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar '
          'facilisis. Ut felis.',
      AppStrings.logisticsAndDelivery: '4. Logistics & Delivery',
      AppStrings.logisticsAndDeliveryBody:
          'Praesent dapibus, neque id cursus faucibus, tortor neque egestas '
          'augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam '
          'dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus. '
          'Phasellus ultrices nulla quis nibh. Quisque a lectus.',
      AppStrings.termination: '5. Termination',
      AppStrings.terminationBody:
          'Pellentesque habitant morbi tristique senectus et netus et '
          'malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat '
          'vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit '
          'amet quam egestas semper. Aenean ultricies mi vitae est. Mauris '
          'placerat eleifend leo. Quisque sit amet est et sapien ullamcorper '
          'pharetra.',
      AppStrings.name: 'Name',
      AppStrings.fullNameHint: 'Enter your full name',
      AppStrings.emailAddressHint: 'Enter your email address',
      AppStrings.description: 'Description',
      AppStrings.helpHint: 'How can we help you?',
      AppStrings.callSupport: 'Call Support',
      AppStrings.supportPhone: '+1 (800) 555-LOGI',
      AppStrings.submit: 'Submit',
      AppStrings.logoutConfirmation: 'Are you sure you want to\nlogout?',
      AppStrings.logoutDescription:
          'You will need to sign in again to\nmanage your deliveries and access\nyour account details.',
      AppStrings.yesLogout: 'Yes, Logout',
      AppStrings.staySignedIn: 'No, Stay Signed In',
      AppStrings.deleteConfirmation:
          'Are you sure you want to\ndelete your account?',
      AppStrings.deleteDescription:
          'This will permanently delete your\naccount details and delivery data.\nThis action cannot be undone.',
      AppStrings.yesDelete: 'Yes, Delete Account',
      AppStrings.keepAccount: 'No, Keep My Account',
      AppStrings.uploadStoreImage: 'Upload Store Image',
      AppStrings.editStoreDetails: 'Edit Store Details',
      AppStrings.notificationsDescription:
          'Stay updated with your latest\nactivities',
      AppStrings.markAllAsRead: 'Mark all as\nread',
      AppStrings.deliveryUpdate: 'Delivery Update',
      AppStrings.deliveryUpdateDescription:
          'Order #FND-8821 has been successfully delivered to the customer.',
      AppStrings.newOrderAlert: 'New Order Alert',
      AppStrings.newOrderDescription:
          'A new delivery request is ready for assignment to a driver.',
      AppStrings.systemUpdate: 'System Update',
      AppStrings.systemUpdateDescription:
          'A new version of F.N.D Store is available with improved delivery tracking.',
      AppStrings.routeOptimized: 'Route Optimized',
      AppStrings.routeOptimizedDescription:
          'The delivery route has been optimized and the travel time reduced.',
      AppStrings.paymentReceived: 'Payment Received',
      AppStrings.paymentReceivedDescription:
          'Payment for order #FND-9042 has been received successfully.',
      AppStrings.twoMinutesAgo: '2 mins ago',
      AppStrings.oneHourAgo: '1 hour ago',
      AppStrings.threeHoursAgo: '3 hours ago',
      AppStrings.yesterday: 'Yesterday',
      AppStrings.twoDaysAgo: '2 days ago',
    },
    'ar_AE': {
      AppStrings.appName: 'متجر F.N.D',
      AppStrings.selectLanguage: 'اختر اللغة',
      AppStrings.english: 'الإنجليزية',
      AppStrings.arabic: 'العربية',
      AppStrings.arabicSymbol: 'ض',
      AppStrings.continueText: 'متابعة',
      AppStrings.onboardingWelcome: 'مرحبًا بك في متجر F.N.D',
      AppStrings.onboardingDescription:
          'لوريم إيبسوم هو نص شكلي يُستخدم في صناعات الطباعة\n'
          'والتنضيد.',
      AppStrings.skip: 'تخطي',
      AppStrings.next: 'التالي',
      AppStrings.back: 'رجوع',
      AppStrings.getStarted: 'ابدأ الآن',
      AppStrings.selectCountry: 'اختر الدولة',
      AppStrings.searchCountry: 'ابحث عن دولة',
      AppStrings.error: 'خطأ',
      AppStrings.completeProfile: 'أكمل الملف الشخصي',
      AppStrings.addProfilePhotoOptional: 'أضف صورة شخصية (اختياري)',
      AppStrings.chooseFromLibrary: 'اختر من مكتبة الصور',
      AppStrings.takePhoto: 'التقط صورة',
      AppStrings.cancel: 'إلغاء',
      AppStrings.firstName: 'الاسم الأول',
      AppStrings.firstNameHint: 'ميلي',
      AppStrings.lastName: 'اسم العائلة',
      AppStrings.lastNameHint: 'ديو',
      AppStrings.email: 'البريد الإلكتروني',
      AppStrings.emailHint: 'milydeo123@gmail.com',
      AppStrings.phoneNumber: 'رقم الهاتف',
      AppStrings.phoneHint: '50 000 0000',
      AppStrings.agreeWith: 'أوافق على ',
      AppStrings.termsAndConditions: 'الشروط والأحكام.',
      AppStrings.alreadyHaveAccount: 'لديك حساب بالفعل؟ ',
      AppStrings.signIn: 'تسجيل الدخول',
      AppStrings.loginPhoneTitle: 'رقم الهاتف',
      AppStrings.loginPhoneDescription:
          'يرجى إدخال رقم هاتف صالح. سنرسل إليك\n'
          'رمزًا مكونًا من 4 أرقام للتحقق من حسابك.',
      AppStrings.phonePrivacyNote: 'لن نشارك رقمك مطلقًا',
      AppStrings.loginPhoneHint: '1234567890',
      AppStrings.orContinueWith: 'أو تابع باستخدام',
      AppStrings.dontHaveAccount: 'ليس لديك حساب؟ ',
      AppStrings.signUp: 'إنشاء حساب',
      AppStrings.verificationCode: 'رمز التحقق',
      AppStrings.verificationDescription: 'اكتب رمز التحقق\nالذي أرسلناه إليك',
      AppStrings.resendIn: 'إعادة الإرسال خلال',
      AppStrings.resendCode: 'إعادة إرسال الرمز',
      AppStrings.storeDetails: 'تفاصيل المتجر',
      AppStrings.storeName: 'اسم المتجر',
      AppStrings.storeNameHint: 'F.N.D أونلاين',
      AppStrings.storeLocation: 'موقع المتجر',
      AppStrings.storeLocationHint: 'دبي، الإمارات',
      AppStrings.accountCreated: 'تم إنشاء الحساب',
      AppStrings.accountCreatedDescription: 'تم إنشاء حسابك\nبنجاح.',
      AppStrings.home: 'الرئيسية',
      AppStrings.bookings: 'الحجوزات',
      AppStrings.profile: 'الملف الشخصي',
      AppStrings.settings: 'الإعدادات',
      AppStrings.homeGreeting: 'مرحبًا، مارك! 👋',
      AppStrings.happyCollecting: 'جمعًا سعيدًا!',
      AppStrings.noDeliveryRequests: 'لا توجد طلبات توصيل بعد!',
      AppStrings.noDeliveryRequestsDescription:
          'لم تنشئ أي طلبات توصيل اليوم. ابدأ\n'
          'بإنشاء طلب جديد وتعيينه إلى سائق.',
      AppStrings.createRequest: 'إنشاء طلب',
      AppStrings.recipientDetail: 'تفاصيل المستلم',
      AppStrings.customerName: 'اسم العميل',
      AppStrings.enter: 'أدخل',
      AppStrings.packageDetails: 'تفاصيل الطرد',
      AppStrings.productImage: 'صورة المنتج',
      AppStrings.upload: 'رفع',
      AppStrings.pickupLocation: 'موقع الاستلام',
      AppStrings.dropoffLocation: 'موقع التسليم',
      AppStrings.enterLocation: 'أدخل الموقع',
      AppStrings.date: 'التاريخ',
      AppStrings.time: 'الوقت',
      AppStrings.select: 'اختر',
      AppStrings.packageInstructions: 'تعليمات الطرد',
      AppStrings.enterHere: 'أدخل هنا...',
      AppStrings.create: 'إنشاء',
      AppStrings.totalDelivered: 'إجمالي التوصيلات',
      AppStrings.todaysBookings: 'حجوزات اليوم',
      AppStrings.viewAll: 'عرض الكل',
      AppStrings.orderId: 'رقم الطلب',
      AppStrings.orderPickedUp: 'تم استلام الطلب',
      AppStrings.driverOnWay: 'السائق في الطريق',
      AppStrings.pickup: 'الاستلام',
      AppStrings.dropoff: 'التسليم',
      AppStrings.downtownHub: 'مركز وسط المدينة',
      AppStrings.westsideTerminal: 'محطة ويست سايد',
      AppStrings.eastPort: 'الميناء الشرقي',
      AppStrings.centralStorage: 'المخزن المركزي',
      AppStrings.today1430: 'اليوم، 14:30',
      AppStrings.today1615: 'اليوم، 16:15',
      AppStrings.track: 'تتبع',
      AppStrings.ongoing: 'جارية',
      AppStrings.upcoming: 'قادمة',
      AppStrings.completed: 'مكتملة',
      AppStrings.schedule: 'الموعد',
      AppStrings.details: 'التفاصيل',
      AppStrings.delivered: 'تم التوصيل',
      AppStrings.centralLogisticsHub: 'مركز الخدمات اللوجستية، البوابة 4',
      AppStrings.bakerStreet: '122 شارع بيكر، مارليبون',
      AppStrings.docklandsWarehouse: 'مستودع دوكلاندز أ',
      AppStrings.regentsPark: '77 طريق ريجنت بارك',
      AppStrings.urbanFreshGrocery: 'بقالة أوربان فريش',
      AppStrings.privateResidence: 'سكن خاص، SW1 4XY',
      AppStrings.mainDistributionCenter:
          'مركز التوزيع الرئيسي، الجناح الشرقي 4',
      AppStrings.urbanHeightsResidence: 'أوربان هايتس، الوحدة 402',
      AppStrings.evergreenTerrace: '742 إيفرغرين تيراس، سبرينغفيلد',
      AppStrings.industrialWay: '123 إندستريال واي، شيلبيفيل',
      AppStrings.tomorrow0900: 'غدًا، 09:00 صباحًا',
      AppStrings.october26Schedule: '26 أكتوبر، 10:00 صباحًا',
      AppStrings.october12Date: '12 أكتوبر 2023 • 14:30',
      AppStrings.bookingDetails: 'تفاصيل الحجز',
      AppStrings.orderStatus: 'حالة الطلب',
      AppStrings.inTransit: 'قيد التوصيل',
      AppStrings.recipientDetailTitle: 'تفاصيل المستلم',
      AppStrings.customerNameValue: 'محمد راشد',
      AppStrings.customerPhoneValue: '(+971) 50 123 4567',
      AppStrings.packagePhoto: 'صورة المنتج',
      AppStrings.bookingPickupAddress:
          'المستودع 4، منطقة القوز الصناعية 3، دبي',
      AppStrings.bookingDropoffAddress: 'برجمان تاور، مكتب 1204، بر دبي',
      AppStrings.bookingDateValue: '24 أكتوبر 2023',
      AppStrings.bookingTimeValue: '10:30 صباحًا - 12:00 ظهرًا',
      AppStrings.packageInstructionsValue:
          'عنصر قابل للكسر. يرجى التعامل معه بعناية وعدم وضع صناديق أخرى فوقه. اتصل بالعميل عند الوصول.',
      AppStrings.deliveryCharges: 'رسوم التوصيل',
      AppStrings.delivery: 'التوصيل',
      AppStrings.deliveryPrice: '25.00 ر.ع',
      AppStrings.driverDetails: 'تفاصيل السائق',
      AppStrings.driverName: 'أليكس جونسون',
      AppStrings.driverVehicle: 'شاحنة توصيل - اللوحة XYZ 123',
      AppStrings.callDriver: 'اتصل بالسائق',
      AppStrings.trackDelivery: 'تتبع التوصيل',
      AppStrings.currentStatus: 'الحالة الحالية',
      AppStrings.headingToPickup: 'في الطريق إلى الاستلام',
      AppStrings.driverOnTheWay: 'السائق في الطريق',
      AppStrings.estimatedArrival: 'الوصول المتوقع',
      AppStrings.fiveMinutesAway: 'خلال 5 دقائق',
      AppStrings.trackedDriverName: 'أليكس',
      AppStrings.trackedDriverStats: '4.9     •     أكثر من 1,200 توصيل',
      AppStrings.trackedVehicle: 'دراجة كهربائية بيضاء • XYZ 8821',
      AppStrings.viewOrderDetails: 'عرض تفاصيل الطلب',
      AppStrings.pickupShort: 'الاستلام: مخبز ماتر',
      AppStrings.customerShort: 'العميل: ديفيد ل.',
      AppStrings.driverShort: 'السائق: سارة ك.',
      AppStrings.orderDeliveredSuccessfully: 'تم توصيل الطلب بنجاح',
      AppStrings.packageDeliveredSafely: 'تم توصيل طردك بأمان!',
      AppStrings.timeOfDelivery: 'وقت التوصيل',
      AppStrings.deliveredTime: '24 أكتوبر، 2:45 مساءً',
      AppStrings.deliveryLocation: 'موقع التوصيل',
      AppStrings.deliveredLocation: '4517 واشنطن أفينيو، مانشستر، كنتاكي 39495',
      AppStrings.backToHome: 'العودة إلى الرئيسية',
      AppStrings.rateDelivery: 'تقييم التوصيل',
      AppStrings.deliveryDate: 'تاريخ التوصيل',
      AppStrings.ratingDeliveryDate: '24 أكتوبر 2023 • 2:45 مساءً',
      AppStrings.howWasDelivery: 'كيف كانت عملية التوصيل؟',
      AppStrings.ratingDescription: 'تساعدنا ملاحظاتك على تحسين خدمتنا للجميع.',
      AppStrings.whatWentWell: 'ما الذي سار بشكل جيد؟',
      AppStrings.onTime: 'في الموعد',
      AppStrings.friendlyDriver: 'سائق ودود',
      AppStrings.packageSafe: 'الطرد آمن',
      AppStrings.greatService: 'خدمة رائعة',
      AppStrings.goodUpdates: 'تحديثات جيدة',
      AppStrings.tellMoreExperience: 'أخبرنا المزيد عن تجربتك',
      AppStrings.reviewHint:
          'اختياري: اذكر أي نقاط مميزة أو جوانب تحتاج إلى تحسين...',
      AppStrings.submitReview: 'إرسال التقييم',
      AppStrings.driverReviews: 'تقييمات السائق',
      AppStrings.reviewsTotal: 'إجمالي 128 تقييمًا',
      AppStrings.latestReviews: 'أحدث التقييمات',
      AppStrings.mostRecent: 'الأحدث',
      AppStrings.reviewerSarah: 'سارة و.',
      AppStrings.reviewerMark: 'مارك ر.',
      AppStrings.reviewerJames: 'جيمس ل.',
      AppStrings.twoDaysAgoReview: 'منذ يومين',
      AppStrings.oneWeekAgo: 'منذ أسبوع',
      AppStrings.twoWeeksAgo: 'منذ أسبوعين',
      AppStrings.reviewOne:
          'محترف للغاية ووصل في الموعد! كان أليكس متعاونًا وتأكد من تثبيت الأغراض القابلة للكسر بشكل صحيح. أوصي به بشدة!',
      AppStrings.reviewTwo:
          'خدمة رائعة وتعامل مع الطرد بعناية. كان التواصل ممتازًا من الاستلام حتى التسليم.',
      AppStrings.reviewThree:
          'توصيل سريع وسائق مهذب جدًا. جعل أليكس العملية كلها سهلة ومريحة.',
      AppStrings.loadMoreReviews: 'تحميل المزيد من التقييمات',
      AppStrings.updateInformation: 'تحديث المعلومات',
      AppStrings.editProfile: 'تعديل الملف الشخصي',
      AppStrings.changeProfilePhoto: 'تغيير صورة الملف الشخصي',
      AppStrings.emailAddress: 'عنوان البريد الإلكتروني',
      AppStrings.saveChanges: 'حفظ التغييرات',
      AppStrings.appSettings: 'إعدادات التطبيق',
      AppStrings.appSettingsDescription: 'خصّص تجربة متجرك',
      AppStrings.preferences: 'التفضيلات',
      AppStrings.notifications: 'الإشعارات',
      AppStrings.legalAndSupport: 'القانون والدعم',
      AppStrings.changeLanguage: 'تغيير اللغة',
      AppStrings.privacyPolicies: 'سياسات الخصوصية',
      AppStrings.contactUs: 'اتصل بنا',
      AppStrings.accountActions: 'إجراءات الحساب',
      AppStrings.logout: 'تسجيل الخروج',
      AppStrings.deleteAccount: 'حذف الحساب',
      AppStrings.appVersion: 'متجر F.N.D إصدار 2.4.0',
      AppStrings.managedBy: 'بإدارة أنظمة الخدمات اللوجستية الأساسية',
      AppStrings.privacyPolicyTitle: 'سياسات الخصوصية',
      AppStrings.lastUpdated: 'آخر تحديث: 24 أكتوبر 2023',
      AppStrings.privacyNotice:
          'يرجى قراءة سياسات الخصوصية هذه بعناية قبل استخدام منصة الخدمات '
          'اللوجستية لمتجر F.N.D. يخضع استخدامك للخدمة لقبول هذه السياسات '
          'والالتزام بها.',
      AppStrings.termsNotice:
          'يرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام منصة الخدمات '
          'اللوجستية لمتجر F.N.D. يخضع استخدامك للخدمة لقبول هذه الشروط '
          'والالتزام بها.',
      AppStrings.introduction: '1. المقدمة',
      AppStrings.introductionBody:
          'هذا نص توضيحي لسياسة استخدام المنصة والخدمات المقدمة. يوضح هذا '
          'القسم نطاق الخدمة وكيفية التعامل مع المعلومات والطلبات والالتزامات '
          'المرتبطة باستخدام التطبيق.\n\nيجب على المستخدم قراءة المعلومات '
          'بعناية والالتزام بجميع المتطلبات المعمول بها.',
      AppStrings.responsibilities: '2. مسؤوليات المستخدم',
      AppStrings.responsibilitiesBody:
          'يتحمل المستخدم مسؤولية صحة المعلومات المقدمة والمحافظة على أمان '
          'الحساب واستخدام المنصة وفق الأنظمة والتعليمات.',
      AppStrings.responsibilityOne:
          'يجب توفير هوية صالحة لجميع العمليات اللوجستية.',
      AppStrings.responsibilityTwo: 'أمان الحساب مسؤولية المستخدم وحده.',
      AppStrings.responsibilityThree:
          'يحق للمنصة إنهاء الوصول عند إساءة الاستخدام.',
      AppStrings.cmsPrivacySection: '3. سياسة الخصوصية',
      AppStrings.cmsPrivacyBody:
          'نلتزم بحماية معلومات المستخدم وبياناته الشخصية، ومعالجتها وفق '
          'الأنظمة المعمول بها. لا تُستخدم البيانات إلا لتقديم الخدمات '
          'وتحسين تجربة المنصة ودعم العمليات اللوجستية.\n\n'
          'يجب المحافظة على سرية المعلومات وعدم مشاركتها إلا ضمن نطاق '
          'الخدمة أو عندما تتطلب الأنظمة ذلك.',
      AppStrings.logisticsAndDelivery: '4. الخدمات اللوجستية والتوصيل',
      AppStrings.logisticsAndDeliveryBody:
          'تُنفذ عمليات الاستلام والتوصيل وفق التفاصيل المقدمة في الطلب. '
          'يتحمل المستخدم مسؤولية صحة العناوين والمواعيد والتعليمات المتعلقة '
          'بالشحنة.',
      AppStrings.termination: '5. إنهاء الاستخدام',
      AppStrings.terminationBody:
          'يجوز تعليق الحساب أو إنهاء الوصول إلى المنصة عند مخالفة الشروط أو '
          'إساءة استخدام الخدمات. تبقى الالتزامات السابقة للإنهاء سارية وفق '
          'الأنظمة المعمول بها.',
      AppStrings.name: 'الاسم',
      AppStrings.fullNameHint: 'أدخل اسمك الكامل',
      AppStrings.emailAddressHint: 'أدخل بريدك الإلكتروني',
      AppStrings.description: 'الوصف',
      AppStrings.helpHint: 'كيف يمكننا مساعدتك؟',
      AppStrings.callSupport: 'اتصل بالدعم',
      AppStrings.supportPhone: '+1 (800) 555-LOGI',
      AppStrings.submit: 'إرسال',
      AppStrings.logoutConfirmation: 'هل أنت متأكد أنك تريد\nتسجيل الخروج؟',
      AppStrings.logoutDescription:
          'ستحتاج إلى تسجيل الدخول مرة أخرى\nلإدارة عمليات التوصيل والوصول\nإلى تفاصيل حسابك.',
      AppStrings.yesLogout: 'نعم، تسجيل الخروج',
      AppStrings.staySignedIn: 'لا، ابقَ مسجلاً',
      AppStrings.deleteConfirmation: 'هل أنت متأكد أنك تريد\nحذف حسابك؟',
      AppStrings.deleteDescription:
          'سيؤدي هذا إلى حذف تفاصيل حسابك\nوبيانات التوصيل نهائيًا.\nلا يمكن التراجع عن هذا الإجراء.',
      AppStrings.yesDelete: 'نعم، حذف الحساب',
      AppStrings.keepAccount: 'لا، احتفظ بحسابي',
      AppStrings.uploadStoreImage: 'رفع صورة المتجر',
      AppStrings.editStoreDetails: 'تعديل تفاصيل المتجر',
      AppStrings.notificationsDescription: 'ابقَ على اطلاع بأحدث\nأنشطتك',
      AppStrings.markAllAsRead: 'تحديد الكل\nكمقروء',
      AppStrings.deliveryUpdate: 'تحديث التوصيل',
      AppStrings.deliveryUpdateDescription:
          'تم توصيل الطلب #FND-8821 إلى العميل بنجاح.',
      AppStrings.newOrderAlert: 'تنبيه طلب جديد',
      AppStrings.newOrderDescription:
          'يوجد طلب توصيل جديد جاهز للتعيين إلى أحد السائقين.',
      AppStrings.systemUpdate: 'تحديث النظام',
      AppStrings.systemUpdateDescription:
          'يتوفر إصدار جديد من متجر F.N.D مع تحسينات لتتبع التوصيل.',
      AppStrings.routeOptimized: 'تم تحسين المسار',
      AppStrings.routeOptimizedDescription:
          'تم تحسين مسار التوصيل وتقليل وقت الرحلة.',
      AppStrings.paymentReceived: 'تم استلام الدفعة',
      AppStrings.paymentReceivedDescription:
          'تم استلام دفعة الطلب #FND-9042 بنجاح.',
      AppStrings.twoMinutesAgo: 'منذ دقيقتين',
      AppStrings.oneHourAgo: 'منذ ساعة',
      AppStrings.threeHoursAgo: 'منذ 3 ساعات',
      AppStrings.yesterday: 'أمس',
      AppStrings.twoDaysAgo: 'منذ يومين',
    },
  };
}
