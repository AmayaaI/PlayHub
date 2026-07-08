//
//  LightLevel.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-07.
//

import Foundation

enum LightLevel: Equatable {

    case level1
    case level2
    case level3
    case level4

    // Number of cards shown
    var cardCount: Int {

        switch self {

        case .level1:
            return 3

        case .level2:
            return 4

        case .level3:
            return 6

        case .level4:
            return 9
        }
    }

    // Number of columns in the grid
    var columns: Int {

        switch self {

        case .level1:
            return 3

        case .level2:
            return 2

        case .level3:
            return 3

        case .level4:
            return 3
        }
    }

    // How long cards stay lit
    var lightDuration: Double {

        switch self {

        case .level1:
            return 1.5

        case .level2:
            return 1.2

        case .level3:
            return 1.0

        case .level4:
            return 0.8
        }
    }

    // Number of cards that light up
    var litCardCount: Int {

        switch self {

        case .level1:
            return 1

        case .level2:
            return 1

        case .level3:
            return 1

        case .level4:
            return 2
        }
    }

    // Display name
    var title: String {

        switch self {

        case .level1:
            return "Level 1"

        case .level2:
            return "Level 2"

        case .level3:
            return "Level 3"

        case .level4:
            return "Level 4"
        }
    }
}
