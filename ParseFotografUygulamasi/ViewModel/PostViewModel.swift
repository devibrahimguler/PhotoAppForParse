//
//  ViewControllerViewModel.swift
//  ParseFotografUygulamasi
//
//  Created by İbrahim Güler on 25.07.2021.
//

import Foundation
import Parse

struct PostTableViewModel {
    let postList : [Post]
    
    func postNumberOfRowsInSection() -> Int{
        return postList.count
    }
    
    func postCellForRowAt(_ index: Int) -> PostViewModel {
        let post = self.postList[index]
        return PostViewModel(post: post)
    }
    
}

struct PostViewModel {
    let post : Post
    
    var kullanici : String {
        return self.post.kullanici
    }
    var yorum : String {
        return self.post.yorum
    }
    var gorselurl : PFFileObject {
        return self.post.gorsel
    }
}
