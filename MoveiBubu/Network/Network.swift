//
//  Network.swift
//  MoveiBubu
//
//  Created by obss on 15.06.2022.
//

import Foundation

struct Network {
    //Burda URLSession referansını kullanıyoruz. Session'a başka structa kullanılmamak üzere private olarak tanımlayıp session değişkenine atıyoruz.
    //singleton bir session objesi kullanmamızı sağlıyor.
    private let session = URLSession.shared
    
    //istek fonsiyonumuz ve beklediğimiz tipleri ve değişkenleri özellikleri ile fonksiyonun içine yazıp complation handler ile dönüşlerini yazıyoruzz.
    //T generik type ı gösteriyor. Modellerimizn ortak özelliği T tipinde Codable olması
    //request; atacağımız yapıyı tanımlıyor. 3.part yazılım veya kendi swift struct ını kullanabiliriz.
    //complation? ; bizim yazdığımız bir clousure yani kod bloğu, iki parantez() arası parametre tanımladığımız alan, parametre alarak fonsiyon alıcam, bu yazdığım fonsiyonu diğer fonsiyonda kullanacağım.
    // void; geri dönüş olarak herhangi bir tipten birşey dönmeyen fonksiyonlarda dönüş tipidir.
    func performRequest<T: Codable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
    // task bizim isteğimizi yaptığımız değişken
    // yukarıda tanımladığımız sessionın dataTask ını kullanarak ne ile request ile data response ve error içinde asenkron olarak data isteği atıyor.
        let task = session.dataTask(with: request) { data, response, error in
            //veri çekme işlemi uygulamanın çalışmasını engellememek adına asenkron olarak arka planda yapıyor.
            DispatchQueue.main.async {
                //data gelirse do try catch bloğunda olacak şekilde if let dögüsünde yazıyoruz. Sebebi throws olması yüksek ihtimall.
                if let data = data {
                    do {
                        // burda gelen datayı modele çeviriyoruz
                        let model = try JSONDecoder().decode(T.self, from: data)
                        //eğer model başarılı şekilde modele atanırsa gelirse succes basıyoruz
                        completion(.success(model))
                        //datayı modele çevirirken hata alırsa decoding eror olarak yaka ve bana söyle
                        } catch {
                        completion(.failure(.decodingError))
                        }// eğer hiçbirşey gelmiyorsa bağlantı hatasını gönder
                    } else if error != nil {
                    completion(.failure(.networkError))
                        //hiç bir şekilde data gelmiyorsa hatalı model veya başka bişey varsa bilinmeyen hata olarak göster
                    } else {
                    completion(.failure(.unknowError))
                        
                    }
                }
            }
        //network isteğini atmak init
        task.resume()
        
    }
    
}

// eror tiplerini tanımlıyoruz ki nerede nasıl bir hata alacağımızı öğrenip buna göre hareket ve bilgilendirme bize yardımcı olur.
enum NetworkError: Error {
    case decodingError
    case networkError
    case unknowError
}

