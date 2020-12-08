//
//  PDFViewController.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 25/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import PDFKit
import WebKit


class PDFViewController: UIViewController   {
    @IBOutlet weak var myWebView: WKWebView!
    
    

    var pdfView = PDFView()
       var pdfURL: URL!

//    var pdfUrlStr = "https://camps.goexploreandaman.com/welcome/invoice_pdf/" + DashboardVariables.bookingID
 var pdfUrlStr = "https://camps.goexploreandaman.com/welcome/invoice_pdf/" + DashboardVariables.bookingID
    
    override func viewDidLoad() {
        super.viewDidLoad()
            showActivityIndicator()


        let url = URL(string: pdfUrlStr)!
        myWebView.load(URLRequest(url: url))
        myWebView.allowsBackForwardNavigationGestures = true
        hideActivityIndicator()
    }
    
   
    
    @IBAction func back_Axn(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    @IBAction func pdf_Btn(_ sender: UIButton) {
        
        savePdf(urlString: pdfUrlStr + DashboardVariables.bookingID, fileName: Preferrences.getFirstName() + DashboardVariables.bookingID)
    }
    
    
    func savePdf(urlString: String , fileName:String) {
           showActivityIndicator()

           DispatchQueue.main.async {
               
               let url = URL(string: urlString)
               let pdfData = try? Data.init(contentsOf: url!)
               let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
               let pdfNameFromUrl = "Invoice-\(fileName).pdf"
               let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
               do {
                   try pdfData?.write(to: actualPath, options: .atomic)
                   print("urlString = \(urlString)")
                   print("actualPath = \(actualPath)")
               
                self.alert(message: "\(actualPath)", title: "Pdf saved successfully")
                   print("pdf successfully saved!")
                self.hideActivityIndicator()
               } catch {
                   print("Pdf could not be saved")
               }
           }
    }

//    func webViewDidStartLoad(_ webView: UIWebView) {
//
//       showActivityIndicator()
//    }
//
//
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//
//        hideActivityIndicator()
//    }
//
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//
//        hideActivityIndicator()
//    }
//
}
