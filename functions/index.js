const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const fcm = admin.messaging();


var msgData;

// exports.offerTrigger = functions.firestore.document('confirmedOrders/{id}').onCreate((snapshot, context) => {
//     msgData = snapshot.data();

//     return fcm.sendToTopic('confirmedOrders', {
//         notification: {title: snapshot.data().name, body: 'order has been placed',clickAction: 'FLUTTER_NOTIFICATION_CLICK'}
//     });

// });

exports.adminOrderTrigger = functions.firestore.document('confirmedOrders/{id}').onCreate((snapshot, context) => {
    var tokens = [
        'd7cf7_GgXCg:APA91bF-HqKMwlAfTsy3dRv_LVuvxkDbiBOWkBMWHweu6X8wvq_9Zw7x8ws2qSepPOk1dypxySmiv-6ct72Pbzwu6nOejFCcTEy17-_k8EmvOEMvcS2BGP-ToNAqsfF9m_EbPG4jdlhu',
        'dtG7Gozeq5M:APA91bHAblBNNNJnPn9EY0DWqVLbTnT8jvZNctTDxLVI9QkYU7T0BJP_U8j_pjdRu0LYeNGYtDUHzPN22cmB1cT0z95Z1Y8NDHsJD8wuWHfPax68nwYa4OmgG4Ky6i5KjaHca7-AnWdc'

    ];
    return fcm.sendToDevice(tokens, {
        notification: {
            title: 'New Order',
            body: 'New order has been placed', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        } 
    })
});


exports.adminBookingTrigger = functions.firestore.document('BookingDetails/{id}').onCreate((snapshot, context) => {
    var tokens = [
        'dtG7Gozeq5M:APA91bHAblBNNNJnPn9EY0DWqVLbTnT8jvZNctTDxLVI9QkYU7T0BJP_U8j_pjdRu0LYeNGYtDUHzPN22cmB1cT0z95Z1Y8NDHsJD8wuWHfPax68nwYa4OmgG4Ky6i5KjaHca7-AnWdc',
        'd7cf7_GgXCg:APA91bF-HqKMwlAfTsy3dRv_LVuvxkDbiBOWkBMWHweu6X8wvq_9Zw7x8ws2qSepPOk1dypxySmiv-6ct72Pbzwu6nOejFCcTEy17-_k8EmvOEMvcS2BGP-ToNAqsfF9m_EbPG4jdlhu'
    ];
    return fcm.sendToDevice(tokens, {
        notification: {
            title: 'New Booking',
            body: 'New booking request sent', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        } 
    })
});

exports.confirmNotification = functions.firestore.document('confirmedOrders/{id}').onUpdate((snapshot, context) => {
    var token = snapshot.after.data().token;
    return fcm.sendToDevice(token, {
        notification: {
            title: 'Order Confirmation',
            body: 'Your order has been confirmed',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    })
});


exports.BookingNotification = functions.firestore.document('BookingDetails/{id}').onUpdate((snapshot, context) => {
    var token = snapshot.after.data().token;
    return fcm.sendToDevice(token, {
        notification: {
            title: 'Booking Confirmation',
            body: 'Your Booking has been confirmed',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    })
});
