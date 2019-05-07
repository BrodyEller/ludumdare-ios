//
//  Post.swift
//  LudumDare
//
//  Created by Brody Eller on 5/2/19.
//  Copyright © 2019 Brody Eller. All rights reserved.
//
import SwiftyJSON
import Down

struct Node {
   var id: Int
   var parent: Int
   var superParent: Int
   var author: Int
   var type: String
   var subType: String
   var subSubType: String
   var published: String
   var created: String
   var modified: String
   var version: Int
   var slug: String
   var name: String
   var body: NSAttributedString
   var meta: [JSON] // Not sure what the function of meta is so it has [JSON] type for now
   var path: String
   var parents: [Int]
   var love: Int
   var loveTimestamp: String
   var notes: Int
   var notesTimestamp: String
   
   init(json: JSON) {
      id = json["id"].intValue
      parent = json["parent"].intValue
      superParent = json["superparent"].intValue
      author = json["author"].intValue
      type = json["type"].stringValue
      subType = json["subtype"].stringValue
      subSubType = json["subsubtype"].stringValue
      published = json["published"].stringValue
      created = json["created"].stringValue
      modified = json["modified"].stringValue
      version = json["version"].intValue
      slug = json["slug"].stringValue
      name = json["name"].stringValue
      body = try! Down(markdownString: json["body"].stringValue.replacingOccurrences(of: "///", with: "https://static.jam.vg/")).toAttributedString()
      meta = json["meta"].arrayValue // Not sure what the function of meta is so it has [JSON] type for now
      path = json["path"].stringValue
      parents = json["parents"].arrayValue.map{ $0.intValue }
      love = json["love"].intValue
      loveTimestamp = json["love-timestamp"].stringValue
      notes = json["notes"].intValue
      notesTimestamp = json["notes-timestamp"].stringValue
   }
}
