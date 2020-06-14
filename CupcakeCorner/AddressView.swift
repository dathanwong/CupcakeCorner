//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Dathan Wong on 6/14/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section{
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }.disabled(order.hasValidAddress)
            }
        }
    .navigationBarTitle("Delivery details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
