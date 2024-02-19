//
//  Home.swift
//  SwiftApp
//
//  Created by Sonesra, Iyan M on 2/8/24.
//
import SwiftUI
import ARKit
import SceneKit
import RealityKit
struct Home: View {
    
    init() {
            // Ensure light mode
            UITraitCollection.current = UITraitCollection(traitsFrom: [UITraitCollection(displayScale: 2), UITraitCollection(userInterfaceStyle: .light)])
        }
    @State var expandCards: Bool = false
    @State private var isPresentingARView = false
    
    // Detail View Properties
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0){
            Text("Animals+")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity,alignment: expandCards ? .leading : .center)
                .foregroundColor(Color.clear)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.black]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .mask(Text("Animals+")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: expandCards ? .leading : .center)
                    )
                .overlay(alignment: .trailing) {
                    
//                    Close button
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
                        Group{
                            if currentCard?.id == card.id && showDetailCard{
                               CardView(card: card)
                                    .opacity(0)
                            } else {
                                CardView(card: card)
                                    .matchedGeometryEffect(id: card.id, in: animation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
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
                isPresentingARView = true;
            } label: {
                Text("Explore")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                                RoundedRectangle(cornerRadius: 40) // Adjust cornerRadius as needed
                                    .fill(Color.blue)
                            )
            }
            .sheet(isPresented: $isPresentingARView) {
                            ARViewContainer()
                               
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
                DetaiView(currentCard: currentCard, showDetaiCard: $showDetailCard, animation: animation)
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
    //Matched geometry effect
    var animation: Namespace.ID
    
    //Delaying extra details view
    
    @State var showExpenseView: Bool = false
    var body: some View{
        
        VStack{
           CardView()
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .frame(height: 200)
                .onTapGesture {
                    //Cloding detail view
                    withAnimation(.easeInOut) {
                        showExpenseView = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            showDetaiCard = false
                        }
                    }
                   
                }
                .zIndex(10)
            
         
            VStack{
                
                Spacer()
                HStack{
                    Spacer()
                    GeometryReader{proxy in
                        
                        let height = proxy.size.height + 50
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing:13) {
                                Text("Class")
                                    .font(.title2)
                                    .fontWeight(.light)
                                    .padding(.top, 15)
                                
                                Text(currentCard.cardClass)
                                    .font(.title3)
                                    .italic()
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 30)
                                    .multilineTextAlignment(.center)
                                
                            }
                            
                            
                        }
                        .frame(maxWidth: 180, maxHeight: 100)
                        .background(
                            Color.white
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .ignoresSafeArea()
                        )
                        .offset(y: showExpenseView ? 0 : height)
                    }
                    .padding(.trailing, 10)
                    
                    Spacer()
                    GeometryReader{proxy in
                        
                        let height = proxy.size.height + 50
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 13) {
                                Text("Height")
                                    .font(.title2)
                                    .fontWeight(.light)
                                    .padding(.top, -2)
                                
                                Text(currentCard.cardHeight)
                                    .font(.title3)
                                    .italic()
                                    .lineLimit(1)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 30)
                                    .multilineTextAlignment(.center)
                            }
                            
                            .padding()
                        }
                        .frame(maxWidth: 178, maxHeight: 100)
                        .background(
                            Color.white
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .ignoresSafeArea()
                        )
                        .offset(y: showExpenseView ? 0 : height)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, -20)
                
                Spacer()
                GeometryReader{proxy in
                    
                    let height = proxy.size.height + 20
                    let width = proxy.size.width / 2
                    let offset = (proxy.size.width - 340) / 2
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            Text("Location")
                                .font(.title3)
                                .fontWeight(.light)
                                .padding(.top, 10)
                       
                            
                            Text(currentCard.cardAbout)
                                .font(.subheadline)
                                .italic()
                                .padding(.top, -12)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                                .multilineTextAlignment(.center)
                            
                        }
                        
                   
                    }
                    .frame(maxWidth: 340, maxHeight: 170)
                    .background(
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .ignoresSafeArea()
                    )
                    .offset(x: offset, y: showExpenseView ? 0 : height)
                }
                .padding(.vertical, -85)
                
                Spacer()
                GeometryReader{proxy in
                    
                    let height = proxy.size.height + 20
                    let width = proxy.size.width / 2
                    let offset = (proxy.size.width - 340) / 2
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            Text("Fun Facts")
                                .font(.title3)
                                .fontWeight(.light)
                                .padding(.top, 10)
                            
                            Text(currentCard.cardFun)
                                .font(.subheadline)
                                .italic()
                                .padding(.top, -12)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .padding(.horizontal, 30)
                                .multilineTextAlignment(.leading)
                        }
                        
                   
                    }
                    .frame(maxWidth: 340, maxHeight: 230)
                    .background(
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .ignoresSafeArea()
                    )
                    .offset(x: offset, y: showExpenseView ? 0 : height)
                }
                .padding(.vertical, -80)
            }
            
           
            
            
            
            
            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("BG").ignoresSafeArea())
        .onAppear() {
            withAnimation(.easeInOut.delay(0.1)) {
                showExpenseView = true;
            }
        }
    }
    
    @ViewBuilder
    func CardView()->some View{
        ZStack(alignment: .topLeading) {
            Image(currentCard.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
           
          
            VStack(alignment: .leading, spacing: 40) {
                Text(currentCard.name)
                    .fontWeight(.bold)
                    .font(.title)
    
                
                
            }
            
            .padding()
            .padding(.bottom,5)
            .foregroundColor(.black)
           
        }
      
    }
      
}
struct ARViewContainer: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ARViewController {
        let arVC = ARViewController()
        return arVC
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // Update your ARKit scene if needed
    }
}

