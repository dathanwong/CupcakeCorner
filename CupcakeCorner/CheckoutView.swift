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
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var alertTitle = ""
    
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
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }.navigationBarTitle("Checkout")
            .alert(isPresented: $showingConfirmation) { () -> Alert in
                Alert(title: Text(self.alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder(){
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data else{
                self.alertTitle = "Error"
                self.confirmationMessage = "Unable to place order please try again later"
                self.showingConfirmation = true
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                self.alertTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            }else{
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
