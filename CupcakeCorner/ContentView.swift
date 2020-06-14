//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Dathan Wong on 6/12/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...20){
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section{
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any Special requests?")
                    }
                    if order.specialRequestEnabled{
                        Toggle(isOn: $order.extraFrosting){
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.addSprinkles){
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery Details")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
