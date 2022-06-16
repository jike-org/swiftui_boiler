//
//  ProfileView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-23.
//

import SwiftUI



struct ProfileView: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var fname : String = ""
    @State var lname : String = ""
    @State var email : String = ""
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = Image("emBanner")
    
    
    
    @State var isForgotPasswordActive = false
    @State var editingMode : Bool = false
    
    @ObservedObject var viewModel = ProfileVM()
    
    var body: some View {
        ZStack {
            Color.white
        VStack {
            ZStack{
                image?
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipped()
                if(editingMode){
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .foregroundColor(.white)
                    }).frame(width: 140, height: 140, alignment: .bottomTrailing)
                }
            }
            VStack(alignment : .leading, spacing: 10){
                Text("First Name")
                    .font(.caption)
                    .padding(.top, 20)
                TextField("", text: $fname)
                    .disabled(!editingMode)
                    .modifier(customTFStyle1(color: color))
                Text("Last name")
                    .font(.caption)
                    .padding(.top, 20)
                TextField("", text: $lname)
                    .disabled(!editingMode)
                    .modifier(customTFStyle1(color: color))
                Text("Email")
                    .keyboardType(.emailAddress)
                    .font(.caption)
                    .padding(.top, 20)
                TextField("", text: $email)
                    .disabled(!editingMode)
                    .modifier(customTFStyle1(color: color))
                
            }.onAppear(){
                viewModel.proceedWithViewProfile()
            }
            
            if(editingMode){
                Button(action: {
                    viewModel.proceedWithUpdateProfileInfo(firstName: fname, lastName: lname, email: email)
                }, label: {
                    Text("Save")
                        .font(.headline)
                })
                .padding()
            }
            
            NavigationLink( destination: ChangePasswordView() ,isActive: $isForgotPasswordActive){
                Button(action: {
                    isForgotPasswordActive.toggle()
                }, label: {
                    Text("Change Password")
                        .font(.headline)
                }).padding(.top, 20)
            }
      
        }.padding()
        .navigationBarTitle("Profile", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(editingMode ? "Cancel" : "Edit") {
                    withAnimation(.spring()) {
                        editingMode.toggle()
                    }
                }.font(.headline)
            }
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ImagePicker : UIViewControllerRepresentable {
   @Binding var isShown : Bool
   @Binding var image : Image?
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    func makeCoordinator() -> ImagePickerCordinator {
          return ImagePickerCordinator(isShown: $isShown, image: $image)
       }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
          picker.delegate = context.coordinator
          return picker
       }
}


class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @Binding var isShown : Bool
    @Binding var image : Image?
    init(isShown : Binding<Bool>, image: Binding<Image?>) {
          _isShown = isShown
          _image = image
       }
    //Selected Image
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let uiImage = info[UIImagePickerController.InfoKey.originalImage]   as! UIImage
    image = Image(uiImage: uiImage)
       isShown = false
    }
    //Image selection got cancel
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       isShown = false
       }
}


struct PhotoCaptureView: View {
   @Binding var showImagePicker : Bool
   @Binding var image : Image?
 
   var body: some View {
      ImagePicker(isShown: $showImagePicker, image: $image)
   }
}
struct PhotoCaptureView_Previews: PreviewProvider {
   static var previews: some View {
      PhotoCaptureView(showImagePicker: .constant(false), image:  .constant(Image("")))
   }
}
