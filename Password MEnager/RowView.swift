//
//  RowView.swift
//  Password MEnager
//
//  Created by Aneta Szmidt on 2021-01-24.
//

import SwiftUI

struct RowView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RowView_Previews: PreviewProvider {
    

    static var previews: some View {
        ContentView(name: "de")

    }
}

struct MailListRowView: View{
    
    @Environment(\.managedObjectContext) private var viewContext

    
    @State   var img = "mail"
    @State   var starImage = "star"
    @State   var title = ""

    var item: MailCore

    func doFavourite() {
        if item.isFavourite{
            starImage = "star.fill"

        }else{
            starImage = "star"

        }
    }
    func getImage() {
        title = item.title!

        let liveAlbums = item.title

        switch liveAlbums {
      
        case "Gmail":
            img = "gmail"
        case "Hotmail":
            img = "outlook"
        default:
            img = "mail"
        }
        
    doFavourite()
        
    }

    var body: some View{
        
        NavigationLink(
            destination: ItemDetailView(mail: item, ifCategory: "mail")){
            
            
        
        HStack{
         
            Image(img)
                .resizable()
                .frame(width: 20.0, height: 20.0)

        
            Text(title)
            
            Spacer()
            
            
          Image(systemName: starImage)
            .foregroundColor(.yellow)
                .onTapGesture {
                    
                    

                    if starImage == "star"{

                     item.isFavourite = true
                        starImage = "star.fill"
                    }else {
                        starImage = "star"
                      item.isFavourite = false
                    }
                    
                    do {
                        try viewContext.save()
                        
                    } catch {
            
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        print("error")
                    }

                    
                }

        }
      
        
        }
   
        .onAppear(){

       getImage()
            doFavourite()
  
        }
        
    }
    
    
    
}




struct PasswordListRowView: View{
    @State   var starImage = "star"
    @State   var img = "key"
    @State   var title = ""
    @Environment(\.managedObjectContext) private var viewContext


    
   // @ObservedObject
   @State var item: PasswordCore
  
    
    func doFavourite() {
        if item.isFavourite{
            starImage = "star.fill"

        }else{
            starImage = "star"

        }
    }
    
    func getImage() {
        
        title = item.title!
        let liveAlbums = item.title

        switch liveAlbums {
        case "Facebook":

            img = "facebook"
            
        case "Twitter":
            img = "twitter"

        case "Instagram":
            img = "instagram"
            
        case "Snapchat":
            img = "snapchat"
            
        case "LinkedIn":
            img = "linkedin"
            
        case "GitHub":
            img = "github"
            
        case "Ebay":
            img = "ebay"

        case "YouTube":
            img = "youtube"
            
            
        default:
            img = "key"
        }
        
        
   doFavourite()
        
       
        
    }
    

    var body: some View{
        
        NavigationLink(
            destination: ItemDetailView(password: item, ifCategory: "password")){
            HStack{
         
                Image(img)
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
                
                  
                    
       
                Text(title)
            
            Spacer()
            
            
          Image(systemName: starImage)
            .foregroundColor(.yellow)
                .onTapGesture {
                    
                    if starImage == "star"{

                     item.isFavourite = true
                        starImage = "star.fill"
                    }else {
                        starImage = "star"
                      item.isFavourite = false
                    }
                    
                    do {
                        try viewContext.save()
                        
                    } catch {
            
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        print("error")
                    }

                    
                }
        }

      
        }


        
        .onAppear(){
 
            getImage()
            doFavourite()
        }
        
    }
    
    
    
}


struct NotesListRowView: View{
    @State   var img = "mail"
    @State   var starImage = "star"
    @State   var title = ""

    @Environment(\.managedObjectContext) private var viewContext

    @State var item: NoteCore

    func doFavourite() {
        title = item.title!
        if item.isFavourite{
            starImage = "star.fill"

        }else{
            starImage = "star"

        }
        
    }
    func getImage() {
        let liveAlbums = item.title

        switch liveAlbums {
      
        case "Gmail":
            img = "gmail"
        case "Hotmail":
            img = "outlook"
        default:
            img = "mail"
        }
        doFavourite()
    }

    var body: some View{
        
        NavigationLink(
            destination: ItemDetailView(note: item , ifCategory: "note"))
        {
            
            
        
        HStack{
         
            Image(img)
                .resizable()
                .frame(width: 20.0, height: 20.0)

        
            Text(title).multilineTextAlignment(.trailing)
            
            Spacer()
            
            
          Image(systemName: starImage)
            .foregroundColor(.yellow)
                .onTapGesture {
                    if starImage == "star"{

                     item.isFavourite = true
                        starImage = "star.fill"
                    }else {
                        starImage = "star"
                      item.isFavourite = false
                    }
                    
                    do {
                        try viewContext.save()
                        
                    } catch {
            
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        print("error")
                    }

                }

        }
      
        
        }
   
        .onAppear(){

       getImage()
            doFavourite()
  
        }
        
    }
    
    
    
}


struct ListRowReadFromPicture: View {
    var item: String
    @Binding var username: String
    @Binding var password: String
    @Binding var getField: String

    var body: some View{
        HStack{
        Text(item)
            Spacer()
        }
            .onTapGesture {
                switch(getField){
                case "password":
                password = item
                case "username":
                    username = item
                default :
                    break
            }
            }
    }
    
    func returnUsername() -> String {
        
        return item
    }
    
}
