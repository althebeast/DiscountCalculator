//
//  RateView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 23.10.2024.
//

import SwiftUI

struct RateView: View {
    
    @State private var salesPrice = ""
    @State private var discountedPrice = ""
    @State private var isAnimating = false
    @State private var calculatedRateResult = 0
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            backgroundColor()
            
            ZStack {
                
                VStack {
                    calculatedAmountView()
                    calculateAnotherAmountButton()
                }
                
                VStack(spacing: 40) {
                    textFields()
                    
                    calculateButton()
                }
            }
        }
    }
}

#Preview {
    RateView()
}

// Extension to hide the keyboard
extension View {
    func hideKeyboardRateView() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension RateView {
    private func backgroundColor() -> some View {
        LinearGradient(colors: [Color("Background5"), Color("Background2")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension RateView {
    private func textFields() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 200)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                VStack(spacing: 50) {
                    TextField("Original Price", text: $salesPrice)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 200)
                        .disabled(isAnimating)
                    
                    TextField("Discounted Price", text: $discountedPrice)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 200)
                        .disabled(isAnimating)
                }
                .padding()
            }
            .scaleEffect(isAnimating ? 0 : 1)
            .animation(.default, value: isAnimating)
    }
}

extension RateView {
    
    private func calculateButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 100)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(content: {
                Text("Calculate The Original Price")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
            })
            .scaleEffect(isAnimating ? 0 : 1)
            .animation(.default, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                
                let convertedSales = Double(salesPrice) ?? 0.0
                    let convertedDiscounted = Double(discountedPrice) ?? 0.0
                    
                    if convertedSales > 0 {
                        let discountRate = ((convertedSales - convertedDiscounted) / convertedSales) * 100
                        calculatedRateResult = Int(discountRate)  // Convert to integer if needed
                    } else {
                        calculatedRateResult = 0
                    }
                    
                    isAnimating.toggle()
            }
    }
}

extension RateView {
    
    private func calculatedAmountView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profits")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("The discount rate is %\(calculatedRateResult)")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .frame(width: screenSize.width / 1.1, height: 200)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
        .scaleEffect(isAnimating ? 1 : 0)
        .animation(.default, value: isAnimating)
    }
}

extension RateView {
    private func calculateAnotherAmountButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 100)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(content: {
                Text("Calculate The Rate")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
            })
            .scaleEffect(isAnimating ? 1 : 0)
            .animation(.default, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                salesPrice = ""
                discountedPrice = ""
                
                
                isAnimating.toggle()
            }
    }
}

