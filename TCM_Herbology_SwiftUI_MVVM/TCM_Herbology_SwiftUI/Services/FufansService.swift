//
//  FufansService.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/25.
//

import Foundation
struct FufansService {
    private static let GET_LINK = "https://taikuchou.github.io/tcmfufan.json"
    static func getData(){
        if let url = URL(string: GET_LINK){
            let session = URLSession.shared
            session.dataTask(with: URLRequest(url: url)) { data, res, error in
                if let error{
                    print(error)
                    return
                }
                if let data{
                    if let array = try? JSONDecoder().decode([FufanVO].self, from: data){
                        DispatchQueue.main.async {
                            var id = 1;
                            for data in array {
                                FufanDAO.shared.save(vo: data, hid: id)
                                id += 1
                            }
                        }

                    }
                }
            }.resume()
        }
    }
}
