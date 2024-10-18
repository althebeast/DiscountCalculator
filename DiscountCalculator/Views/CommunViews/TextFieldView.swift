//
//  TextFieldView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 15.10.2024.
//

import SwiftUI

struct TextFieldView: View {
    
    @State var secondDiscountText: String
    
    @Binding var salesPrice: String
    @Binding var isAnimating: Bool
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 100)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                VStack {
                    TextField(secondDiscountText, text: $salesPrice)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 150, height: 300)
                        .disabled(isAnimating)
                }
                .padding()
            }
    }
}
