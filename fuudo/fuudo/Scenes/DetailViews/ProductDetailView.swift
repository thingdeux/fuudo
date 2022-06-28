//
//  ProductDetailView.swift
//

import SwiftUI
import fuudoAPI

struct ProductDetailView: View {
    let product: BadgeDisplayable
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea(.container, edges: .vertical)
                        
            if let product = product as? Product {
                GeometryReader { proxy in
                    HStack {
                        VStack {
                            Text("Ingredients")
                                .font(.custom(Font.bookBoldName, size: 20, relativeTo: .body))
                                .bold()
                                .foregroundColor(Color.lightBackgroundColor)
                                .padding(.bottom)
                            
                            IngredientsView(ingredients: product.ingredients)
                        }
                        .frame(width: proxy.size.width * 0.60, height: proxy.size.height)
                        
                        Rectangle()
                            .fill(Color.primaryTextColor)
                            .frame(width: 1, height: proxy.size.height)
                            .padding(.vertical)
                        
                        VStack {
                            Text("Dietary")
                                .font(.custom(Font.bookBoldName, size: 20, relativeTo: .body))
                                .bold()
                                .foregroundColor(Color.lightBackgroundColor)
                                .padding(.bottom)
                            
                            IngredientsView(ingredients: product.dietaryFulfillments.map({ $0.rawValue.capitalized }))
                        }
                    }
                }
            } else {
                Image(systemName: "xmark.octagon")
                    .font(.largeTitle)
            }
            
            VStack {
                Text("Unfinished")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.red)
                Text("🥹")
            }
        }
    }
}

private struct HeaderView: View {
    var body: some View {
        ZStack {
            Color.primaryColor
        }
    }
}

private struct IngredientsView: View {
    let ingredients: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(ingredients, id: \.self) { name in
                HStack {
                    Image(systemName: "diamond.fill")
                        .font(.body)
                    
                    Text(name)
                }
            }
            Spacer()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Mocks.mockProduct)
    }
}
