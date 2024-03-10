//
//  HomeView.swift
//  Weather
//
//  Created by DonHalab on 07.03.2024.
//

import SwiftUI
import BottomSheet

struct HomeView: View {
    @State private var isPresented = true
    @State private var selectedDetent: BottomSheet.PresentationDetent = .medium
    @State var positionSheet: CGFloat = 0


    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                ZStack {
                    // MARK: - Backgound Color
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: - Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                    
                    // MARK: - House Image
                    Image("House")
                        .frame(maxHeight: .infinity,alignment: .top)
                        .padding(.top, 257)
                    
                    VStack(spacing: -10) {
                        Text("Челябинск")
                            .font(.largeTitle)
                        
                        VStack {
                            
                            Text(attributedString)
                            
                            Text("H:24°   L:18°")
                                .font(.title3.weight(.semibold))
                        }
                        Spacer()
                    }
                    .padding(.top, 51)
                    
                    // MARK: - Botton Sheet
                    
                    .sheetPlus(isPresented: $isPresented, background: Color.bottomSheetBackground.cornerRadius(44), onDrag: { translation in
                        positionSheet = translation / screenHeight
                 
            
                    }) {
                        ForecastView()
                            .frame(height: 700)
                            .presentationDetentsPlus([.height(350), .fraction(0.6), .medium, .fraction(1)], selection: $selectedDetent
                            )
                    }
                    
                    // MARK: - Tab Bar
                    TabBar(action: {
                        selectedDetent = .fraction(1)
                    })
                }
            }
            .toolbar(.hidden)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°" + "\n " + "Чистое небо")
        
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
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
