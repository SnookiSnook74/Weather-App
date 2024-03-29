//
//  HomeView.swift
//  Weather
//
//  Created by DonHalab on 07.03.2024.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition:CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385
}

struct HomeView: View {
    @State private var isPresented = true
    @State private var selectedDetent: BottomSheet.PresentationDetent = .fraction(BottomSheetPosition.middle.rawValue)
    @State var bottomSheetTraslation : CGFloat = BottomSheetPosition.middle.rawValue
    @State var hasDrag: Bool = false
    var bottomSheetTranlationProperty: CGFloat {
        (bottomSheetTraslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageIfSet = screenHeight + 36
                ZStack {
                    // MARK: - Backgound Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: - Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranlationProperty * imageIfSet)
                    
                    // MARK: - House Image
                    Image("House")
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top, 385)
                        .offset(y: -bottomSheetTranlationProperty * imageIfSet)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranlationProperty)) {
                        Text("Челябинск")
                            .font(.largeTitle)
                        
                        VStack {
                            
                            Text(attributedString)
                            
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranlationProperty)
                        }
                        Spacer()
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranlationProperty * 46)
                    
                    // MARK: - Botton Sheet
                    
                    .sheetPlus(isPresented: $isPresented, background: Color.bottomSheetBackground.cornerRadius(44), onDrag: { translation in
                        bottomSheetTraslation = translation / screenHeight
                       // print(bottomSheetTranlationProperty.formatted())
                        
                        withAnimation(.easeInOut) {
                            if selectedDetent == BottomSheet.PresentationDetent.fraction(0.9) {
                                hasDrag = true
                            } else {
                                hasDrag = false
                            }
                        }
            
                    }) {
                        ForecastView(bottomSheetTraslationProerty: bottomSheetTranlationProperty)
                            .frame(height: 600)
                            .presentationDetentsPlus([.height(385), .fraction(0.6), .medium, .fraction(0.9)], selection: $selectedDetent
                            )
                    }
                    
                    // MARK: - Tab Bar
                    TabBar(action: {
                        selectedDetent = .fraction(0.9)
                    })
                    .offset(y: bottomSheetTranlationProperty * 115)
                }
            }
            .toolbar(.hidden)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + (hasDrag ? " | " : "\n ") + "Чистое небо")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: (96 - (bottomSheetTranlationProperty * (80 - 20))), weight: .thin)
            string[temp].foregroundColor = hasDrag ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranlationProperty)
        }
        
        if let weather = string.range(of: "Чистое небо") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
