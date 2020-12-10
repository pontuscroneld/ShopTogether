//
//  AmountType.swift
//  ShopTogether2
//
//  Created by Pontus Croneld on 2020-12-09.
//

import SwiftUI

struct AmountType: View {
    
    var type: String
    var buttonColor: Color
    
    var body: some View {
        ZStack{
            Capsule()
                .frame(width: 100, height: 45)
                .foregroundColor(buttonColor)
            Text(type)
                .foregroundColor(.white)
                .font(.headline)
                .fontWeight(.semibold)
            
        }
    }
}

struct AmountType_Previews: PreviewProvider {
    static var previews: some View {
        AmountType(type: "Kilograms", buttonColor: .red)
            .previewLayout(.sizeThatFits)
    }
}
