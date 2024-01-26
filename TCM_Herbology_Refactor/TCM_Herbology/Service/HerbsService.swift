//
//  HerbsService.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/25.
//

import Foundation

struct HerbsService {
    private static let GET_LINK = "https://taikuchou.github.io/tcmdafan.json"
    static func getData(){
        let isAdd = HerbDAO.shared.checkInit()
        if isAdd {
            FufansService.getData()
            return
        }
        if let url = URL(string: GET_LINK){
            let session = URLSession.shared
            session.dataTask(with: URLRequest(url: url)) { data, res, error in
                if let error{
                    print(error)
                    return
                }
                if let data{
                    if let array = try? JSONDecoder().decode([HerbVO].self, from: data){
                        DispatchQueue.main.async {
                            var id = 1;
                            for data in array {
                                HerbDAO.shared.save(vo: data, hid: id)
                                id += 1
                            }
                        }
                        FufansService.getData()
                    }
                }
            }.resume()
        }
    }
}
