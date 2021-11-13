//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Denys on 09.11.2021.
//
import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    enum SortType {
        case name, date
    }
    
    @State private var sortType = SortType.name
    
    var sortedProspects: [Prospect] {
        switch sortType {
        case .name:
            return filteredProspects.sorted {
                $0.name < $1.name
            }
        case .date:
            return filteredProspects.sorted {
                $0.dateAdded < $1.dateAdded
            }
        }
    }
    
    enum filterChecked {
        case name, date
    }
    
    func checkFilter(forType: filterChecked) -> String {
        switch forType {
        case .name:
            return sortType == .name ? "📌" : ""
        case .date:
            return sortType == .date ? "📌" : ""
        }
    }
    
    @State private var showingSortedAction = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) {
                    prospect in
                    HStack {
                        VStack(alignment: .leading){
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        .contextMenu{
                            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                                self.prospects.toggle(prospect)
                            }
                            
                            if !prospect.isContacted {
                                Button("Remind me") {
                                    self.addNotification(for: prospect)
                                }
                            }
                        }
                        Spacer()
                        if (self.filter == .none) {
                            Image(systemName: prospect.isContacted ? "book.fill" : "book").foregroundColor(prospect.isContacted ? Color.green : Color.red)
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button(action: {self.showingSortedAction = true}, label: {Text("Sorting")}), trailing: Button(action: {
                self.isShowingScanner = true
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@gg.co", completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingSortedAction) {() -> ActionSheet in
                ActionSheet(title: Text("Sorted by:"), message: nil, buttons: [.default(Text("Name\(checkFilter(forType:.name))")){
                    self.sortType = .name},.default(Text("Date\(checkFilter(forType:.date))")){
                        self.sortType = .date}, .cancel()])
            }
        }
    }
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else {return}
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            person.dateAdded = Date()
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning Failed")
        }
    }
    
    func addNotification(for prospect: Prospect){
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        center.getNotificationSettings {settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            }
            else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) {
                    success,error in
                    if success {
                        addRequest()
                    }else {
                        print("Doh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
