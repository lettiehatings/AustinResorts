//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Hastings, Lettie on 4/1/24.
//

import SwiftUI
import MapKit



let data = [
  Item(name: "Omni Barton Creek Resort & Spa", neighborhood: "Barton Creek", desc: "Whether you're seeking relaxation by our breathtaking pools, refining your golf skills on the championship courses, or indulging in a day of pampering at the world-class Mokara Spa, the resort has something for everyone.", lat: 30.291196443039507, long: -97.85896350715137, imageName: "spa1"),
  Item(name: "Miraval Austin Resort & Spa", neighborhood: "Lake Travis", desc: "Miraval Austin is an inclusive destination resort & spa. Embark on a wellness journey with signature wellness experiences & luxury accommodations.", lat: 30.44622288109638, long: -97.8511860069301, imageName: "spa2"),
  Item(name: "Sage Hill & Spa", neighborhood: "Kyle", desc: "Every detail has been thoughtfully designed to serve the needs of unique travel styles and to maximize your ability to relax. Plus, every stay includes a daily breakfast and delicious three-course dinner, so you have even less to worry about on your luxury getaway near Austin!", lat: 30.03607270533617, long: -97.93781697455901, imageName: "spa3"),
  Item(name: "Plantation House", neighborhood: "Plflugerville", desc: "Besides our comfortable rooms, when you stay at Plantation House Boutique Inn, you'll be able to relax and unwind in our quiet common areas, including a front porch adorned with rocking chairs and our open great room with an inviting fireplace. All this is located on five meticulously groomed acres of Pflugerville's Texas Hill Country, so you'll have plenty of room to enjoy life for a while. Oh, and don't forget: Every morning you're with us, you'll be treated to the best breakfast you'll find in our part of Texas. ", lat: 30.460264739607194, long: -97.56477408814206, imageName: "spa4"),
  Item(name: "The Loren at Lady Bird Lake", neighborhood: "Downtown", desc: "Serving up Italian specialties and drinks.", lat: 30.264654520832554, long: -97.75228831195578, imageName: "spa5")
]
  struct Item: Identifiable {
      let id = UUID()
      let name: String
      let neighborhood: String
      let desc: String
      let lat: Double
      let long: Double
      let imageName: String
  }





struct ContentView: View {
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
                @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.726220), span: MKCoordinateSpan(latitudeDelta: 0.90, longitudeDelta: 0.90))
    var body: some View {
        NavigationView {
          VStack {
              List(data, id: \.name) { item in
                  NavigationLink(destination: DetailView(item: item)) {
                  HStack {
                      Image(item.imageName)
                          .resizable()
                          .frame(width: 50, height: 50)
                          .cornerRadius(10)
                  VStack(alignment: .leading) {
                          Text(item.name)
                              .font(.headline)
                          Text(item.neighborhood)
                              .font(.subheadline)
                      } // end internal VStack
                  } // end HStack
                  } // end NavigationLink
              } // end List
              //add this code in the ContentView within the main VStack.
                          Map(coordinateRegion: $region, annotationItems: data) { item in
                              MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                  Image(systemName: "mappin.circle.fill")
                                      .foregroundColor(.red)
                                      .font(.title)
                                      .overlay(
                                          Text(item.name)
                                              .font(.subheadline)
                                              .foregroundColor(.black)
                                              .fixedSize(horizontal: true, vertical: false)
                                              .offset(y: 25)
                                      )
                              }
                          } // end map
                          .frame(height: 300)
                          .padding(.bottom, -30)
                          
                              
          } // end VStack
          .listStyle(PlainListStyle())
                    .navigationTitle("Austin Resorts")
                } // end NavigationView
      } // end body
          
}

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
          @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 200)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
               // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                    Map(coordinateRegion: $region, annotationItems: [item]) { item in
                      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                          Image(systemName: "mappin.circle.fill")
                              .foregroundColor(.red)
                              .font(.title)
                              .overlay(
                                  Text(item.name)
                                      .font(.subheadline)
                                      .foregroundColor(.black)
                                      .fixedSize(horizontal: true, vertical: false)
                                      .offset(y: 25)
                              )
                      }
                  } // end Map
                      .frame(height: 300)
                      .padding(.bottom, -30)
                    
                        
                   } // end VStack
                    .navigationTitle(item.name)
                    Spacer()

        } // end body
     } // end DetailView
   




#Preview {
    ContentView()
}
