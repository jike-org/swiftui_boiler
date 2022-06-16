//
//  ChangePasswordVM.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import Foundation

class ChangePasswordVM: ObservableObject, iBSChangePasswordDelegate {
    
    @Published var showMessage = false
    @Published var message = ""
    
    var changePasswordService: iBSChangePassword?
    
    //MARK: Store form items
    var formItems = [FormParameterItem]()
    
    
    //MARK: Declare the form items here
    func setFormItems(currentPassword : String, newPassword :String, confirmPassword :String) {
        
        let currentPasswordItem = FormParameterItem(itemType: .password, parameterKey: "current_password", parameterValue: currentPassword, comparingValue: nil, characterCount: Constant.Counts.passwordCount, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .newPassword)
        
        let newPasswordItem = FormParameterItem(itemType: .newPassword, parameterKey: "password", parameterValue: newPassword, comparingValue: nil, characterCount: Constant.Counts.passwordCount, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: .confirmNewPassword)
        
        let confirmNewPasswordItem = FormParameterItem(itemType: .confirmNewPassword, parameterKey: "password_confirmation", parameterValue: confirmPassword, comparingValue: newPassword, characterCount: Constant.Counts.passwordCount, minCharacterCount: 0, maxCharacterCount: 0, isMandatory: true, nextItemType: nil)
        
        // Set form items
        formItems = [currentPasswordItem, newPasswordItem, confirmNewPasswordItem]
    }
    
    
    //MARK: Local validation and proceed with change password web service
    func proceedWithChangePassword(currentPassword : String, newPassword :String, confirmPassword :String) {
        
        //MARK: 1. Set parameter items
        self.setFormItems(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
        
        //MARK: 2. Get initial params
        let _initialParams: [String: Any] = [:]
        
        //MARK: 3. Init change password service and set delegate
        self.changePasswordService = iBSChangePassword(initialParams: _initialParams, formItems: self.formItems)
        self.changePasswordService?.delegate = self
        

        //MARK: 4. Local validation
        changePasswordService?.validateChangePassword(completion: { status, message in
            
            switch status {
            case true:
                //MARK: 5. Change password web service
                changePasswordService?.changePasswordNetworkRequest(completion: { status, code, message, data in
                    switch status {
                    case true:
                        break
                    default:
                        self.showMessage = true
                        self.message = message
                    }
                })
            default:
                self.showMessage = true
                self.message = message
            }
        })
    }
    
}
