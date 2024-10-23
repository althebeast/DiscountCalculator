//
//  ContentView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 10.10.2024.
//

import SwiftUI

struct DiscountView: View {
    
    @State private var discountAmount = 0.0
    @State private var salesPrice = ""
    @State private var isAnimating = false
    @State private var animate = false
    
    @State private var resultOfDiscount: Double = 0.0
    @State private var youSavedAmount: Double = 0.0
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
            VStack {
                ZStack {
                    
                    backgroundColor()
                    
                    ZStack {
                        HStack {
                            calculatedAmountView()
                        }
                        VStack(spacing: 40) {
                            
//                            tipJarView()
                            
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
            .onTapGesture {
                hideKeyboard()
            }
    }
    
    func calculateThePriceAfterDiscount() {
        let convertedPrice = Double(salesPrice) ?? 0
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

// Extension to hide the keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension DiscountView {
    private func backgroundColor() -> some View {
        LinearGradient(colors: [Color("Background5"), Color("Background3")], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension DiscountView {
    private func DiscountImageView() -> some View {
        Image("discounts")
            .resizable()
            .frame(width: 150, height: 150)
            .rotationEffect(animate ? .degrees(-20) : .degrees(20))
            .rotationEffect(.degrees(-65))
            .offset(y: isAnimating ? -750 : 20)
            .animation(.default, value: isAnimating)
            .frame(maxWidth: .infinity)
            .padding(.leading, 50)
    }
}

extension DiscountView {
    private func tipJarView() -> some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "heart.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            
            Spacer()
        }
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
                    .foregroundStyle(.white)
                    
                    Text("Discount Amount: \(discountAmount.formatted())%")
                        .padding(.bottom)
                        .foregroundStyle(.white)
                    
                    TextField("Sales Price", text: $salesPrice)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 250)
                        .disabled(isAnimating)
                }
                
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
                Text("Price after discount: $\(resultOfDiscount.formatted())")
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
        .offset(x: isAnimating ? 0 : -550, y: -100)
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
            .offset(x: isAnimating ? 0 : 550, y: -150)
            .animation(.default, value: isAnimating)
            .onTapGesture {
                // here we will calculate the discount and make animations.
                salesPrice = ""
                discountAmount = 0.0
                
                
                isAnimating.toggle()
            }
    }
}
