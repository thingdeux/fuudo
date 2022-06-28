//
//  CircularImageView.swift
//  fuudo

import SwiftUI

struct CircularImageView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            Color.black
            
            Circle()
                .fill(Color.lightPrimaryColor)
                .padding(4)
                            
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Image("defaultFoodImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
        }
        .clipped()
        .clipShape(Circle())
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea(.container, edges: .vertical)
            
            VStack {
                CircularImageView(image: Image("donutImage"))
                    .frame(width: 200, height: 200)
                
                CircularImageView(image: nil)
                    .frame(width: 100, height: 100)
            }
        }
        .background(Color.primaryColor)
        .frame(width: .infinity, height: .infinity)
    }
}
