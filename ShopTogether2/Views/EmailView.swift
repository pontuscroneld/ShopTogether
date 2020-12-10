//
//  EmailView.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI

struct EmailView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            
            TextField("Email adress", text: $email)
                .padding()
            SecureField("Password", text: $password)
                .padding()
            
            HStack{
                CreateLogIn(action: "Create User", buttoncolor: .orange, function: "create", newEmail: email, newPassword: password)
                CreateLogIn(action: "Log in", buttoncolor: .green, function: "login", newEmail: email, newPassword: password)
            }
        }
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}
