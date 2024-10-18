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
    @State var discountedPrice = ""
    
    @State var calculatedAmount: Int = 0
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        GeometryReader { geo in
                ZStack {
                    backgroundColor()
                    
                    VStack {
                        ZStack {
                            
                            calculatedAmountView()
                                .opacity(isAnimating ? 1 : 0)
                            
                            VStack(spacing: 20) {
                                
                                DiscountImageView()
                                
                                sliderView()
                                    .rotationEffect(Angle(degrees: isAnimating ? 220 : 0), anchor: .topLeading)
                                    .animation(.default, value: isAnimating)
                                
                                calculateButton()
                                
                                calculateAnotherAmountButton()
                                    .padding(.bottom, 70)
                                
                            }
                            .onAppear(perform: addAnimation)
                        }
                    }
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
        LinearGradient(colors: [Color("Background5"), Color("Background2")], startPoint: .top, endPoint: .bottom)
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
                let convertedDiscountedPrice = Double(discountedPrice) ?? 0
                let calculatedDiscount = 100 - discountAmount
                let calculatedDiscount2 = convertedDiscountedPrice / calculatedDiscount
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
                    .foregroundStyle(.white)
                    
                    Text("Discount Amount: \(discountAmount.formatted())%")
                        .foregroundStyle(.white)
                        .padding(.bottom)
                    
                    TextField("Discounted Price", text: $discountedPrice)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 250)
                        .disabled(isAnimating)
                }
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
        .offset(y: -100)
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
            .offset(y: -100)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                discountedPrice = ""
                discountAmount = 0.0
                
                
                isAnimating.toggle()
            }
    }
}
