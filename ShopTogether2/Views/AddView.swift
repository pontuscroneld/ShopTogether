//
//  AddView.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-05.
//


import SwiftUI
import Firebase

struct AddView: View {
    
    @State var expand = false
    @State var slideramount : Float = 0
    @State var amounttype = "pcs"
    @State var itemname = ""
    
    
    var body: some View {
        
        VStack{
            
            if(itemname == ""){
                Text("Add item to list").font(.title).padding(.top, 150)
            } else{
                Text("\(itemname) \(Int(slideramount)) \(amounttype)").font(.title)
                    .padding(.top, 150)
            }
        
            
            TextField("I need to buy...", text: $itemname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                .frame(width: 350.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                
                
            
            
            Slider(value: $slideramount, in: 0...20, step: 1)
                .frame(width: 300, height: 10)
                .padding(.bottom)
                .accentColor(.red)
                .padding(.leading)
                .padding(.trailing)
                
                
            
        
            HStack{
                
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable()
                    .frame(width: 25, height: 10)
                    .foregroundColor(.red)
            }
            .onTapGesture {
                self.expand.toggle()
                    
            }.animation(.spring())
            
            
            
            
            VStack{
                
            if expand {
                    
                    Button(action: {
                        self.amounttype = "pcs"
                        self.expand.toggle()
                    }) {
                        Text("Pieces")
                    }.padding(5)
                    
                    Button(action: {
                        self.amounttype = "g"
                        self.expand.toggle()
                    }) {
                        Text("Grams")
                    }.padding(5)
                    
                    Button(action: {
                        self.amounttype = "kg"
                        self.expand.toggle()
                    }) {
                        Text("Kilograms")
                    }.padding(5)
                    
                    Button(action: {
                        self.amounttype = "l"
                        self.expand.toggle()
                    }) {
                        Text("Liters")
                    }.padding(5)
                    
                }
                
            }.animation(.spring())
            
            
            
           
            
            Button(action:{
                
                if(itemname != "" && slideramount != 0){
                
                addviewtofirebase()
                }
                
                
            }) {
                
                if(itemname == "" || slideramount == 0 || expand == true){
                    Text("")
                } else{
                    Text("Add")
                }
            }.padding()
            
           Spacer()

        } // End top stack
    }// End body
    
    func addviewtofirebase(){
        
        let UserId = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
    
        ref.child("Users").child(UserId!).child("Shop").childByAutoId().setValue(["name": itemname, "amount": String(Int(slideramount)), "isbought": false, "amounttype": amounttype])
        
        itemname = ""
        slideramount = 0
        amounttype = "pcs"
        
    }
    
    
}// End Struct

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
