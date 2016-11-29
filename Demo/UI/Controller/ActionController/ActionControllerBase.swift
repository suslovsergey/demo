//
//  ActionControllerBase.swift
//  Demo
//
//  Created by Sergey Suslov on 23.11.16.
//  Copyright © 2016 SS. All rights reserved.
//
import UIKit
import XLActionController

class ActionControllerBase<T: UICollectionViewCell>: ActionController<T, String, ActionControllerHeader, String, UICollectionReusableView, Void> {
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        sectionHeaderSpec = .cellClass(height: { _ in 5 })
        headerSpec = .cellClass(height: { _ in return 40 })
        
        onConfigureHeader = { header, headerData in
            header.label.text = headerData
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    override func dismiss() {
        self.view.endEditing(true)
        super.dismiss()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 || self.view.frame.origin.y == 20 { //Hack for Call/Internet status bar -- Надо делать нормально
                self.view.frame.origin.y -= (keyboardSize.height + self.view.frame.origin.y)
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

