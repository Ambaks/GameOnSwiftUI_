//
//  MapView.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 12/06/2024.
//
import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var mapViewModel = MapViewModel()
    @State private var showMenu = false
    @State private var selectedTab = 0
    @State private var showSheet: Bool = false

    
    var body: some View {
        NavigationStack{
            ZStack{
                TabView(selection: $selectedTab){
                    ZStack {
                        VStack{
                        Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
                            .ignoresSafeArea()
                            .accentColor(.blue)
                            .onAppear{mapViewModel.checkIfLocationServicesIsEnabled()}
                            .mapControls{
                                MapCompass()
                                MapPitchToggle()
                                MapUserLocationButton()
                            }
                    }
                        .tag(0)
                        Button{
                            showSheet.toggle()
                        } label:{Text("+")}
                            .foregroundColor(.white)
                            .frame(width: 55, height: 55)
                            .background(Color(.systemBlue))
                            .shadow(color: .black, radius: 20)
                            .cornerRadius(100)
                            .padding(.leading, 300)
                            .padding(.top, 200)
                            
                            
                    }
                    .sheet(isPresented: $showSheet, content: {
                        CreateEventView(isExpanded: $showSheet)
                    })
                    .tag(0)
                    ProfileView().tag(1)
            }
                SidePanelView(isShowing: $showMenu, selectedTab: $selectedTab)
                }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button(action: {
                            showMenu.toggle()
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                    })
                }
            }
        }
    }
}
func placeEvent (){
    //Marker()
}
    
    
    #Preview {
        MapView()
    }

