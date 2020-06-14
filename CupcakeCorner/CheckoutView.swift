//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Dathan Wong on 6/14/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical) {
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place order"){
                        
                    }
                    .padding()
                }
            }
        }.navigationBarTitle("Checkout")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
