//
//  ForgotPasswordView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State var email = ""
    
    @ObservedObject var viewModel = ForgotPasswordVM()
    
    var body: some View {
        VStack {
            Image("emBanner")
                .resizable()
                .frame(width: 250, height: 150)
                .clipped()
            
            Text("Please input the email address that you registered before to active the acccount")
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Email")
                TextField("", text: $email)
                    .modifier(customTFStyle1())
            }
            .padding(.top, 40)
            
            Button(action: {
                viewModel.proceedWithRetrivePassword(email: email)
            }, label: {
                Text("Submit")
            }).font(.headline)
            .padding(.top, 40)
        }.padding()
        .alert(isPresented: $viewModel.showMessage, content: {
            Alert(title: Text("Error"), message: Text(viewModel.message), dismissButton: .cancel())
        })
       
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
