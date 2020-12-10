//
//  AddCircle.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI

struct AddCircle: View {
    var body: some View {
       
        ZStack{
            Capsule()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .shadow(radius: 5)
            Image(systemName: "plus")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AddCircle_Previews: PreviewProvider {
    static var previews: some View {
        AddCircle()
            .previewLayout(.sizeThatFits)
    }
}
