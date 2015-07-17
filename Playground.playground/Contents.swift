//: Playground - noun: a place where people can play
import UIKit
import Foundation

var str = "Hello, playground"

print("Hello world")

let constante = 23   //constante em tempo de execucao

var doubleVar = 9.0

var vetor = [1, 2, 3]

var dicionario = ["chave" : "valor"]
var soma = 0

for i in vetor{  //pode fazer for igual c
    soma += i
}

print(soma)

//swift nao tem break, falltrough para continuar
//tuplas sao vars que guardam mais de um valor

let erro = (404, "Dat erro")
let (i, s) = erro

//printando a tupla

print("O numero do erro \(i), \(s)")
print("O numero do erro \(erro.0)")

//optionals de como saber se a variavel eh numero
if let num = erro.1.toInt(){
    print("\(num)")
} else {
    print("nao eh numero")
}

// protocol == interface
//classe passa por ref, struct por valor, só classe tem heranca
// function nome() -> tipoRetorno
//extension adiciona funcionalidades a um tipo qualquer

@objc protocol a {
    optional func nome() -> Int
}

struct Id {
    let trakt : Int
    let slug  : String?
    let tvdb  : Int?
    let imdb  : String?
    let tmdb  : Int?
    let tvrage: Int?
}

struct Image {
    let full   : String? //NSURL
    let medium : String?
    let thumb  : String?
}

struct Show {
    let title : String
    let year  : Int
    let id    : Id
    
    let overview    : String?
    let first_aired : NSDate?
    // falta coisa aqui :P
    
    let day  : String?
    let time : String?
    let timezone : String?
    
    let runtime : Int?
    let certification : String?
    let network : String?
    let country : String?
    let updated : String?
    let trailer : NSURL?
    let homepage: NSURL?
    let status  : String?
    let rating  : Int?  //deve ser float, mas
    let votes   : Int?
    let language: String?
    let translations : [String]?
    let genres : [String]?
    let episodes : Int?
    
    //imagens
    let fanart : Image?
    let cleart : Image?
    let poster : Image?
    let banner : Image?
    let thumb  : Image?
    
}

/// ======================== Exercícios de Swift ================== //

func impar(num : Int) -> Bool{
    return num % 2 == 1
}

print(" \(impar(9))")

// ============= Exec 2 =======================
func fat(i : Int) -> Int {
    var f = 1
    
    for var j = 2; j <= i; j++ {
       f = f * j
    }
    
    return f
}

fat(6)

// ============= Exec 3 =======================
func minMax(vet : [Int]) -> (Int, Int)? {
    
    if vet.capacity == 0{
        return nil
    }
    
    var max = Int.min
    var min = Int.max
    
    for n in vet {
        if n > max {
            max = n
        }
        
        if n < min {
            min = n
        }
    }
    
    return (min, max)
}

print("\(minMax([0,4,3,-6]))")

// ============= Exec 4 =======================
func busca(vet : [Int], num : Int) -> Int? {
    
    // for (i, aux) in enumerate(vet)
    for var i = 0; i < vet.capacity; i++ {
        if vet[i] == num { // aux == num
            return i
        }
    }
    
    return nil
}

busca([0, 54, 3, 4, 7, 2], 7)

// ============= Exec 5 =======================
func palindromo (s : String) -> Bool {
    
    let tamanho = count(s)
    let palavra = Array(s)
    
    for var i = 0; i < tamanho / 2; i++ {
        if palavra[i] != palavra[tamanho-i-1] {
            return false
        }
    }
    
    return true
}

palindromo("arara")
palindromo("coisa")

// ============= Exec 6 =======================
func impares (vet : [Int]) -> [Int]? {
    
    // progamacao funcional
    // return vet.filter(impar)
    
    if (vet.capacity == 0) {
        return nil
    }
    
    var retorno : [Int] = []
    
    for element in vet {
        if impar(element) {
            retorno.append(element)
        }
    }
    
    return retorno
}

print("\(impares([1, 2, 3, 4, 6, 8]))")

/// ========= Janken \o/
enum Janken {
    case pedra
    case papel
    case tesoura
}

enum Partida {
    case vitoria
    case empate
    case derrota
}

func jokenpo (player : Janken, enemy : Janken) -> Partida {
    
    if player == enemy {
      return Partida.empate // .empate para inferir um tipo em Partida
    }
    
    switch player {
    case Janken.pedra :
        return enemy == Janken.tesoura ? Partida.vitoria : Partida.derrota
        
    case Janken.tesoura :
        return enemy == Janken.papel ? Partida.vitoria : Partida.derrota
        
    case Janken.papel :
        return enemy == Janken.pedra ? Partida.vitoria : Partida.derrota
    }
}

let m = jokenpo(Janken.pedra, Janken.pedra)
m == Partida.vitoria
m == Partida.empate

// ============= Exec 8 =======================
func frequencia (vet : [Int]) -> [Int : Int] {

    var retorno = [vet[0] : 1]
    
    for var i = 1; i < vet.capacity; i++ {
        
        if let r = retorno[ vet[i] ] {
            retorno[ vet[i] ] = retorno[ vet[i] ]! + 1
        } else {
            retorno[ vet[i] ] = 1
        }
    }
    
    return retorno
}

let f = frequencia([0, 0, 2, 3, 0, 1])
print("\(frequencia([0, 3, 5, 7, 0, 2, 3, 0, 1]))")

// ============= Exec 9 =======================
protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

struct Rectangle : Shape {
    let comp : Double
    let larg : Double
    
    func area() ->Double {
        return comp * larg
    }
    
    func perimeter() -> Double {
        return 2 * comp + 2 * larg
    }
}

struct Square : Shape {
    let l : Double
    
    func area() -> Double {
        return l * l
    }
    
    func perimeter() -> Double {
        return 4 * l
    }
}

struct Circle : Shape {
    let r : Double
    
    func area() -> Double {
        return r * r * M_PI
    }
    
    func perimeter() -> Double {
        return 2 * r * M_PI
    }
}


