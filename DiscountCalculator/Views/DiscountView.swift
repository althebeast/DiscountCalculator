//
//  ContentView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 10.10.2024.
//

import SwiftUI

struct DiscountView: View {
    
    @State private var discountAmount = 0.0
    @State private var salesPrice = 0.0
    @State private var isAnimating = false
    @State private var animate = false
    @State private var showAlert = false
    
    @State private var resultOfDiscount: Double = 0.0
    @State private var youSavedAmount: Double = 0.0
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            
            backgroundColor()
            
            ZStack {
                HStack {
                    calculatedAmountView()
                }
                VStack(spacing: 40) {
                    
                    DiscountImageView()
                    
                    sliderView()
                        .offset(y: isAnimating ? -750 : 0)
                        .animation(.default, value: isAnimating)
                        .tint(.red)
                    
                    calculateButton()
                    
                    calculateAnotherAmountButton()
                }
                .padding()
                .onAppear(perform: addAnimation)
            }
        }
    }
    
    func calculateThePriceAfterDiscount() {
        let convertedPrice = salesPrice
        let convertedDiscount = discountAmount
        let convertedDiscountRate = convertedDiscount / 100
        let multiple = convertedPrice * convertedDiscountRate
        let final = convertedPrice - multiple
        resultOfDiscount = final
        
        let youSaved = convertedPrice - final
        youSavedAmount = youSaved
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    DiscountView()
}

extension DiscountView {
    private func backgroundColor() -> some View {
        LinearGradient(colors: [Color("Background2"), Color("Background1")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension DiscountView {
    private func DiscountImageView() -> some View {
        Image("discounts")
            .resizable()
            .frame(width: 200, height: 200)
            .rotationEffect(animate ? .degrees(-20) : .degrees(20))
            .rotationEffect(.degrees(-65))
            .offset(y: isAnimating ? -750 : 0)
            .animation(.default, value: isAnimating)
            .frame(maxWidth: .infinity)
            .padding(.leading, 50)
    }
}

extension DiscountView {
    private func sliderView() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 200)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                VStack(spacing: 15) {
                    HStack {
                        Text("0")
                        Slider(value: $discountAmount,
                               in: 0...100,
                               step: 5)
                        Text("100")
                    }
                    
                    Text("Discount Amount: \(discountAmount.formatted())%")
                    
                    HStack {
                        Text("0")
                        Slider(value: $salesPrice,
                               in: 0...20000,
                               step: 5)
                        Text("20.000")
                    }
                    
                    Text("Sales Price: \(salesPrice.formatted())$")
                }
                .foregroundStyle(.white)
                .padding()
            }
    }
}

extension DiscountView {
    
    private func calculatedAmountView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profits")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Price after discount: $\(String(resultOfDiscount))")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
            
            HStack {
                Image("saving")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("You saved: $\(youSavedAmount.formatted())")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .frame(width: screenSize.width / 1.1, height: 200)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
        .offset(x: isAnimating ? 0 : -550, y: screenSize.width / -4)
        .opacity(isAnimating ? 1 : 0)
        .animation(.easeInOut, value: isAnimating)
    }
}

extension DiscountView {
    
    private func calculateButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 100)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(content: {
                Text("Calculate The Discount")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
            })
            .offset(y: isAnimating ? 550 : 0)
            .animation(.default, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                    calculateThePriceAfterDiscount()
                    isAnimating.toggle()
                
            }
    }
}

extension DiscountView {
    private func calculateAnotherAmountButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 100)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(content: {
                Text("Calculate Another Discount")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
            })
            .opacity(isAnimating ? 1 : 0)
            .offset(x: isAnimating ? 0 : 550)
            .animation(.default, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                salesPrice = 0.0
                discountAmount = 0.0
                
                
                isAnimating.toggle()
            }
    }
}
