//
//  AnimesViewModel.swift
//  CodableTuto
//
//  Created by OuSS on 4/21/19.
//  Copyright © 2019 OuSS. All rights reserved.
//

import Foundation

struct AnimesViewModel {
    var animes = Bindable<[Anime]>()
    var isLoading = Bindable<Bool>()
    
    func fetchAnimes() {
        isLoading.value = true
        AnimeService.instance.getAnimeList { (season) in
            self.isLoading.value = false
            self.animes.value = season.anime
        }
    }
}
