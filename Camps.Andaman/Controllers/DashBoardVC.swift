//
//  DashBoardVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import Razorpay
import PDFKit
import WebKit
import MobileCoreServices
class DashBoardVC: UIViewController {

    var dataArr:GetBookingResponse = []
    var camp_Arr:[String] = []
    var package_Arr:[String] = []
    var price_Arr:[String] = []
    var name_Arr:[String] = []
    var voucher_Arr:[String] = []
    var invoice_Arr:[String] = []
    var status_Arr:[String] = []
    var verified_Arr:[String] = []
    var ID_Arr:[String] = []
    var pkgID_Arr:[String] = []
    var downloadSign_Arr:[String] = []
    var signStatus_Arr:[String] = []
    var uploadSign_Arr:[String] = []
    var pdfData = Data()
    var paymentId = ""
    var price = "1"
    var selected_Book_Id = "0"
    @IBOutlet weak var dataTV: UITableView!
    var razorpay: RazorpayCheckout!
      let testKey = "rzp_test_h2qJyuZhWaSEyQ"
    let liveKey = "rzp_live_LW8bJifBfpF5d3"
//    var pdfUrlStr = "https://camps.goexploreandaman.com/invoice_api/"
    let month_Arr = ["January","Febraury","March","April","May","June","July","August","September","October", "November","December"]
    var pdfView = PDFView()
     var refreshContrl = UIRefreshControl()
    var webView = WKWebView()
    var pdfURL: URL!
    var isRefreshing:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        refreshSettings()
        razorpay = RazorpayCheckout.initWithKey(liveKey, andDelegate: self)
        dataTV.rowHeight = 420
        dataTV.isHidden = true
        pdfView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        self.view.addGestureRecognizer(tap)
        getData()
    }
    
    
    func refreshSettings() {
            refreshContrl.tintColor = .white
    //         self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            self.refreshContrl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
             dataTV.refreshControl = refreshContrl
            
        }
       
       
    @objc func reloadData() {
        self.dataTV.refreshControl?.beginRefreshing()
        isRefreshing = true
        getData()

    }
        
        
    
    @objc func onTapped(){
        print("Tapped")
        self.pdfView.removeFromSuperview()
    }
    @IBAction func back_Axn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func uploadDocuSign() {
        
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let detials = ["booking_id":selected_Book_Id]
            ApiService.uploadPDFwithParam(parameters: detials, imageKey: ["verfied_docusign_file"], dataArr: [pdfData], methodType: "POST", url: ClientInterface.uploadDocuSignUrl, tag: "Upload", finish: finishPost)
        print("detials = \(detials)")
        } else {
         popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
        }
        
    }
    func postStatusData() {
        
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let detials = ["id":DashboardVariables.bookingID, "user_id":UserDetails.id, "camp_status":"approved"] as [String:Any]
        
        ApiService.postCall(url: ClientInterface.bookingUrl, params: detials, methodType: "PUT", tag: "Status", finish:finishPost)
        print("detials = \(detials)")
        } else {
         popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
        }
        
    }
    
    func postRazorData() {
        
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let razorDetails = ["user_id":UserDetails.id,   "booking_id":DashboardVariables.bookingID, "id":paymentId, "status":"success", "method":"RazorPay_method",  "description":"oredr_ID", "card_id":"Card@1234",   "card_details":"card_details", "email":UserDetails.email,  "contact":UserDetails.mobileNumber,   "currency":"INR", "amount":price, "fee":"transaction_Fee", "payment_for":"Camps", "payment_via":"IOS", "created_at":"\(Date.self)"] as [String:Any]
        ApiService.postCall(url: ClientInterface.razorPayUrl, params: razorDetails, methodType: "POST", tag: "RazorPay", finish:finishPost)
        print("RazorDetails = \(razorDetails)")
        } else {
         popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
        }
        
    }
   
    
    func getData()  {
                            
       if reach.isConnectedToNetwork() == true {
       showActivityIndicator()
        ApiService.callPost(url: ClientInterface.bookingUrl, params: "", methodType: "GET", tag: "Dashboard", finish:finishPost)
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
                
        }
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        
        hideActivityIndicator()
        
        if tag == "Dashboard" {
            
        do {
       
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(GetBookingResponse.self, from: jsonData)
            print(parsedData)
        
                if parsedData.isEmpty == false {
                    if isRefreshing == true {
                        dataTV.refreshControl?.endRefreshing()
                    }
                dataArr = parsedData.reversed()
          
           
            for bookingData in dataArr {
                    if bookingData.user_id == UserDetails.id {
            
            camp_Arr.append(bookingData.camp_batch!)
            print("camp_Arr = \(camp_Arr)")
            print("bookingData = \(bookingData)")
            package_Arr.append(bookingData.package_name!)
                        price_Arr.append(bookingData.total_price!)
                        name_Arr.append(bookingData.first_name! + " " + bookingData.middle_name! + "" + bookingData.last_name!)
            voucher_Arr.append(bookingData.voucher_name!)
            invoice_Arr.append(bookingData.invoice_name!)
            status_Arr.append(bookingData.camp_status!)
            ID_Arr.append(bookingData.id!)
            verified_Arr.append(bookingData.verify_doc_sign_status!)
                    
            downloadSign_Arr.append(bookingData.docusign_file ?? "")
            signStatus_Arr.append(bookingData.docusign_status ?? "0")
            uploadSign_Arr.append(bookingData.verfied_docusign_file ?? "")
            
                        for month in month_Arr {
                if bookingData.season_camp!.contains(month) {
                    print("month = \(month)")
                } else {
                    print("No Month")
                }
            }
                        
            pkgID_Arr.append(bookingData.product_id!)
            dataTV.isHidden = false
            dataTV.reloadData()
            
            }
            }
                
            } else {
                popUpAlert(title: "Alert", message: "No Bookings", action: .alert)
            }
                
            }
           
            } catch {
            popUpAlert(title: "Alert", message: "Failed to  Connect Server. Try Again. ", action: .alert)
              print("Parse Error: \(error)")
            }
           
        
        } else {
            
        
            do {
        
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(StatusResponse.self, from: jsonData)
                print(parsedData)

                    
                if parsedData.status == true {

                    if tag == "Status" {
                    popUpAlert(title: "Alert", message: "Payment status Updated", action: .alert)
                    } else if tag == "Upload" {
                        popUpAlert(title: "Success", message: "Pdf Uploaded", action: .alert)

                    } else {
                        getData()

                        self.view.makeToast("Payment Details Updated..")

                    }
                
                }
                }
                } catch {
                print("Parse Error: \(error)")
                    
            }
            
            
        }
    }

}
extension DashBoardVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return camp_Arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BoardTVC
        cell.dataView.layer.borderColor = UIColor.white.cgColor
        cell.dataView.layer.cornerRadius = 5
        
        cell.pkgID_Lbl.text = pkgID_Arr[indexPath.row]
        cell.campLbl.text = camp_Arr[indexPath.row]
        cell.priceLbl.text = price_Arr[indexPath.row]
        cell.packageLbl.text = package_Arr[indexPath.row]
        cell.nameLbl.text = name_Arr[indexPath.row]
        cell.pStatus_Lbl.text = status_Arr[indexPath.row]
        cell.id_Lbl.text = ID_Arr[indexPath.row]
        cell.docStatus_Lbl.text = verified_Arr[indexPath.row]
       
        cell.bookingID_Lbl.text = ID_Arr[indexPath.row]
        
        cell.doc_Lbl.text = verified_Arr[indexPath.row]
        
        cell.dataView.elevate(elevation: 5.0)
       
        
        if cell.pStatus_Lbl.text == "pending" {
        cell.payNow_Btn.isHidden = false

        } else {
        cell.payNow_Btn.isHidden = true

        }
        
        
        cell.payNow_Btn.layer.cornerRadius = 5

        cell.activityBtn.layer.cornerRadius = 5
        cell.pkgDetals_Btn.layer.cornerRadius = 5
        cell.invoice_Btn.layer.cornerRadius = 5

        cell.download_Btn.addTarget(self, action: #selector(downloadAxn(sender:)), for: .touchUpInside)
       
        cell.upload_Btn.addTarget(self, action: #selector(uploadAxn(sender:)), for: .touchUpInside)

        cell.activityBtn.tag = indexPath.row
        cell.payNow_Btn.tag = indexPath.row
        cell.pkgDetals_Btn.tag = indexPath.row
        cell.invoice_Btn.tag = indexPath.row
        cell.download_Btn.tag = indexPath.row
        cell.upload_Btn.tag = indexPath.row

        cell.pkgDetals_Btn.addTarget(self, action: #selector(pkgAxn(sender:)), for: .touchUpInside)
        cell.activityBtn.addTarget(self, action: #selector(activityAxn(sender:)), for: .touchUpInside)
        cell.invoice_Btn.addTarget(self, action: #selector(invoiceAxn(sender:)), for: .touchUpInside)
        cell.payNow_Btn.addTarget(self, action: #selector(payNowAxn(sender:)), for: .touchUpInside)

        let cellPath = dataArr[indexPath.row]
        print("cellPath = \(cellPath)")

        
        return cell
    }
    
    @objc func downloadAxn(sender: UIButton){
        let btnPosition = sender.convert(CGPoint(), to: dataTV)
        let index = dataTV.indexPathForRow(at: btnPosition)
        let currentCell = dataTV.cellForRow(at: index!) as! BoardTVC
        if downloadSign_Arr[sender.tag].isEmpty == false {
        let downloadUrl = "https://camps.goexploreandaman.com/assets/docusign/\(downloadSign_Arr[sender.tag])"
        guard let url = URL(string: downloadUrl) else {
                        return
               }
               
        print("url = \(url)")
               if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
               }
        } else {
            popUpAlert(title: "Alert", message: "DocuSign Not Updated", action: .alert)
        }
    }
    
    @objc func uploadAxn(sender: UIButton){
       
        selected_Book_Id = ID_Arr[sender.tag]
        print("Selected Booking ID = \(selected_Book_Id)")
        if downloadSign_Arr[sender.tag].isEmpty == false {

        clickFunction()
        } else {
            popUpAlert(title: "Alert", message: "DocuSign Not Updated", action: .alert)

        }
    }
    func clickFunction(){

    let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    @objc func pkgAxn(sender: UIButton){
        
        let btnPosition = sender.convert(CGPoint(), to: dataTV)
        let index = dataTV.indexPathForRow(at: btnPosition)
        let currentCell = dataTV.cellForRow(at: index!) as! BoardTVC
       
        DashboardVariables.selected_Id = currentCell.id_Lbl.text!
        print("selectedID = \(currentCell.id_Lbl.text)")
        let VC = self.storyboard?.instantiateViewController(identifier: "BookingInfoVC") as! BookingInfoVC
        self.navigationController?.pushViewController(VC, animated: true)
        

               
       
       
    }
    
   
    @objc func activityAxn(sender: UIButton){
         let btnPosition = sender.convert(CGPoint(), to: dataTV)
         let index = dataTV.indexPathForRow(at: btnPosition)
         let currentCell = dataTV.cellForRow(at: index!) as! BoardTVC
        DashboardVariables.pkgID = currentCell.pkgID_Lbl.text!
        print("PKGID = \(DashboardVariables.pkgID)")
         switch currentCell.pkgID_Lbl.text! {
                            
         case "1":
             DashboardVariables.activtiesID = "15"
                        
         case "2":
             DashboardVariables.activtiesID = "16"
                        
         case "3":
             DashboardVariables.activtiesID = "17"
                        
         case "4":
             DashboardVariables.activtiesID = "18"
                        
         case "5":
             DashboardVariables.activtiesID = "19"
                        
         case "6":
             DashboardVariables.activtiesID = "10"
                        
         case "7":
             DashboardVariables.activtiesID = "11"
                        
         case "8":
             DashboardVariables.activtiesID = "12"
                        
         case "9":
             DashboardVariables.activtiesID = "13"
                         
         case "10":
             DashboardVariables.activtiesID = "14"
             
         default:
                            
             DashboardVariables.activtiesID = "15"
             
         }
                        
         print("Activity ID = \(DashboardVariables.activtiesID)")
                    
        let VC = self.storyboard?.instantiateViewController(identifier: "ActitvityViewController") as! ActitvityViewController
        self.navigationController?.pushViewController(VC, animated: true)

             
    }
    
    @objc func invoiceAxn(sender: UIButton){
          
        let btnPosition = sender.convert(CGPoint(), to: dataTV)
        let index = dataTV.indexPathForRow(at: btnPosition)
        let currentCell = dataTV.cellForRow(at: index!) as! BoardTVC
        DashboardVariables.bookingID = currentCell.id_Lbl.text!
        print("DashboardVariables.bookingID = \(DashboardVariables.bookingID)")
        
       openPdf()
               
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
//
//        present(VC, animated: true) {
//
//        }
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func openPdf() {
        
        guard let url = URL(string: "https://camps.goexploreandaman.com/welcome/invoice_pdf/" + DashboardVariables.bookingID) else {
                        return
               }
               
        print("url = \(url)")
               if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
               }
    }
    
    @objc func payNowAxn(sender: UIButton){
            
        let btnPosition = sender.convert(CGPoint(), to: dataTV)
        let index = dataTV.indexPathForRow(at: btnPosition)
        let currentCell = dataTV.cellForRow(at: index!) as! BoardTVC
        DashboardVariables.bookingID = currentCell.bookingID_Lbl.text!
        print("bookingID = \(DashboardVariables.bookingID)")
         price = currentCell.priceLbl.text!.fiterPrice()
        print("price = \(price)")
     
        
        
        if currentCell.doc_Lbl.text == "pending" {
        popUpAlert(title: "Alert", message: " Verificaton not Completed ", action: .alert)
            
        } else {
        let alert = UIAlertController(title: "Initiatinng Payment", message: "₹ - \(price)", preferredStyle: .alert)
        alert.setBackgroundColor(color: .white)
        alert.setTint(color: .baseColor)
        alert.setTitlet(font: UIFont(name: "Baskerville-SemiBold", size: 15), color: .systemRed)
        alert.setMessage(font: UIFont(name: "Baskerville-SemiBold", size: 15.0), color: .black)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.showPaymentForm()

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            print("User cancelled Payment")
        }))
        present(alert, animated: true) {
            
        }
        }
    }
    
    func showPaymentForm(){
        let options: [String:Any] = [
        "amount": "\(price)00", //This is in currency subunits. 100 = 100 paise= INR 1.
        "currency": "INR",//We support more that 92 international currencies.
        "description": "Camp Package",
        "image": "https://camps.goexploreandaman.com/assets/images/photo/autumn.jpg",
        "name": "AndamanCamps",
        "prefill": [
                "contact": UserDetails.mobileNumber,
                "email": UserDetails.email,
        ],
        "theme": [
                "color": "#165096"
            ]
        ]
           
            razorpay.open(options)
    }
    
    
}
extension DashBoardVC: RazorpayPaymentCompletionProtocol, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate
 {

    
    func onPaymentError(_ code: Int32, description str: String) {
        popUpAlert(title: "Failed", message: str, action: .alert)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        paymentId = payment_id
        print("PaymentId = \(paymentId)")

        postRazorData()
        self.navigationController?.popViewController(animated: true)
   
        alert(message: "Payment done.", title: "Success")


    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        
       pdfData = try! Data(contentsOf: myURL)
       print("pdfData = \(pdfData)")
        if pdfData.isEmpty == false {
            uploadDocuSign()
        } else {
            popUpAlert(title: "Alert", message: "Pdf Data is Empty", action: .alert)
        }
        
    }


    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
       
    }
   
    
}
