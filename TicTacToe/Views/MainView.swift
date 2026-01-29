//
//  MainView.swift
//  TicTacToe
//
//  Created by 2026-DEV2-025 on 21/01/2026.
//

import SwiftUI
import TicTacToeEngine

struct MainView: View {
    
    @StateObject private var mainViewModel: MainViewModel

    init(mainViewModel: MainViewModel) {
        _mainViewModel = StateObject(wrappedValue: mainViewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let sideLength = min(width, height)
            let isLandscape = width > height

            if isLandscape {
                HStack(spacing: 24) {
                    VStack(alignment: .trailing, spacing: 3) {
                        Text("TIC").font(Font.largeTitle)
                        Text("TAC").font(Font.largeTitle)
                        Text("TOE").font(Font.largeTitle)

                    }
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)
                    gridView(geo, sideLength: sideLength, isLandscape)
                }
            } else {
                VStack(spacing: 24) {
                    Text("TicTacToe")
                        .font(Font.largeTitle)
                    gridView(geo, sideLength: sideLength, isLandscape)
                }
            }
        }
    }
    
    func gridView(_ geo: GeometryProxy, sideLength: CGFloat, _ isLandscape: Bool) -> some View {
        let safeAreaInsets = geo.safeAreaInsets
        let xPosition = isLandscape ? geo.size.width - sideLength : geo.size.width
        let yPosition = isLandscape ? geo.size.height + safeAreaInsets.bottom : geo.size.height - sideLength
        let safeSideLength = isLandscape ? sideLength + safeAreaInsets.bottom  : sideLength
        
        return GridView(viewModel: mainViewModel.boardViewModel)
            .frame(width: safeSideLength, height: safeSideLength)
            .position(x: xPosition / 2, y: yPosition / 2)
    }
}

#Preview {
    let boardSize = 3
    MainView(mainViewModel: MainViewModel(engine: TicTacToeEngine(boardSize: boardSize), boardSize: boardSize))
}
