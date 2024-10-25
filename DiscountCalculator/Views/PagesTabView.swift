//
//  TabView.swift
//  DiscountCalculator
//
//  Created by Alperen Sarışan on 13.10.2024.
//

import SwiftUI

struct PagesTabView: View {
    
    enum Tab: String, CaseIterable {
            case first = "Discount"
            case second = "Original Price"
            case third = "Calculate Rate"
        }
    
    init() {
            
        UISegmentedControl.appearance().backgroundColor = UIColor(named: "Background5")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "Background5")!], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)

        }
    
    @State private var selectedTab: Tab = .first
    
    var body: some View {
        
//        TabView {
//            
//            DiscountView()
//            
//            PersentageView()
//            
//        }
//        .tabViewStyle(.page)
//        .ignoresSafeArea()
//        }
//    }
        
        ZStack {
            
            if selectedTab == .first {
                Color("Background5")
                    .ignoresSafeArea()
            } else if selectedTab == .second {
                Color("Background5")
                    .ignoresSafeArea()
            } else {
                Color("Background5")
                    .ignoresSafeArea()
            }
            
            GeometryReader { geo in
                VStack {
                    // Segmented picker
                    Picker("Select Tab", selection: $selectedTab) {
                        ForEach(Tab.allCases, id: \.self) { tab in
                            Text(tab.rawValue).tag(tab)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Content view based on the selected tab
                    VStack {
                        switch selectedTab {
                        case .first:
                            DiscountView()
                        case .second:
                            PersentageView()
                        case .third:
                            RateView()
                        }
                    }
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
                }
            }
        }
            }
        }
            


#Preview {
    PagesTabView()
}
