//
//  Singletone.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 13/01/23.
//

import Foundation

class Singletones {
    private static var shareSingl : Singletones = {
        let single = Singletones(url: URL(fileURLWithPath: ""))
        return single
    }()
    var url:URL
   private init(url: URL) {
        self.url = url
    }
  class  func shared() -> Singletones{
          return shareSingl
    }
}
