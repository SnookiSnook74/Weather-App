//
//  ForecastView.swift
//  Weather
//
//  Created by DonHalab on 10.03.2024.
//

import SwiftUI

struct ForecastView: View {
    
    var bottomSheetTraslationProerty: CGFloat = 1
    
    var body: some View {
        ScrollView {
        }
        .backgroundBlur(radius: 25, opaque: true)
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innderShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWigdth: 1, offsetX: 0, offsetY: 1, blur: 0, blendMode:  .overlay, opacity: 1 - bottomSheetTraslationProerty)
       
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            // MARK: - Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ForecastView()
        .background(Color.background)
        .preferredColorScheme(.dark)
}
