//
//  main.swift
//  Market
//
//  Created by Yerassyl on 12.02.2024.
//

import Foundation

public class Product{
    var name:String
    var price: Int
    var category: String
    
    init(name: String, price: Int, category: String) {
        self.name = name
        self.price = price
        self.category = category
    }
}

public class Cart{
    var products: [Product] = []
   
    func addProduct(_ product: Product){
        products.append(product)
        print("\(product.name) добавлен в карзину!")
    }
    
    func removedProductByName(_ name: String) {
        
        if let index = products.firstIndex(where: { $0.name == name }) {
            let removedProduct = products.remove(at: index)
            print("\(removedProduct.name) удален из корзине.")
        } else {
            print("Товар с именем \(name) не найден в корзине.")
        }
    }
    
    func showCart() {
        print("\n------Карзина------")
        for product in products {
            print("Имя: \(product.name), Категория: \(product.category), Цена: \(product.price)KZT")
        }
        print("----------------")
    }
    
    func amountOfProducts() -> Int {
        var amount = 0
        for i in products{
            amount += i.price
        }
        return amount
    }
}

class Market {
    var shoppingCart = Cart()

    func showMenu() {
        print("\n--- Меню ---")
        print("1. Добавить товар в корзину")
        print("2. Удалить товар из корзины")
        print("3. Просмотреть корзину")
        print("4. Рассчитать стоимость")
        print("5. Поиск товара")
        print("6. Завершить работу")
        print("--------------")
    }

    func run() {
        print("Добро пожаловать в магазин товаров!")
        var exit = false

        while !exit {
            showMenu()

            if let choice = readLine(), let option = Int(choice) {
                switch option {
                case 1:
                    addProductToCart()
                case 2:
                    removeProductFromCart()
                case 3:
                    shoppingCart.showCart()
                case 4:
                    print("Общая стоимость: $\(shoppingCart.amountOfProducts())")
                case 5:
                    searchProduct()
                case 6:
                    exit = true
                    print("Спасибо за покупки!")
                default:
                    print("Некорректная команда. Пожалуйста, выберите существующий вариант.")
                }
            }
        }
    }

    func addProductToCart() {
        print("\n--- Добавление товара ---")
        print("Введите наименование товара:")
        guard let name = readLine(), !name.isEmpty else {
            print("Некорректное наименование товара.")
            return
        }

        print("Введите категорию товара:")
        guard let category = readLine(), !category.isEmpty else {
            print("Некорректная категория товара.")
            return
        }

        print("Введите цену товара:")
        guard let priceStr = readLine(), let price = Int(priceStr), price >= 0 else {
            print("Некорректная цена товара.")
            return
        }

        let newProduct = Product(name: name, price: price, category: category)
        shoppingCart.addProduct(newProduct)
    }

    func removeProductFromCart() {
        print("\n--- Удаление товара ---")
        print("Введите наименование товара для удаления:")
        guard let name = readLine(), !name.isEmpty else {
            print("Некорректное наименование товара.")
            return
        }

        shoppingCart.removedProductByName(name)
    }

    func searchProduct() {
        print("\n--- Поиск товара ---")
        print("Введите наименование или категорию товара:")
        guard let query = readLine(), !query.isEmpty else {
            print("Пустой запрос. Введите наименование или категорию товара.")
            return
        }

        let foundProducts = shoppingCart.products.filter {
            $0.name.localizedCaseInsensitiveContains(query) || $0.category.localizedCaseInsensitiveContains(query)
        }

        if foundProducts.isEmpty {
            print("Товары не найдены.")
        } else {
            print("\n--- Найденные товары ---")
            for product in foundProducts {
                print("\(product.name) (\(product.category)): $\(product.price)")
            }
            print("-----------------------")
        }
    }
}

// Запуск программы
let market = Market()
market.run()
