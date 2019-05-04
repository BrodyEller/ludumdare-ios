//
//  Feed.swift
//  LudumDare
//
//  Created by Brody Eller on 5/2/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class Feed {
  
  // MARK: - Properties
  
  private var nodes = [Node]()
  
  /**
   *  Current number of nodes cached
   *
   *  - Author:
   *    - Brody Eller
   *
   */
  var nodeCount: Int {
    return nodes.count
  }
  
  // MARK: - Networking
  
  /**
   *  Fetches a list of node Ids
   *
   *  - Author:
   *    - Brody Eller
   *
   *  - parameters:
   *    - offset: Fetches nodes starting at this index, Default 0
   *    - limit: Limits the number of nodes returned, Default 10
   *    - completionHandler: Called when fetch completes
   */
  private func getIds(offset: Int = 0, limit: Int = 10, _ completionHandler: @escaping ([Int]) -> Void) {
    let requestURL = "https://api.ldjam.com/vx/node/feed/1/all/post?offset=" + offset.description + "&limit=" + limit.description
    
    var ids: [Int] = []
    AF.request(requestURL).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        for post in json["feed"] {
          ids.append(post.1["id"].intValue)
        }
      case .failure(let error):
        print(error)
      }
      completionHandler(ids)
    }
  }
  
  /**
   *  Fetches a node using its Id
   *
   *  - Author:
   *    - Brody Eller
   *
   *  - parameters:
   *    - id: Id of Node to be fetched
   *    - completionHandler: Called when fetch completes
   */
  private func getNode(id: Int, _ completionHandler: @escaping (Node) -> Void) {
    let requestURL = "https://api.ldjam.com/vx/node2/get/" + id.description
    AF.request(requestURL).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        let nodeJSON = json["node"][0]
        completionHandler(Node(json: nodeJSON))
      case .failure(let error):
        print(error)
      }
    }
  }
  
  /**
   *  Fetches nodes and stores them in feed
   *
   *  - Author:
   *    - Brody Eller
   *
   *  - parameters:
   *    - offset: Fetches nodes starting at this index, Default 0
   *    - limit: Limits the number of nodes returned, Default 10
   *    - completionHandler: Called when fetch completes
   */
  func getNodes(offset: Int = 0, limit: Int = 10, _ completionHandler: @escaping () -> Void = {}) {
    getIds(offset: offset, limit: limit) { ids in
      let idString = ids.description.replacingOccurrences(of: ", ", with: "+").dropFirst().dropLast()
      let requestURL = "https://api.ldjam.com/vx/node2/get/" + idString
      AF.request(requestURL).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          json["node"].map { nodeJSON in
            let node = Node(json: nodeJSON.1)
            self.nodes.append(node)
          }
          completionHandler()
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  /**
   *  Returns node at the specified index
   *
   *  - Author:
   *    - Brody Eller
   *
   *  - returns:
   *    - Node at the specified index
   *
   *  - parameters:
   *    - index: Index of node
   */
  func node(at index: Int) -> Node? {
    if nodes.indices.contains(index) {
      return nodes[index]
    } else {
      // TODO: Fetch new nodes when index out of range
      return nil
    }
  }
}
