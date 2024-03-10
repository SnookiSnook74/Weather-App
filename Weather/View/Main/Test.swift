//
//  Test.swift
//  Weather
//
//  Created by DonHalab on 09.03.2024.
//

import SwiftUI
import BottomSheet

struct ContentViews: View {
    @State private var isPresented = true
    @State private var selectedDetent: BottomSheet.PresentationDetent = .medium

    var body: some View {
        // Кнопка для показа BottomSheet
        VStack {
           
        }
        .sheetPlus(isPresented: $isPresented, background: Color.red,  main: {
            // Основной контент BottomSheet
                Text("Перетащи меня")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            .presentationDetentsPlus(
                [.height(200), .fraction(0.4), .fraction(0.6), .fraction(1)],
                selection: $selectedDetent
            )
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViews()
    }
}
