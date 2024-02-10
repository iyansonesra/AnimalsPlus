//
//  Home.swift
//  SwiftApp
//
//  Created by Sonesra, Iyan M on 2/8/24.
//

import SwiftUI

struct Home: View {
    @State var expandCards: Bool = false
    
    // Detail View Properties
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            Text("Animals")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,alignment: expandCards ? .leading : .center)
                .overlay(alignment: .trailing) {
                    
                    //Close button
                    Button {
                        //closing it
                        withAnimation(
                            .interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                                expandCards = false
                            }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue, in: Circle())
                    }
                    .rotationEffect(.init(degrees: expandCards ? 45 : 0))
                    .offset(x: expandCards ? 10 : 15)
                    .opacity(expandCards ? 1 : 0)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    //Card's
                    
                    ForEach(cards) {card in
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation(
                                    .easeInOut(duration: 0.35)) {
                                        currentCard = card
                                        showDetailCard = true
                                    }
                            }
                    }
                }
                .overlay{
                    Rectangle()
                        .fill(.black.opacity(expandCards ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                expandCards = true
                            }
                        }
                }
                .padding(.top, expandCards ? 30 : 0)
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 0 : 30)
            
            //add button
            //Close button
            Button {
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(.blue, in: Circle())
            }
            .rotationEffect(.init(degrees: expandCards ? 180 : 0))
            // To Avoid Warning 0.01
            .scaleEffect(expandCards ? 0.01 : 1)
            .opacity(!expandCards ? 1 : 0)
            .frame(height: expandCards ? 0 : nil)
            .padding(.bottom, expandCards ? 0 : 30)
            
            
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if let currentCard = currentCard, showDetailCard {
                DetaiView(currentCard: currentCard, showDetaiCard: $showDetailCard)
            }
        }
    }
    
    //Card View
    @ViewBuilder
    func CardView(card: Card)->some View {
        GeometryReader{proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            
            let offset = CGFloat(getIndex(Card: card)*(expandCards ? 10 : 70))
            
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
                .foregroundColor(.black)
            }
            
            //Making it as a stack
           
            .cornerRadius(20) // Adjust the corner radius as needed
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 8, y: 2) // Add a drop shadow
            
            .frame(width: proxy.size.width + 4, height: proxy.size.height + 4)
            .offset(y: expandCards ? offset : -rect.minY + offset)
            
        }
        
        .frame(height: 200)
    }
    
    func getIndex(Card: Card) ->Int{
        return cards.firstIndex() { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
    
    //Mark: Hiding al
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//Detail View
struct DetaiView: View {
    var currentCard: Card
    @Binding var showDetaiCard: Bool
    var body: some View{
        
        VStack{
           CardView()
                .frame(height: 200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func CardView()->some View{
        ZStack(alignment: .topLeading) {
            Image(currentCard.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
           
          
            VStack(alignment: .leading, spacing: 40) {
                Text(currentCard.name)
                    .fontWeight(.bold)
                    .font(.title)
    
                
                Text(currentCard.cardNumber)
                    .font(.callout)
                    .fontWeight(.bold)
            }
            
            .padding()
            .padding(.bottom,10)
            .foregroundColor(.black)
        }
    }
}
