//
//  Home.swift
//  SwiftApp
//
//  Created by Sonesra, Iyan M on 2/8/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack{
            Text("Animals")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,alignment: .center)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    //Card's
                    
                    ForEach(cards) {card in
                        CardView(card: card)
                    }
                }
            }
        }
        .padding([.horizontal, .top])
    }
    
    //Card View
    @ViewBuilder
    func CardView(card: Card)->some View {
        GeometryReader{proxy in
            
            ZStack(alignment: .topLeading) {
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
               
              
                VStack(alignment: .leading, spacing: 40) {
                    Text(card.name)
                        .fontWeight(.bold)
                        .font(.title)
        
                    
                    Text(card.cardNumber)
                        .font(.callout)
                        .fontWeight(.bold)
                }
                
                .padding()
                .padding(.bottom,10)
            }
            .cornerRadius(10) // Adjust the corner radius as needed
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Add a drop shadow
            
        }
        
        .frame(height: 200)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
