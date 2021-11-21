//
//  FontSwap.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/11/20.
//

import SwiftUI

struct FontSwap {
     static func caption2ForTitle3(for sizeCategory: ContentSizeCategory) -> Font {
        wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3
    }
    static func caption2ForSubheadline(for sizeCategory: ContentSizeCategory) -> Font {
        wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline
    }

    static func caption2ForTitle(for sizeCategory: ContentSizeCategory) -> Font {
        wideElement(sizeCategory: sizeCategory) ? .caption2 : .title
    }

    static func caption2ForBody(for sizeCategory: ContentSizeCategory) -> Font {
        wideElement(sizeCategory: sizeCategory) ? .caption2 : .body
    }

    static func caption2ForCaption(for sizeCategory: ContentSizeCategory) -> Font {
        wideElement(sizeCategory: sizeCategory) ? .caption2 : .caption
    }
}

/*

 wideElement(sizeCategory: sizeCategory) ? .caption2: .caption

 wideElement(sizeCategory: sizeCategory) ? .caption2 : .body

 wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline

 wideElement(sizeCategory: sizeCategory) ? .caption2 : .title

 wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3

 */
