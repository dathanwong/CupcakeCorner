//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Dathan Wong on 6/14/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: OrderClass
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.order.name)
                TextField("Street Address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            Section{
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }.disabled(!order.order.hasValidAddress)
            }
        }
    .navigationBarTitle("Delivery details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass())
    }
}
