//
//  Signup.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-04.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var color = Color.black.opacity(0.7)
    @State var fname : String = ""
    @State var lname : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var confirmPassowrd : String = ""
    
    @State var showPasscode = false
    @State var reShowPasscode = false
    
    @State var showTerms = false
    @State var showPrivacy = false
    
    @ObservedObject var viewModel = SignupVM()
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = Image("emBanner")
    
    
    var body: some View {
        ScrollView {
            VStack{
                Button(action: {
                    self.showImagePicker = true
                }, label: {
                    image?
                        .resizable()
                        .frame(width: 250, height: 150)
                        .clipped()
                })
                
                VStack(alignment : .leading, spacing: 10){
                    Text("First Name")
                        .font(.caption)
                        .padding(.top, 20)
                    TextField("", text: $fname)
                        .modifier(customTFStyle1(color: color))
                        .validate(with: fname, validation: Validators().nonEmptyValidator)
                    Text("Last name")
                        .font(.caption)
                        .padding(.top, 20)
                    TextField("", text: $lname)
                        .modifier(customTFStyle1(color: color))
                        .validate(with: lname, validation: Validators().nonEmptyValidator)
                    Text("Email")
                        .keyboardType(.emailAddress)
                        .font(.caption)
                        .padding(.top, 20)
                    TextField("", text: $email)
                        .modifier(customTFStyle1(color: color))
                        .validate(with: email, validation: Validators().isValidEmailValidator)
                    Text("Password")
                        .font(.caption)
                        .padding(.top, 20)
                    HStack(spacing: 15){
                        VStack{
                            if self.showPasscode{
                                TextField("Password", text: self.$password)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: self.$password)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            self.showPasscode.toggle()
                        }) {
                            
                            Image(systemName: self.showPasscode ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                        
                    }
                    .modifier(customTFStyle1(color: color))
                    .validate(with: password, validation: Validators().isValidPasswordValidator)
                    
                    Text("Confirm Password")
                        .font(.caption)
                        .padding(.top, 20)
                    HStack(spacing: 15){
                        VStack{
                            if self.reShowPasscode{
                                TextField("Password", text: self.$confirmPassowrd)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: self.$confirmPassowrd)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        Button(action: {
                            self.reShowPasscode.toggle()
                        }) {
                            
                            Image(systemName: self.reShowPasscode ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                        
                    }
                    .modifier(customTFStyle1(color: color))
                    .validate(with: confirmPassowrd, text2: password, validation: Validators().confirmPasswordValidator)
                    
                }
                
                Button(action: {
                    viewModel.proceedWithRegister(firstName: fname, lastName: lname, email: email, password: password, confirmPassword: confirmPassowrd)
                }, label: {
                    Text("Sign up")
                        .font(.headline)
                }).padding(.top, 20)
                
                
                VStack{
                    Text("By signing up , you agree to our")
                        .font(.subheadline)
                    
                    HStack{
                        
                        NavigationLink( destination: DetailsView(viewName: "Terms & Conditions"),
                                        isActive: $showTerms){
                            Button(action: {
                                showTerms.toggle()
                            }, label: {
                                Text("Terms & Conditions")
                            }).font(.subheadline)
                        }
                        Text("and")
                            .font(.subheadline)
                        
                        NavigationLink( destination: DetailsView(viewName: "Privacy Policy"),
                                        isActive: $showPrivacy){
                            Button(action: {
                                showPrivacy.toggle()
                            }, label: {
                                Text("Privacy Policy")
                            }).font(.subheadline)
                        }
                    }
                }.padding(.top, 20)
                
                HStack{
                    Text("Already have an account?")
                    Button("Sign In"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                }.padding(.top, 20)
                
            }.padding()
            .navigationBarTitle("Sign Up", displayMode: .inline)
        }.onAppear {
            UIScrollView.appearance().keyboardDismissMode = .interactive
        }
        .alert(isPresented: $viewModel.showMessage, content: {
            Alert(title: Text("Error"), message: Text(viewModel.message), dismissButton: .cancel())
        })
        .sheet(isPresented: self.$showImagePicker)
          {
             PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
           }
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
