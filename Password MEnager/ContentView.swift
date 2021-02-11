//
//  ContentView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-21.
//

import SwiftUI

struct ContentView: View {
    var name: String
    var navBackgroundImage = UIImage(systemName: "tramsparent")
    @Environment(\.colorScheme) var colorScheme


    
    
    init(name: String) {
        self.name = name
        UINavigationBar.appearance().largeTitleTextAttributes = [  .foregroundColor: UIColor.white]
        
        UITableView.appearance().backgroundColor = UIColor(Color.white.opacity(0))
    }
    
    
    var body: some View {
     
        NavigationView{

       
            
            ZStack{

                
                ListsView()
                
                
                HStack{
                    addNewButton()
         }.zIndex(3.0)
                .offset(y: -100)
                
                Spacer()
        
            }
            
.navigationBarTitle("Accounts")
       
            .navigationBarItems(trailing: EditButton())
        .background(backgrundColor())
            .ignoresSafeArea()


        }
        
    
    }

    
}


struct ContentView_Previews: PreviewProvider {

    

    static var previews: some View {
        ContentView(name: "dwed")

    }
}

struct addNewButton: View {
    var body: some View{
        Spacer(    )
         VStack{
    Spacer(     )

     NavigationLink(
         destination: AddNewItemView()    ){
         
     Image(systemName: "plus.circle")
     .resizable()
         .frame(width: 50, height: 50)
     .clipShape(Circle())
         .foregroundColor(.white)
         .background(Color.purple)
         .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
     .overlay(Circle().stroke(Color.white, lineWidth: 3))
        .shadow(color: Color.purple.opacity(0.5) , radius: 10    , x: 10, y: 10)
        .animation(.easeIn)

     }
}
     .padding()
    }
}

struct ListsView: View {
    

    @State private var paymentType = 0
    static let paymentTypes = ["Cash", "CredicCard", "iDinePoints"]

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PasswordCore.title, ascending: true)],
        animation: .default)
    private var passwordsList: FetchedResults<PasswordCore>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MailCore.title, ascending: true)],
        animation: .default)
    private var MailsList: FetchedResults<MailCore>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteCore.title, ascending: true)],
        animation: .default)
    private var NotesList: FetchedResults<NoteCore>


    
    
    var body: some View{
        
                List{
                    Section(header: Text("Passwords")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .bold()
                            
                    ){
                            ForEach(passwordsList){
                                item in
                                PasswordListRowView(item: item)
                                    
                                    
                        
                    
                            }
                            .onDelete(perform: { indexSet in
                                withAnimation {
                                    indexSet.map { passwordsList[$0] }.forEach(viewContext.delete)

                                    do {
                                        try viewContext.save()
                              
                                    } catch {
                                     
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }
                            })
                      
      }
                    


                    Section(header: Text("Mails")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .bold()
                                .shadow(radius: 30 )
                    ){
                        ForEach(MailsList){
                            item in
                            MailListRowView(item: item)
                        }
                        .onDelete(perform: { indexSet in
                            withAnimation {
                                indexSet.map { MailsList[$0] }.forEach(viewContext.delete)

                                do {
                                    try viewContext.save()
                          
                                } catch {
                                 
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                            
                        })
       }
                    
                    Section(header: Text("Notes")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .bold()
                                .shadow(radius: 30 )
                    ){
                        ForEach(NotesList){
                            item in
                            NotesListRowView(item: item)
                        }
                        .onDelete(perform: { indexSet in
                            withAnimation {
                                indexSet.map { NotesList[$0] }.forEach(viewContext.delete)

                                do {
                                    try viewContext.save()
                          
                                } catch {
                                 
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                            
                        })
       }
//
//                    Section(header: Text("Notes")
//                                .fontWeight(.light)
//                                .foregroundColor(Color.black)
//                                .bold()
//                                .shadow(radius: 30 )){                            ForEach(savedItemsList.NotesList){
//                                item in
//                                NotesListRowView(item: item)
//
//
//                            }
//                            .onDelete(perform: { indexSet in
//                                savedItemsList.PasswordsList.remove(atOffsets: indexSet)
//                            })
//
//
//
//    }
                    
                }

                
                

                .listStyle(InsetGroupedListStyle())
        
                .shadow(color: Color.purple.opacity(0.5) , radius: 10	, x: 10, y: 10)

        
        
    }

}

struct backgrundColor: View {
    var body: some View{
        LinearGradient(
            gradient: Gradient(colors: [.purple, .white, .white]),
          startPoint: UnitPoint(x: 0.0, y: 0.0),
          endPoint: .bottomTrailing
        )
    }
}

