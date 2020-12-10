//
//  ContentView.swift
//  ShopTogether2
//  
//  Created by Pontus Croneld on 2020-12-05.
//


import SwiftUI
import Firebase

struct ContentView: View {
    
    let ref = Database.database().reference()
    @State private var GoToAdd : Bool = false
    @State var ShowSignIn = false
    
    
    @State var ListItems = [ShopItem]()
    @State var textfielditem = ""
    @State var textfieldamount = ""
    @State var isboughtlocal = false
    @State var sidemenu = false
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
    var body: some View {
    
    NavigationView{
       
        ZStack{
            VStack{
            
                NavigationLink(
                    destination: AddView(),
                    isActive: self.$GoToAdd){
                    Text("")
                }
                
                List {
                ForEach(ListItems) { Currentitem in
                        HStack{
                        
                            Text(Currentitem.name)
                            Text("\(Currentitem.amount) \(Currentitem.amounttype)")
                            Spacer()
                            Button(action:{ changeisbought(id: Currentitem.firebaseid)}) {
                                Currentitem.isbought ? Image("checkgood").resizable().frame(width: 30.0, height: 30.0) : Image("checkbad").resizable().frame(width: 30.0, height: 30.0)
                            }
                        }
                    }.onDelete(perform: deleteitem)
                
                    //End HStack
               
               }
               .listStyle(InsetListStyle())
               .navigationTitle("Shopping list")
               .navigationBarItems(leading: Button(action: { self.ShowSignIn.toggle()}) { Image(systemName: "person.circle")}, trailing: EditButton())
                //End list
               
            
                HStack {
                    
                    Spacer()
                    VStack{
                        EmptyView()
                    }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    VStack{
                        AddCircle()
                            .onTapGesture {
                                self.GoToAdd = true
                                vibration()
                            }
                            
                    }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    VStack {
                        Refresh()
                            .onTapGesture {
                                loadfromfirebase()
                                let haptic = UIImpactFeedbackGenerator(style: .heavy)
                                   haptic.impactOccurred()
                            }
                    }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    Spacer()
                }// End Button HStack
            } //End First VStack
            .onAppear(){
                if(Auth.auth().currentUser != nil){
                   loadfromfirebase()
                }
            }
            .sheet(isPresented: $ShowSignIn, content: {
               LogInView()
        })
        // VSTACK EXTRA END
        
            
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
            if sidemenu {
                
                HStack {
                    VStack {
                        List{
                            Button(action:  {
                                ShowSignIn.toggle()
                            }) {
                                Text("Connect Account")
                            }
                                Button(action: {
                            
                            }) {
                                Text("Add a friend")
                            }
                                Button(action: {
                            
                            }) {
                                Text("Settings")
                        }
                        
                        Spacer(minLength: 450)
                        
                        Button(action: {
                            
                            
                        }, label: {
                            HStack{
                                Text("Log out")
                                Image(systemName: "lock.circle")
                            }
                        })
                        
                    }.listStyle(SidebarListStyle())
                    
                    Spacer()
                }.frame(width: 250, height: 1000)
                    .background(Color.green)
                    Spacer()
                }
            }
            
        }// End ZStack
        
        
    } // End  nav view
    } // End body

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    func deleteitem(at offsets: IndexSet)
        {
        
        if(Auth.auth().currentUser == nil){
            Auth.auth().signInAnonymously()
            loadfromfirebase()
        }
        
            offsets.forEach {
                
                let UserId = Auth.auth().currentUser?.uid
                ref.child("Users").child(UserId!).child("Shop").child(ListItems[$0].firebaseid).removeValue()
                
            }
        if(Auth.auth().currentUser != nil){
            loadfromfirebase()
        }
        
    }
    
    func changeisbought(id: String){
        
        if(Auth.auth().currentUser == nil){
            Auth.auth().signInAnonymously()
            return
        }
        
        let UserId = Auth.auth().currentUser?.uid
        
        isboughtlocal.toggle()
        vibration()
        
        let ref = Database.database().reference()
        ref.child("Users").child(UserId!).child("Shop").child(id).updateChildValues(["isbought": isboughtlocal])
        
        loadfromfirebase()
    }
    
    func vibration(){
        
        let haptic = UIImpactFeedbackGenerator(style: .medium)
           haptic.impactOccurred()
        
    }
    
        
    func loadfromfirebase(){
        
        if(Auth.auth().currentUser == nil){
            Auth.auth().signInAnonymously()
            return
        }
        
        let UserId = Auth.auth().currentUser?.uid
        
        let ref = Database.database().reference()
        ref.child("Users").child(UserId!).child("Shop").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var tempShoppings = [ShopItem]()
            
            for child in snapshot.children
            
            {
                let childdata = child as! DataSnapshot
                let childdict = childdata.value as! [String : Any]
                
                let tempShop = ShopItem()
                tempShop.firebaseid = childdata.key
                tempShop.name = childdict["name"] as! String
                tempShop.amount = childdict["amount"] as! String
                tempShop.isbought = childdict["isbought"] as! Bool
                tempShop.amounttype = childdict["amounttype"] as! String
                
                tempShoppings.append(tempShop)
            }
            tempShoppings.sort { !$0.isbought && $1.isbought }
            ListItems = tempShoppings
    }) { (error) in
            print(error.localizedDescription)
            print("FEL")
        }
    }
    
} // End ContentView


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


