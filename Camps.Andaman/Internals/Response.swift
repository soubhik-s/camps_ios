//
//  Response.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 20/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import Foundation


//Mark: - OTP Response

struct OTPResponse:Decodable {
    let success:Bool
    let message:String
}



// MARK: - PackageResponseElement

typealias PackageResponse = [PackageResponseObj]

struct PackageResponseObj:Decodable {
    let package_id:String
    let package_season_name:String
    let package_title:String
    let package_price:String
    let package_description:String
    let package_image_name:String
    let age_group:String
    let packages_terms_n_conditions_link:String
    let user_type:String

    
}

// MARK: - Itenararyresponse
// MARK: - ItineraryResponseElement
//struct ItineraryResponseElement: Codable {
//    let itineraryID, seasonName: String
//    let ageGroup: String
//    let itineraryDescription: String
//    let campInclusions, campExclusions, itienaryName, morningActivity: [String]
//    let afterNoonActivity: [String]
//    let eveningActivity: [String]
//    let overNightActivity: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case itineraryID = "itinerary_id"
//        case seasonName = "season_name"
//        case ageGroup = "age_group"
//        case itineraryDescription = "itinerary_description"
//        case campInclusions = "camp_inclusions"
//        case campExclusions = "camp_exclusions"
//        case itienaryName = "itienary_name"
//        case morningActivity = "morning_activity"
//        case afterNoonActivity = "after_noon_activity"
//        case eveningActivity = "evening_activity"
//        case overNightActivity = "over_night_activity"
//    }
//}
//
//enum AgeGroup: String, Codable {
//    case adult = "adult"
//    case children = "children"
//}
//
//enum EveningActivity: String, Codable {
//    case birdingTour = "Birding Tour "
//    case bonfire = "Bonfire – "
//    case eveningActivityBonfire = "Bonfire "
//    case eveningActivityReturnToHotelBonfire = "return to Hotel – Bonfire "
//    case fluffyReturnToHotelBonfire = "Return to Hotel – Bonfire "
//    case introductionSessionWithTheBatchmatesInstructors = "Introduction session with the batchmates & Instructors "
//    case purpleBonfire = " Bonfire "
//    case purpleReturnToHotelBonfire = "return to Hotel - Bonfire "
//    case returnToHotelBonfire = "Return to Hotel Bonfire "
//}
//
//enum OverNightActivity: String, Codable {
//    case bonfireQuizNightDinnerStayAtHotel = "Bonfire – Quiz night - Dinner & Stay at Hotel  "
//    case dinnerStayAtHotel = " Dinner & Stay at Hotel "
//    case nightQuizNightDinnerStayAtHotel = "Night - Quiz night - Dinner & Stay at Hotel  "
//    case overNightActivityDinnerStayAtHotel = "Dinner & Stay at Hotel "
//    case overNightActivityQuizNightDinnerStayAtHotel = "Quiz night - Dinner & Stay at Hotel  "
//    case quizNightDinnerStayAtHotel = "Quiz night - Dinner & Stay at Hotel"
//}

// MARK: - ItineraryResponseElement
struct ItineraryResponseElement: Codable {
    let itineraryID, seasonName: String
    let ageGroup: String
    let itineraryDescription: String
    let campInclusions, campExclusions, itienaryName, morningActivity: [String]
    let afterNoonActivity, eveningActivity: [String]
    let overNightActivity: [String]

    enum CodingKeys: String, CodingKey {
        case itineraryID = "itinerary_id"
        case seasonName = "season_name"
        case ageGroup = "age_group"
        case itineraryDescription = "itinerary_description"
        case campInclusions = "camp_inclusions"
        case campExclusions = "camp_exclusions"
        case itienaryName = "itienary_name"
        case morningActivity = "morning_activity"
        case afterNoonActivity = "after_noon_activity"
        case eveningActivity = "evening_activity"
        case overNightActivity = "over_night_activity"
    }
}

enum AgeGroup: String, Codable {
    case adult = "adult"
    case children = "children"
}

enum OverNightActivity: String, Codable {
    case bonfireQuizNightDinnerStayAtHotel = "Bonfire – Quiz night - Dinner & Stay at Hotel  "
    case dinnerStayAtHotel = "Dinner & Stay at Hotel "
    case overNightActivityQuizNightDinnerStayAtHotel = "Quiz night - Dinner & Stay at Hotel  "
    case quizNightDinnerStayAtHotel = "Quiz night - Dinner & Stay at Hotel"
    case returnToHotelBonfire = "Return to Hotel Bonfire "
}

typealias ItineraryResponse = [ItineraryResponseElement]



// MARK: - CampingListResponseElement
struct CampingListResponseElement: Codable {
    let campingID, campingName, campingDescriptionFirst, campingDescriptionSecond: String
    let campingDescriptionThird, campingDescriptionFourth, campingImageLinkFirst, campingImageLinkSecond: String
    let campingImageLinkThird, campingImageLinkFourth, campingActivity, createdAt: String
    let modifiedAt, createdBy: String

    enum CodingKeys: String, CodingKey {
        case campingID = "camping_id"
        case campingName = "camping_name"
        case campingDescriptionFirst = "camping_description_first"
        case campingDescriptionSecond = "camping_description_second"
        case campingDescriptionThird = "camping_description_third"
        case campingDescriptionFourth = "camping_description_fourth"
        case campingImageLinkFirst = "camping_image_link_first"
        case campingImageLinkSecond = "camping_image_link_second"
        case campingImageLinkThird = "camping_image_link_third"
        case campingImageLinkFourth = "camping_image_link_fourth"
        case campingActivity = "camping_activity"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case createdBy = "created_by"
    }
}

typealias CampingListResponse = [CampingListResponseElement]


// MARK: - ActivityResponseElement
struct ActivityResponseElement: Decodable {
//    let activity_name:String
//    let activity_image_link:String
    
    let  activityName, activityImageLink, activityDescription: String
    let createdAt: String
    let createdBy: CreatedBy

    enum CodingKeys: String, CodingKey {
        case activityName = "activity_name"
        case activityImageLink = "activity_image_link"
        case activityDescription = "activity_description"
        case createdAt = "created_at"
        case createdBy = "created_by"
    }
}

enum CreatedBy: String, Decodable {
    case admin = "admin"
}

typealias ActivityResponse = [ActivityResponseElement]


// MARK: - GestureResonseElement
struct GestureResonseElement: Codable {
    let gestureID, gestureName, gestureActivity, gestureDescriptionFirst: String
    let gestureDescriptionSecond, gestureDescriptionThird, gestureDescriptionFourth, gestureImageLinkFirst: String
    let gestureImageLinkSecond, gestureImageLinkThird, gestureImageLinkFourth, createdAt: String
    let modifiedAt, createdBy: String

    enum CodingKeys: String, CodingKey {
        case gestureID = "gesture_id"
        case gestureName = "gesture_name"
        case gestureActivity = "gesture_activity"
        case gestureDescriptionFirst = "gesture_description_first"
        case gestureDescriptionSecond = "gesture_description_second"
        case gestureDescriptionThird = "gesture_description_third"
        case gestureDescriptionFourth = "gesture_description_fourth"
        case gestureImageLinkFirst = "gesture_image_link_first"
        case gestureImageLinkSecond = "gesture_image_link_second"
        case gestureImageLinkThird = "gesture_image_link_third"
        case gestureImageLinkFourth = "gesture_image_link_fourth"
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case createdBy = "created_by"
    }
}

typealias GestureResonse = [GestureResonseElement]

// MARK: - SignupResponse
struct SignupResponse: Decodable {
    let status: Bool
    let  message: String

    enum CodingKeys: String, CodingKey {
        case status
//        case createdDate = "created_date"
        case message
    }
}

//MARK: LoginResponse

struct LoginResponse:Decodable {
    let status:Bool
    let message:String
    let data:LoginData
}
struct LoginData:Decodable {
    let id:String
    let user_name:String
    let first_name:String
    let last_name:String
    let user_email:String
    let mobile_number:String
    let status:String
    

    
}

// MARK: BookingResponse

struct BookingResponse:Decodable {
    let status:Bool
    let message:String
}

// MARK: - PostOfferResponse
struct PostOfferResponse: Decodable{
    let statusCode: Bool
    let status, value, discount, message: String
}

//MARK: ForgotPassword/Change Password Response

struct PasswordResponse:Decodable {
    let status:Bool
    let message:String
}

// MARK: - AboutResponseElement
struct AboutResponseElement: Codable {
    let memberID, memberType, memberTitle, memberName: String
    let memberDesignation, memberDescription, memberImageName: String
    let facebookProfileLink: String
    let linkedinProfileLink, twitterProfileLink, googleProfileLink: String
    let status, createdAt, createdBy: String

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case memberType = "member_type"
        case memberTitle = "member_title"
        case memberName = "member_name"
        case memberDesignation = "member_designation"
        case memberDescription = "member_description"
        case memberImageName = "member_image_name"
        case facebookProfileLink = "facebook_profile_link"
        case linkedinProfileLink = "linkedin_profile_link"
        case twitterProfileLink = "twitter_profile_link"
        case googleProfileLink = "google_profile_link"
        case status
        case createdAt = "created_at"
        case createdBy = "created_by"
    }
}

typealias AboutResponse = [AboutResponseElement]



struct PostBookingData {
    let packag_Id:String
    let packag_Name:String

    let user_Id:String
    let user_Name:String
    let mobile_Number:String
    let email:String
    
}

struct StatusResponse:Decodable {
    let status:Bool
    let message:String
}


typealias GetBookingResponse = [BookingResponseObj]

struct BookingResponseObj : Decodable {
let id : String?
let ip_address : String?
let user_id : String?
let verify_doc_sign_status : String?
let verify_doc_sign_link : String?
let product_id : String?
let package_name : String?
let price : String?
let quantity : String?
let season_camp : String?
let camp_batch : String?
let first_name : String?
let middle_name : String?
let last_name : String?
let dob : String?
let gender : String?
let height : String?
let weight : String?
let t_shirt_size : String?
let mother_tonque : String?
let citizenship : String?
let mobile_number : String?
let email : String?
let address : String?
let city : String?
let state : String?
let country : String?
let pincode : String?
let medical_info : String?
let medical_details : String?
let treatments : String?
let treatment_details : String?
let p_first_name : String?
let p_middle_name : String?
let p_last_name : String?
let p_mobile_number : String?
let p_alt_mobile_number : String?
let p_email : String?
let video_call : String?
let video_call_link : String?
let weekend_call : String?
let weekend_time_for_call : String?
let parent_address : String?
let p_address : String?
let p_city : String?
let p_state : String?
let p_country : String?
let p_pincode : String?
let additional_details : String?
let accept_terms_n_conditions : String?
let submitted_at : String?
let year : String?
let month : String?
let status : String?
let camp_status : String?
let voucher_name : String?
let invoice_name : String?
let total_price :String?
let siblings_info:String?
let siblings_first_name:String?
let siblings_middle_name:String?
let siblings_last_name:String?
let siblings_gender:String?
let siblings_mobile_number:String?
let siblings_email:String?

    
enum CodingKeys: String, CodingKey {

    case id = "id"
    case ip_address = "ip_address"
    case user_id = "user_id"
    case verify_doc_sign_status = "verify_doc_sign_status"
    case verify_doc_sign_link = "verify_doc_sign_link"
    case product_id = "product_id"
    case package_name = "package_name"
    case price = "price"
    case quantity = "quantity"
    case season_camp = "season_camp"
    case camp_batch = "camp_batch"
    case first_name = "first_name"
    case middle_name = "middle_name"
    case last_name = "last_name"
    case dob = "dob"
    case gender = "gender"
    case height = "height"
    case weight = "weight"
    case t_shirt_size = "t_shirt_size"
    case mother_tonque = "mother_tonque"
    case citizenship = "citizenship"
    case mobile_number = "mobile_number"
    case email = "email"
    case address = "address"
    case city = "city"
    case state = "state"
    case country = "country"
    case pincode = "pincode"
    case medical_info = "medical_info"
    case medical_details = "medical_details"
    case treatments = "treatments"
    case treatment_details = "treatment_details"
    case p_first_name = "p_first_name"
    case p_middle_name = "p_middle_name"
    case p_last_name = "p_last_name"
    case p_mobile_number = "p_mobile_number"
    case p_alt_mobile_number = "p_alt_mobile_number"
    case p_email = "p_email"
    case video_call = "video_call"
    case video_call_link = "video_call_link"
    case weekend_call = "weekend_call"
    case weekend_time_for_call = "weekend_time_for_call"
    case parent_address = "parent_address"
    case p_address = "p_address"
    case p_city = "p_city"
    case p_state = "p_state"
    case p_country = "p_country"
    case p_pincode = "p_pincode"
    case additional_details = "additional_details"
    case accept_terms_n_conditions = "accept_terms_n_conditions"
    case submitted_at = "submitted_at"
    case year = "year"
    case month = "month"
    case status = "status"
    case camp_status = "camp_status"
    case voucher_name = "voucher_name"
    case invoice_name = "invoice_name"
    case total_price = "total_price"
    
    case siblings_info = "siblings_info"
    case siblings_first_name = "siblings_first_name"
    case siblings_middle_name = "siblings_middle_name"
    case siblings_last_name = "siblings_last_name"
    case siblings_gender = "siblings_gender"
    case siblings_mobile_number = "siblings_mobile_number"
    case siblings_email = "siblings_email"
    
}

}


// MARK: - OffersResponseElement
struct OffersResponseElement: Codable {
    let id, couponName, couponCode, offersImageName: String
    let validFrom, validTo, discountOffers, discountType: String
    let url, usersRestriction, offersDetails, status: String
    let createdAt, modifiedAt, createdBy: String

    enum CodingKeys: String, CodingKey {
        case id
        case couponName = "coupon_name"
        case couponCode = "coupon_code"
        case offersImageName = "offers_image_name"
        case validFrom = "valid_from"
        case validTo = "valid_to"
        case discountOffers = "discount_offers"
        case discountType = "discount_type"
        case url
        case usersRestriction = "users_restriction"
        case offersDetails = "offers_details"
        case status
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
        case createdBy = "created_by"
    }
}

typealias OffersResponse = [OffersResponseElement]

// MARK: - BlogListResponseElement
struct BlogListResponseElement: Codable {
    let id, blogTitle: String
    let blogHeaderContent: String
    let blogDescFirst, blogDescSecond, primaryImage, secondaryImage: String
    let blogDescThird, blogDescFourth, blogDescFifth, blogDescSixth: String
    let blogDescSeventh, blogDescEighth, blogDescNinth, blogDescTenth: String
    let bloggerName: String
    let bloggerStatement: String
    let status, createdAt, modifiedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case blogTitle = "blog_title"
        case blogHeaderContent = "blog_header_content"
        case blogDescFirst = "blog_desc_first"
        case blogDescSecond = "blog_desc_second"
        case primaryImage = "primary_image"
        case secondaryImage = "secondary_image"
        case blogDescThird = "blog_desc_third"
        case blogDescFourth = "blog_desc_fourth"
        case blogDescFifth = "blog_desc_fifth"
        case blogDescSixth = "blog_desc_sixth"
        case blogDescSeventh = "blog_desc_seventh"
        case blogDescEighth = "blog_desc_eighth"
        case blogDescNinth = "blog_desc_ninth"
        case blogDescTenth = "blog_desc_tenth"
        case bloggerName = "blogger_name"
        case bloggerStatement = "blogger_statement"
        case status
        case createdAt = "created_at"
        case modifiedAt = "modified_at"
    }
}



typealias BlogListResponse = [BlogListResponseElement]

// MARK: - CommentResponseElement
struct CommentResponseElement: Codable {
    let id, userID, blogID: String
    let name: String
    let email: String
    let message, status, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case blogID = "blog_id"
        case name, email, message, status
        case createdAt = "created_at"
    }
}

enum Email: String, Codable {
    case anuC999GmailCOM = "anu.c999@gmail.com"
    case chandrabhu24GmailCOM = "chandrabhu24@gmail.com"
}

enum Name: String, Codable {
    case chandraBhushanSharma = "Chandra Bhushan Sharma"
    case pos = "pos"
}

typealias CommentResponse = [CommentResponseElement]

//struct CommentResponse:Decodable {
//    let id = ""
//    let user_id = ""
//    let blog_id = ""
//    let name = ""
//    let email = ""
//    let message = ""
//    let status = ""
//    let created_at = ""
//}
struct PostCommentResponse:Decodable {
    let status:Bool
    let message:String
}
