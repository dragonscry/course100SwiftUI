//
//  ContentView.swift
//  UserListData
//
//  Created by Denys on 04.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(users, id: \.id){
                    user in
                    NavigationLink(destination: DetailUserView(userId: user.wrappedId)){
                        HStack{
                            Text(user.checkIsActive)
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text("Age: \(user.wrappedAge)")
                            }
                        }
                    }
                }
                .onDelete(perform: remove(at: ))
            }
            .navigationBarTitle(Text("User List"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                for user in users {
                    moc.delete(user)
                    try? moc.save()
                }
            }, label: {
                Text("Delete All")
            }))
        }
        .onAppear{
            if self.users.isEmpty {
                print("Users is empty")
                Users.loadDataToCD(moc: self.moc)
            }
        }
    }
    
    func remove(at offsets: IndexSet){
        for index in offsets {
            let user = users[index]
            moc.delete(user)
            
            do {
                try moc.save()
            } catch{
                print("Error save after delete")
            }
        }
        
//        for all in users {
//            moc.delete(all)
//
//        }
//
//        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
