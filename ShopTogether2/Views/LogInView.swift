//
//  LogInView.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-05.
//

import SwiftUI
import FirebaseUI
import Firebase

enum ActiveAlert {
    
    case first, second, third, fourth, fifth, sixth
    
}

struct LogInView: View {
    
    @State var logInWithEmail = false
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var signOutAlert = false
    
    @State private var activeAlert: ActiveAlert = .first
    
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator: AppleCoordinator?
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Image("basket.logo")
                .resizable()
                .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 50)
            
           
            
            if(logInWithEmail == false){
            SignInWIthApple()
                .frame(width: 300, height: 45)
                .onTapGesture {
                    self.coordinator = AppleCoordinator()
                    if let coordinator = self.coordinator {
                        coordinator.startSignInWithAppleFlow {
                            print("You succesfully signed in")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                   
                } //End Tap Apple
            }
           
            if(Auth.auth().currentUser == nil || Auth.auth().currentUser!.isAnonymous){
                SignInWithEmail(doThis: {
                    logInWithEmail.toggle()
                })
            }
            
                
           
            if(logInWithEmail == true){
                
                TextField("Email adress", text: $email)
                    .padding()
                    
                SecureField("Password", text: $password)
                    .padding()
                    
                
                HStack{
                    
                    CreateLogIn(doThis: { if(Auth.auth().currentUser!.isAnonymous == false)  {
                                            self.activeAlert = .sixth
                                            showAlert.toggle()}
                                        else{
                                            self.activeAlert = .third
                                            showAlert.toggle()
                                }}
                                , action: "Create User", buttoncolor: .orange, function: "create", newEmail: email, newPassword: password)
                    CreateLogIn(doThis: {if
                                    (Auth.auth().currentUser!.isAnonymous == false){
                                    self.activeAlert = .fourth
                                    showAlert.toggle()}
                                else {
                                    self.activeAlert = .fifth
                                    showAlert.toggle()
                                    }}
                                , action: "Log in", buttoncolor: .green, function: "login", newEmail: email, newPassword: password)
                    
                }
                Button(action: {
                    
                    if(email == "")
                        {
                        self.activeAlert = .first
                        }
                    else{
                        
                        self.activeAlert = .second
                        Auth.auth().sendPasswordReset(withEmail: email) { err in
                           
                        print("Error sending reset password")
                        }
                    }
                   showAlert = true
                   UIApplication.shared.endEditing()
                }) {
                    Text("Reset password")
                        .font(.headline)
                        .fontWeight(.regular)
                }
                .frame(width: 150, height: 50)
                .background(Color.red)
                .cornerRadius(7)
                .foregroundColor(.white)
                .padding(.top, 2)
                .alert(isPresented: $showAlert) {
                            switch activeAlert {
                            case .first:
                                return Alert(title: Text("Email adress missing!"), message: Text("Please enter your  email adress in the field above."), dismissButton: .default(Text("Got it!")))
                            case .second:
                                return Alert(title: Text("Resetting password!"), message: Text("A link to reset your password has been sent to the email adress you entered! "), dismissButton: .default(Text("Got it!")))
                            case .third:
                                return Alert(title: Text("Something went wrong!"), message: Text("There was a problem creating your account! Make sure you entered a valid email. The password needs to contain at least 6 characters."), dismissButton: .default(Text("Got it!")))
                            case .fourth:
                                return Alert(title: Text("Logged in!"), message: Text("You are logged in!"), dismissButton: .default(Text("Got it!")))
                            case .fifth:
                                return Alert(title: Text("Problem signing in!"), message: Text("Make sure you enter a valid email and password!"), dismissButton: .default(Text("Got it!")))
                            case .sixth:
                                return Alert(title: Text("Welcome new user!"), message: Text("You are now signed up, logged in and ready to go! Previous items may be saved locally until the list is updated."), dismissButton: .default(Text("Got it!")))
                            }
                        }
            }
            if(Auth.auth().currentUser == nil || Auth.auth().currentUser!.isAnonymous == false){
                SignOut(doThis: {
                    signOutAlert.toggle()
                    Auth.auth().signInAnonymously()
                }).padding(.top, 2)
            }
        
            
            Text("Share basket with your household using the same login!")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .font(.caption)
                .alert(isPresented: $signOutAlert){
                    Alert(title: Text("Signed out!"), message: Text("You are not logged in to any account. Previous items may be saved locally until the list is updated."), dismissButton: .default(Text("Got it!")))
                }
            
            
            Spacer()
            
        } // End top stack
    }// End body
    
  
    
}// End view

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .previewDevice("iPhone SE (2nd generation)")
    }
}

