//
//  TabView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 13.10.2024.
//

import SwiftUI

struct PagesTabView: View {
    var body: some View {
        
        TabView {
            
            DiscountView()
            
            PersentageView()
            
            RateView()
            
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
        }
    }
            


#Preview {
    PagesTabView()
}
