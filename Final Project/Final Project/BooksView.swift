//
//  BooksView.swift
//  Final Project
//
//  Created by Macbook Air on 26/09/2022.
//

import SwiftUI

struct BooksView: View {
    var body: some View {
       NavigationView{
            CustomTabView()
//                .navigationTitle("")
//                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)

        }
        
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
     
    }
}

struct CustomTabView : View {
    @State var selectedTab = "home"
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            // using tab view for swipe gesture
            
            TabView(selection: $selectedTab) {
                
                Home()
                    .tag("house")
                Exchange()
                    .tag("arrow.up.right.and.arrow.down.left.rectangle")
                
                Account()
                    .tag("person.circle.fill")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            // for bottom overflow
            
            HStack(spacing: 0){
                ForEach(tabs,id: \.self) {image in TabButton(image: image, selectedTab: $selectedTab)
                    // for equal spacing
                    if image != tabs.last{
                        Spacer(minLength: 0)
                    }
                    
                }
                
            }
            .padding(.horizontal,25)
            .padding(.vertical,5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.25), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.25), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
}
// tabs
// image names
var tabs = ["house", "arrow.up.right.and.arrow.down.left.rectangle", "person.circle.fill"]
struct TabButton : View {
    var image : String
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {selectedTab = image}) {
            Image(systemName: image)
                .resizable()
                .frame(width: 23, height: 23)
    //            .renderingMode(.template)
                .foregroundColor(selectedTab == image ? Color("tab") :
                                    Color.black.opacity(0.4))
                .padding()
        }
    }
}
struct Home : View{
    @State var txt = ""
    var body: some View{
    
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    Text("Hello member")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Let's review your books")
                }
                .foregroundColor(.black)
                Spacer(minLength: 0)
                Button(action: {}) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 50, height: 50)
                }
            }
           .padding(.all ,12)
       
         
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Books", text: $txt)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Capsule())
                    HStack{
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer(minLength: 0)
                        Button(action: {}) {
                            Text("View All")
                        }
                    }.foregroundColor(.black)
                        .padding(.all, 5)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 5){
                        ForEach(books){Book in
                            NavigationLink(destination: DetailView(book: Book)) {
                                BookCardView(book: Book)
                            }
                        }
                   //  .padding(.top)
                }
                .padding()
            }
        }
                    .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
    }
}
    //
}
struct BookCardView : View {
    var book : Book
    var body: some View{
        VStack{
            VStack{
                Image(book.assest)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                 //   .padding(.top,10)
                 //   .padding(.leading,10)
                HStack{
                    VStack(alignment: .leading, spacing: 12){
                        Text(book.name)
                            .font(.title3)
                        Text(book.author)
                    }
                    .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
          //  Spacer(minLength: 0)
        }
    }
}
// TabsViews
struct Type {
    static let alltypes = [
        "Classic",
        "Historical Fiction",
        "Horror",
        "Science",
        "Fantasy"
    ]
}
struct Exchange : View {
    @State var title = ""
    @State var writer = ""
    @State var description = ""
    @State private var type = ""
    @State var condidtion = ""
    
    var body: some View{
        
        Form {
            
            Section(header: Text("Exchange your book!").font(.title3)) {
                    TextField("Title",
                        text: $title)
                    .font(.title2)
                    TextField("Author",
                        text: $writer)
                    .font(.title2)
                Picker(selection: $type,
                       label: Text("Book Type").font(.title2)) {
            ForEach(Type.alltypes, id: \.self) {type in
            Text(type).tag(type)
                                                      }
                                              }
                TextField("Book condition", text: $condidtion)
                    .font(.title2)
                HStack{
                Text("Add book photo ")
                    
                       Spacer()
                    Button(action: {}, label: {  Image(systemName: "plus.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)})
               
                     
                }}
                Button(action: {}, label: {
                    Text("          Sumbit!!")
                        .font(.largeTitle)
                        .clipped()
                      //  .padding()
                })
                
                    .padding()
                           }
        
    }
    
}

struct Account : View {
    @State var bio = ""
    var body: some View{
        
        VStack{
            
            VStack{
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.all, 30)
                Text("Farah Maher")
                    .font(.title)
                    .bold()
            }
            Spacer(minLength: 0).frame(height: 30)
            VStack(alignment: .leading, spacing: 12){
                HStack{
                    Image(systemName: "envelope")
                    Text("farahmaher@email.com")
                }
            }
                Spacer().frame(height: 30)
                VStack{
                Text("Bio")
                TextField("Write your bio", text: $bio)
                        .multilineTextAlignment(.center)
                }
            Spacer(minLength: 0).frame(height: 30)
            VStack{
              
            Button{
                    print("Button tapped")
                } label: {
                   Text("Update Profile")
                        .bold()
                        .frame(width: 260, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                Spacer(minLength: 0).frame(height: 30)
                }
        }
       
            }
        }
   // }

// Books data
struct Book : Identifiable{
    var id = UUID()
        .uuidString
    var name : String
    var assest : String
    var author : String
    var des : String
}
var books = [
Book(name: "Atomic Habits", assest: "atomicHabit", author: "James Clear", des: "Atomic Habits  provides a practical and proven framework for creating good habits and shedding bad ones. Drawing on scientific research and real-life examples, it shows how tiny changes in behavior can result in the formation of new habits and help you achieve big things."),
Book(name: "A Thousand Splendid suns", assest: "thousandSund", author: "Khaled Hosseini", des: "A Thousand Splendid Suns is a breathtaking story set against the volatile events of Afghanistan’s last thirty years—from the Soviet invasion to the reign of the Taliban to post-Taliban rebuilding—that puts the violence, fear, hope, and faith of this country in intimate, human terms."),
Book(name: "Kite Runner", assest: "kiteRunner", author: "Khaled Hosseini", des: "The Kite Runner tells the extraordinary story of an unlikely friendship between a wealthy Afghan boy, named Amir, and Hassan, the son of his father’s servant  who he later finds out, after Hassan’s death, has always been his half-brother."),
Book(name: "The Little Women", assest: "LittleWomen", author: "Louisa May Alcott", des: "The novel follows the lives of four sisters—Meg, Jo, Beth, and Amy March—detailing their passage from childhood to womanhood, and is loosely based on the author and her three sisters.Little Women was an immediate commercial and critical success, and readers demanded to know more about the characters. "),
Book(name: "The Little Prince", assest: "thelittleprince", author: "Antoine de Saint-Exupéry's",des: "The Little Prince is an honest and beautiful story about loneliness, friendship, sadness, and love. The prince is a small boy from a tiny planet (an asteroid to be precise), who travels the universe, planet-to-planet, seeking wisdom. On his journey, he discovers the unpredictable nature of adults."),
Book(name: "الطنطورية", assest: "ghada", author: "رضوى عاشور", des: "تروي رواية الطنطورية أحداثًا تاريخية عاشتها فلسطين، بدأت الرواية باستقرار الوضع وتغير بمجرد انتشار قرار تقسيم فلسطين، وبعد هذا التقسيم ستدخل كل من الطنطورية وخط الساحل من جنوب عكا إلى جنوب يافا إلى منطقة اليهود."),
Book(name: "عائد الى حيفا", assest: "ghassan", author: "غسان كنفاني ", des: "تجسد حب كنفاني للعودة إلى بلده، فهي تدور بمعظمها في الطريق إلى حيفا عندما يقرر سعيد وزوجته الذهاب إلى هناك، وتفقد بيتهما الذي تركاه وفيه طفل رضيع أثناء معركة حيفا عام 1948. وتعطي الرواية حيزاً كبيراً للمفهوم الذهبي للوطنية والمواطنة وتبين من خلال التداعي قسوة الظروف التي أدت إلى مأساة عائلة سعيد وتطرح مفهوماً مختلفاً عما كان سائداً لمعنى الوطن في الخطاب الفلسطيني")
]
//}
struct DetailView : View {
    var book : Book
    
@State var selectedStar = -1
@State var message = false
@State private var review = ""
    var body: some View{
        ScrollView{
           
        VStack{
           
            Image(book.assest)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400)
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
        
            Text(book.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
          
            Text("Book Description")
            
                .font(.title2)
                .frame(width: 190, height: 10)
                .padding()
                .foregroundColor(.gray)
            Text(book.des)
                .font(.body)
                .multilineTextAlignment(.center)
            
            HStack{
                Text("Rating")
                    .font(.title2)
                    .padding()
                    Spacer()
                    .padding()
                HStack{
                    RatingView(selectedStar: $selectedStar, message: $message)
                       
                }
            }
            .alert(isPresented: $message) {
                Alert(title: Text("Rating Sumit"), message: Text("You Rated \(self.selectedStar + 1) out of 5 Star"), dismissButton: .none)
                
            }
            VStack{
                Text("Submit Your Review!")
                    .font(.title2)
                    .padding()
                textEditorVw
                submitBtn
                VStack{

                Text("       Community Reviews                   ")
                        .padding(.leading)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(20)
                    Text("\(review)")
                        .font(.title2)
                    
                }
            }
            .padding()
            
        }
        .navigationTitle(book.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {}, label: {
            
        Image(systemName: "slider.horizontal.3")
                .renderingMode(.template)
                .foregroundColor(.gray)
        }))
        
        }
}
}
struct RatingView : View {
    
    @Binding var selectedStar : Int
    @Binding var message : Bool
    var body: some View {
        
        ForEach(0..<5) {
            rating in Image(systemName: "star.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(self.selectedStar >= rating ? .yellow : .gray)
                .onTapGesture {
                self.selectedStar = rating
                self.message.toggle()
            }
        }
    }
}
private extension DetailView {
    var textEditorVw: some View {
        TextEditor(text: $review)
            .frame(height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray.opacity(0.2), lineWidth: 4)
            )
    }

    var submitBtn: some View {
        Button {
            print("The user inputted: \(review)")
        }
    label: {
        Text("Submit")
            .font(.title2)
            .padding()
        }
    }
}

