//
//  ContentView.swift
//  Final Project
//
//  Created by Macbook Air on 24/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    var totalPages = 3
    
    var body: some View {
        
        if currentPage > totalPages{
            SingIn()
        }
        else{
            WalkthroughScreen()
        }
        
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// sign in page
struct SingIn: View{
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View{
        NavigationView{
            
            VStack{
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                
                Image("Picture111")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 350)
                    .clipped()
                    .cornerRadius(150)
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                    .shadow(radius: 5)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10)
                    .shadow(radius: 5)
                
                Button(action: {},
                       label: { Text("LOGIN")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(23)
                })
                
                VStack {
                    Text("Create Account")
                        .font(.title2)
                    NavigationLink(destination: contentViewRegister()) {
                        Text("Register")
                            .font(.title2)
                    }
                }
                .padding(.bottom, 35)
            }
            //     .navigationBarHidden(true)
            .padding()
            
        }
    }
}
struct Location {
    static let allLocations = [
        "Al Asimah",
        "Jahra",
        "Hawalli",
        "Farwaniyah",
        "Mubarak Al-Kabeer",
        "Al-Ahmadi"
    ]
}
struct contentViewRegister: View {
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var location = ""
    @State private var termsAccepted = false
    @State private var age = 20
    @State var athome = false
    var body: some View {
        //  NavigationView {
        if !athome{
            
            Form {
                
                Section(header: Text("Register")) {
                    TextField("Firstname",
                              text: $firstname)
                    TextField("Lastname",
                              text: $lastname)
                    Picker(selection: $location,
                           label: Text("Location")) {
                        ForEach(Location.allLocations, id: \.self) { location in
                            Text(location).tag(location)
                        }
                    }
                    Toggle(isOn: $termsAccepted,
                           label: {
                        Text("Accept terms and conditions")
                    })
                    Stepper(value: $age,
                            in: 7...100,
                            label: {
                        Text("Current age: \(self.age)")
                    })
              //      NavigationLink(destination: BooksView(), label: {
                        Text("               Register      ")
                        .foregroundColor(.blue)
                        .font(.title)
                    
                        
                   
                    .padding()
                    .onTapGesture {
                        athome = true
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.automatic)
            //  .ignoresSafeArea()
            
            
            //   }
            
            
        } else{
            BooksView()
        }
    }
}
// Walkthrough Screen
struct WalkthroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1
    var totalPages = 3
    var body: some View{
        ZStack{
            if currentPage == 1{
                Screenview(image: "Picture111", title: "", detail: " Read, Review, gain the knowledge", bgColor:("color1"))
                    .transition(.scale)
                    .font(.title)
                    .foregroundColor(.blue)
            }
            if currentPage == 2{
                Screenview(image: "Picture22", title: "", detail: "Rate and review your favorite books", bgColor:("color1"))
                    .transition(.scale)
                    .foregroundColor(.pink)
                    .font(.title)
            }
            if currentPage == 3{
                Screenview(image: "Picture33", title: "", detail: " Exchange your books with nearby people", bgColor:("color1"))
                    .font(.title)
                    .transition(.scale)
            }
        }
        .overlay(
            //Button goes here
            Button(action: {
                // changing views
                withAnimation(.easeInOut(duration: 0.4)) {
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                    else{
                        currentPage = 1
                    }
                }
                
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(.white)
                    .clipShape(Circle())
                
                //     .foregroundColor(.white)
                //here goes circular slider
                    .overlay(
                        ZStack{
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
            })
            .padding(.bottom,20)
            ,alignment: .bottom
            
        )
    }
}

struct Screenview: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: String
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                // showing hello only at first page
                if currentPage == 1{
                    Text("Hello member")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                }
                else{
                    // in further pages will be back button
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                    
                }
                
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundColor(.black)
            .padding()
            Spacer(minLength: 0)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            Text(detail)
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            Spacer(minLength: 120)
        }
        .background(
            Image(bgColor)
                .resizable()
                .cornerRadius(10)
                .ignoresSafeArea()
        )
        //  .background(bgColor.ignoresSafeArea())
    }
}
// total pages
// var totalPages = 3



