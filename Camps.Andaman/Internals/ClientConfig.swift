//
//  ClientConfig.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 20/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import Foundation

struct ClientConfig {

    static let BASE_URL = "https://camps.goexploreandaman.com/"
    static  let Imgae_Url = "https://camps.goexploreandaman.com/assets/images/photo/"
    static  let Activity_ImgUrl = "https://camps.goexploreandaman.com/assets/img/Activites/"
    static  let Gesture_ImgUrl = "https://camps.goexploreandaman.com/assets/img/gesture/"
    static let CampingImgUrl = "https://camps.goexploreandaman.com/assets/img/camping/"
    static var membersImgUrl = "https://camps.goexploreandaman.com/assets/img/"
    static var offerIMGUrl = "https://camps.goexploreandaman.com/assets/img/offers/"
}

struct ClientInterface {
    
    static let sendOTPUrl = "https://andamancamp.herokuapp.com/start"
    static let verifyOTPUrl = "https://andamancamp.herokuapp.com/verify"
    
    static let campingUrl = ClientConfig.BASE_URL + "camping_api"
    static let packagesUrl = ClientConfig.BASE_URL + "packages_api"
    static let gesturesUrl = ClientConfig.BASE_URL + "gesture_api"
    static let itineraryUrl = ClientConfig.BASE_URL + "Itinerary_api"
    static let activitiesUrl = ClientConfig.BASE_URL + "activities_api"
    static let registrationUrl = ClientConfig.BASE_URL + "register_auth_api"
    static let loginUrl = ClientConfig.BASE_URL + "login_auth_api"
    static let forgotPasswordUrl = ClientConfig.BASE_URL + "forgot_password_api"
    static let changePasswordUrl = ClientConfig.BASE_URL + "change_password_api"
    static let bookingUrl = ClientConfig.BASE_URL + "camp_booking_api"
//    static let mybookingsUrl = ClientConfig.BASE_URL + "camp_booking_api/" + "1"
    static var subscriptionUrl = ClientConfig.BASE_URL + "subscriber_api"
    static var razorPayUrl = "https://camps.goexploreandaman.com/Razor_payment_api"
    static var membersUrl = ClientConfig.BASE_URL + "member_api"
    static var profileUrl = ClientInterface.registrationUrl
    static var offersUrl = ClientConfig.BASE_URL + "promo_code_api"
}
