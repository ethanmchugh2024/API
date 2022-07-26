//
//  ContentView.swift
//  API
//
//  Created by Ethan McHugh on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var airbnbs = [AirBNB]()
    var body: some View {
        NavigationView{
            List(airbnbs){ airbnb in
                NavigationLink(destination: Text(airbnb.image)
                    .padding()){
                        Text(airbnb.title)
                    }
            }
            .navigationTitle("AirBNB Places")
        }
        .onAppear(){
            getAirBNB()
        }
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        }
    }
        func getAirBNB() {
            let apiKey = "?rapidapi-key=56eec672d2msh2dda640b00f3b2fp1ca44cjsn457b4554b742"
            let query = "https://airbnb19.p.rapidapi.com/api/v1/getCategory\(apiKey)"
            if let url = URL(string: query) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    let json = try! JSON(data: data)
                    
                    if json["status"] == true {
                        
                        let contents = json["data"].arrayValue
                        for item in contents {
                            let aid = item["id"].stringValue
                            let title = item["title"].stringValue
                            let image = item["image"].stringValue
                            let airbnb = AirBNB(aid: aid, title: title, image: image)
                            airbnbs.append(airbnb)
                        }
                        return
                    }
                    
                }
                
            }
            showingAlert = true
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AirBNB: Identifiable {
    let id = UUID()
    var aid = String()
    var title = String()
    var image = String()
}










//https://airbnb19.p.rapidapi.com/api/v1/getCategory?rapidapi-key=56eec672d2msh2dda640b00f3b2fp1ca44cjsn457b4554b742
