//
//  UniversalFullButton.swift
//  Navigation
//
//  Created by Nevin Jethmalani on 5/1/16.
//  Copyright © 2016 Notify Nearby. All rights reserved.
//

import UIKit

class UniversalUIElements: NSObject {
    
    func fullButton (_ buttonStyle: UIButton){
        buttonStyle.setTitleColor(UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ), for: UIControlState())
        buttonStyle.layer.backgroundColor = UIColor( red: 224/255, green: 160/255, blue:12/255, alpha: 1.0 ).cgColor
        buttonStyle.layer.borderColor = UIColor( red: 224/255, green: 160/255, blue:12/255, alpha: 1.0 ).cgColor
        buttonStyle.layer.borderWidth = 1
        buttonStyle.layer.cornerRadius = 8
    }
    class func notifyNearbyLightGray()->UIColor {
        return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
    }
    class func looqLightOrange()->UIColor {
        return UIColor(red: 207/255, green: 144/255, blue: 35/255, alpha: 1.0)
    }
    
    func signInEmptyButton (_ buttonStyle: UIButton){
        buttonStyle.setTitleColor(UIColor( red: 224/255, green: 160/255, blue:12/255, alpha: 1.0 ), for: UIControlState())
        buttonStyle.layer.backgroundColor = UIColor.clear.cgColor
        buttonStyle.layer.borderColor = UIColor( red: 224/255, green: 160/255, blue:12/255, alpha: 1.0 ).cgColor
        buttonStyle.layer.borderWidth = 1
        buttonStyle.layer.cornerRadius = 8
    }
    
    func emptyButton (_ buttonStyle: UIButton){
        buttonStyle.setTitleColor(UIColor( red: 224/255, green: 160/255, blue:12/255, alpha: 1.0 ), for: UIControlState())
        buttonStyle.layer.backgroundColor = UIColor.clear.cgColor
        //buttonStyle.layer.backgroundColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).CGColor
        buttonStyle.layer.borderColor = UIColor( red: 224/255, green: 160/255, blue:12/255, alpha: 1.0 ).cgColor
        buttonStyle.layer.borderWidth = 1
        buttonStyle.layer.cornerRadius = 8
    }
    
    func productCollectionViewCell (_ backgroundViewStyle: UIView){
        backgroundViewStyle.layer.shadowOffset = CGSize(width: 0,height: 4)
        backgroundViewStyle.layer.shadowRadius = 5
        backgroundViewStyle.layer.shadowOpacity = 50
        backgroundViewStyle.layer.shadowColor = UIColor( red: 89/255, green: 89/255, blue:89/255, alpha: 0.4 ).cgColor
        backgroundViewStyle.layer.borderWidth = 0.5
        backgroundViewStyle.layer.borderColor = UIColor( red: 217/255, green: 217/255, blue:217/255, alpha: 1 ).cgColor
    }
    class func productCollectionViewCell(_ backgroundViewStyle: UIView) {
        backgroundViewStyle.layer.shadowOffset = CGSize(width: 0,height: 4)
        backgroundViewStyle.layer.shadowRadius = 5
        backgroundViewStyle.layer.shadowOpacity = 50
        backgroundViewStyle.layer.shadowColor = UIColor( red: 89/255, green: 89/255, blue:89/255, alpha: 0.4 ).cgColor
        backgroundViewStyle.layer.borderWidth = 0.5
        backgroundViewStyle.layer.borderColor = UIColor( red: 217/255, green: 217/255, blue:217/255, alpha: 1 ).cgColor
    }
    
    //this is the shadow for each feed elements
    func shadowForFeed (_ view: UIView){
        view.layer.shadowOffset = CGSize(width: 0,height: 8)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 99
        view.layer.shadowColor = UIColor( red: 89/255, green: 89/255, blue:89/255, alpha: 0.7 ).cgColor
    }
    
    //Removes the padding and spacing that a Text View has
    func removeTextViewInset (_ textViewOrig: UITextView) {
        textViewOrig.textContainerInset = UIEdgeInsets.zero
        textViewOrig.textContainer.lineFragmentPadding = 0
    }
    
    //Adds Border around logo image in feed
    func logoBorder (_ logoImage: UIView){
        logoImage.layer.borderWidth = 0.5
        logoImage.layer.borderColor = UIColor( red: 89/255, green: 89/255, blue:89/255, alpha: 0.7 ).cgColor
    }
    

    
    //this is the shadow under the stackview at the bottom of a page
    func bottomBar (_ stackView: UIView){
        stackView.layer.shadowOffset = CGSize(width: 0,height: -5)
        stackView.layer.shadowRadius = 10
        stackView.layer.shadowOpacity = 50
        stackView.layer.shadowColor = UIColor( red: 89/255, green: 89/255, blue:89/255, alpha: 0.4 ).cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor( red: 217/255, green: 217/255, blue:217/255, alpha: 1 ).cgColor
    }
    
    //Used during sign up page for Text Fields
    func textAndBorderChange (_ textField: UITextField){
        let paddingForFirst = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height))
        //Adding the padding to the second textField
        textField.leftView = paddingForFirst
        textField.leftViewMode = UITextFieldViewMode.always
        textField.textColor = UIColor.white
        
        //adds a border to the view
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.5
    }
    
    func borderAndPaddingForSettings (_ textField:UITextField){
        let paddingForFirst = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height))
        //Adding the padding to the second textField
        textField.leftView = paddingForFirst
        textField.leftViewMode = UITextFieldViewMode .always
        textField.layer.borderColor = UIColor( red: 128/255, green: 128/255, blue:128/255, alpha: 0.5 ).cgColor
        textField.layer.borderWidth = 0.5
    }
    
    func alertMessageForFields(viewController: UIViewController, alertTitle:String, alertDescirption:String){
        let alertController = UIAlertController(title: alertTitle, message: alertDescirption, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            //print("You pressed OK")
        }
        
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    func looqPageViewBorder (_ backgroundView:UIView){
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor( red: 230/255, green: 230/255, blue:230/255, alpha: 0.8 ).cgColor
    }
    
}
