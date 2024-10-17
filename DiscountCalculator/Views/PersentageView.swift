//
//  PersentageView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 13.10.2024.
//

import SwiftUI

struct PersentageView: View {
    
    @State var isAnimating: Bool = false
    @State var animate = false
    @State var showAlert = false
    @State var discountAmount = 0.0
    @State var discountedPrice = 0.0
    
    @State var calculatedAmount: Int = 0
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            backgroundColor()
            
            ZStack {
                
                calculatedAmountView()
                    .opacity(isAnimating ? 1 : 0)
                    .padding(.bottom, 30)
                
                VStack(spacing: 40) {
                    
                    DiscountImageView()
                    
                    sliderView()
                        .rotationEffect(Angle(degrees: isAnimating ? 220 : 0), anchor: .topLeading)
                        .animation(.default, value: isAnimating)
                    
                    calculateButton()
                    
                    calculateAnotherAmountButton()
                }
                .onAppear(perform: addAnimation)
            }
        }
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
    PersentageView()
}

extension PersentageView {
    private func backgroundColor() -> some View {
        LinearGradient(colors: [Color("Background3"), Color("Background4")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension PersentageView {
    private func DiscountImageView() -> some View {
        Image("price-tag")
            .resizable()
            .frame(width: 200, height: 200)
            .scaleEffect(animate ? 1.2 : 1)
            .offset(y: isAnimating ? -750 : 0)
            .animation(.default, value: isAnimating)
            .frame(maxWidth: .infinity)
    }
}

extension PersentageView {
    
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
            .rotationEffect(Angle(degrees: isAnimating ? 220 : 0), anchor: .bottomTrailing)
            .offset(x: isAnimating ? 30 : 0)
            .animation(.default, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                let calculatedDiscount = 100 - discountAmount
                let calculatedDiscount2 = discountedPrice / calculatedDiscount
                let result = calculatedDiscount2 * 100
                calculatedAmount = Int(result)
                
                isAnimating.toggle()
            }
    }
}

extension PersentageView {
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
                        Slider(value: $discountedPrice,
                               in: 0...20000,
                               step: 5)
                        Text("20.000")
                    }
                    
                    Text("Discounted Price: \(discountedPrice.formatted())$")
                }
                .foregroundStyle(.white)
                .padding()
            }
    }
}

extension PersentageView {
    
    private func calculatedAmountView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profits")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Original price before discount is \(calculatedAmount.formatted())$")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .frame(width: screenSize.width / 1.1, height: 200)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .animation(.easeInOut, value: isAnimating)
    }
}

extension PersentageView {
    private func calculateAnotherAmountButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: screenSize.width / 1.1, height: 100)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(content: {
                Text("Calculate Another Original Price")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
            })
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeInOut, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                discountedPrice = 0.0
                discountAmount = 0.0
                
                
                isAnimating.toggle()
            }
    }
}
