//
//  Game.swift
//  RPG
//
//  Created by Sebastian Hufeld on 20.01.25.
//

import Foundation

class Game {
    var heros: [Hero] = [
        Magican(name: "Sylvaris, der Magiermeister", hp: 100, attackPoints: 15, defensePoints: 80, mana: 100),
        Tank(name: "Flameborn, der Tank", hp: 120, attackPoints: 30, defensePoints: 100, stamina: 100),
        Archer(name: "Faelor, die Meisterschützin", hp: 100, attackPoints: 12, defensePoints: 40, arrows: 20, backPack: Items(arrows: 20, arrowName: "Feuerpfeile", fireArrows: 15))
    ]
    let bold = "\u{001B}[1m"
    let reset = "\u{001B}[0m"
    let magenta = "\u{001B}[35m"
    let cyan = "\u{001B}[36m"
    let green = "\u{001B}[32m"
    let red = "\u{001B}[31m"
    var backpack = Backpack()
    var enemies: [Enemy] = [
        Endboss(name: "Malvortas, der Unbesiegte", hp: 120, attackPoints: 55, blockPoints: 80, helper: 1),
    ]
    var gameStatus: GameStatus = .prepare
    var roundCounter: Int = 1
    var helperSummoned: Bool = false
    var gameOver: Bool = false
    
    func play() {
        updateGameStatus()
        yourHeros()
        heroInfo()
        enemyHeader()
        theEnemies()
        while !gameOver {
            round()
            
        }
    }
    
    func updateGameStatus() {
        switch gameStatus {
        case .prepare:
            print(GameStatus.prepare.rawValue)
            gameStatus = .fight
        case .fight:
            print(GameStatus.fight.rawValue)
            if enemies.isEmpty {
                gameStatus = .win
            } else if heros.isEmpty {
                gameStatus = .gameover
            }
        case .win:
            print(GameStatus.win.rawValue)
        case .gameover:
            print(GameStatus.gameover.rawValue)
        }
    }
    
    func round() {
        print("### Runde \(roundCounter)! ###")
        heroInfo()
        print("--------------------------------------------\n")
        theEnemies()
        print("============================================\n")
        // Heldenzug
        for hero in heros {
            heroAction(hero)
            checkGameOver()
        }
        
        // Gegnerzug
        for enemy in enemies {
            enemyAction(enemy)
            enemy.poisinedEffect()
            checkGameOver()
        }
        
        roundCounter += 1
        updateGameStatus()
    }
    
    
    
    
    func checkGameOver() {
        if heros.isEmpty || enemies.isEmpty {
            
            if heros.isEmpty {
                print("### GAME OVER! ###")
                print("Die Helden wurden besiegt! Die Dunkelheit triumphiert.")
            } else {
                print("### GEWONNEN! ###")
                print("Die Helden haben gesiegt! Der Frieden ist wiederhergestellt.")
            }
            gameOver = true
            exit(0)
        }
    }
    
    func heroAction(_ hero: Hero) {
        hero.updateCondition()
        if hero.hp > 0 {
            print("\n\(hero.name) ist am Zug!")
            print("Was möchte \(hero.name) tun?")
            print("[1] Angriff ausführen")
            print("[2] Rucksack verwenden")
            let input = readLine()!
            switch input {
            case "1":
                hero.attackMenu(enemies, heros)
            case "2":
                backpack.potionsMenu(hero)
            default:
                print("Ungültige Eingabe! Bitte erneut versuchen.")
                heroAction(hero)
            }
        } else {
            print("\(hero.name) ist kampfunfähig.")
        }
        
        enemies.removeAll { $0.hp <= 0 }
    }
    
    func enemyAction(_ enemy: Enemy) {
        enemy.updateCondition()
        print("\(enemy.name) ist am Zug!")
        
        if enemy.hp > 0 {
            if !helperSummoned, let endboss = enemy as? Endboss, endboss.hp <= 100 {
                if let helper = endboss.callHelper() {
                    enemies.append(helper)
                    helperSummoned = true
                    print("\(endboss.name) beschwört einen Helfer!")
                }
                if helperSummoned, endboss.hp <= 100 {
                    print("\(endboss.name) hat keinen Helfer mehr!")
                }
            } else {
                if !heros.isEmpty {
                    enemy.randomAttack(heros)
                    heros.removeAll { $0.hp <= 0 }
                }
            }
        } else {
            print("\(enemy.name) wurde besiegt.")
        }
    }
    func yourHeros(){
        print("""
\(magenta)
                                                                                                                                                                                                      
                                                                                                                                                        dddddddd                                      
DDDDDDDDDDDDD                             iiii                                            HHHHHHHHH     HHHHHHHHH                   lllllll             d::::::d                                      
D::::::::::::DDD                         i::::i                                           H:::::::H     H:::::::H                   l:::::l             d::::::d                                      
D:::::::::::::::DD                        iiii                                            H:::::::H     H:::::::H                   l:::::l             d::::::d                                      
DDD:::::DDDDD:::::D                                                                       HH::::::H     H::::::HH                   l:::::l             d:::::d                                       
  D:::::D    D:::::D     eeeeeeeeeeee   iiiiiiinnnn  nnnnnnnn        eeeeeeeeeeee           H:::::H     H:::::H      eeeeeeeeeeee    l::::l     ddddddddd:::::d     eeeeeeeeeeee    nnnn  nnnnnnnn    
  D:::::D     D:::::D  ee::::::::::::ee i:::::in:::nn::::::::nn    ee::::::::::::ee         H:::::H     H:::::H    ee::::::::::::ee  l::::l   dd::::::::::::::d   ee::::::::::::ee  n:::nn::::::::nn  
  D:::::D     D:::::D e::::::eeeee:::::eei::::in::::::::::::::nn  e::::::eeeee:::::ee       H::::::HHHHH::::::H   e::::::eeeee:::::eel::::l  d::::::::::::::::d  e::::::eeeee:::::een::::::::::::::nn 
  D:::::D     D:::::De::::::e     e:::::ei::::inn:::::::::::::::ne::::::e     e:::::e       H:::::::::::::::::H  e::::::e     e:::::el::::l d:::::::ddddd:::::d e::::::e     e:::::enn:::::::::::::::n
  D:::::D     D:::::De:::::::eeeee::::::ei::::i  n:::::nnnn:::::ne:::::::eeeee::::::e       H:::::::::::::::::H  e:::::::eeeee::::::el::::l d::::::d    d:::::d e:::::::eeeee::::::e  n:::::nnnn:::::n
  D:::::D     D:::::De:::::::::::::::::e i::::i  n::::n    n::::ne:::::::::::::::::e        H::::::HHHHH::::::H  e:::::::::::::::::e l::::l d:::::d     d:::::d e:::::::::::::::::e   n::::n    n::::n
  D:::::D     D:::::De::::::eeeeeeeeeee  i::::i  n::::n    n::::ne::::::eeeeeeeeeee         H:::::H     H:::::H  e::::::eeeeeeeeeee  l::::l d:::::d     d:::::d e::::::eeeeeeeeeee    n::::n    n::::n
  D:::::D    D:::::D e:::::::e           i::::i  n::::n    n::::ne:::::::e                  H:::::H     H:::::H  e:::::::e           l::::l d:::::d     d:::::d e:::::::e             n::::n    n::::n
DDD:::::DDDDD:::::D  e::::::::e         i::::::i n::::n    n::::ne::::::::e               HH::::::H     H::::::HHe::::::::e         l::::::ld::::::ddddd::::::dde::::::::e            n::::n    n::::n
D:::::::::::::::DD    e::::::::eeeeeeee i::::::i n::::n    n::::n e::::::::eeeeeeee       H:::::::H     H:::::::H e::::::::eeeeeeee l::::::l d:::::::::::::::::d e::::::::eeeeeeee    n::::n    n::::n
D::::::::::::DDD       ee:::::::::::::e i::::::i n::::n    n::::n  ee:::::::::::::e       H:::::::H     H:::::::H  ee:::::::::::::e l::::::l  d:::::::::ddd::::d  ee:::::::::::::e    n::::n    n::::n
DDDDDDDDDDDDD            eeeeeeeeeeeeee iiiiiiii nnnnnn    nnnnnn    eeeeeeeeeeeeee       HHHHHHHHH     HHHHHHHHH    eeeeeeeeeeeeee llllllll   ddddddddd   ddddd    eeeeeeeeeeeeee    nnnnnn    nnnnnn
                                                                                                                                                                                                      
                                                                                                                                                                                                      
                                                                                                                                                                                                      
                                                                                                                                                                                                      
                                                                                                                                                                                                      
                                                                                                                                                                                                      
                                                                                                                                                                                                      
              \(reset)
""")
    }
    
    func heroInfo(){
        for hero in heros{
            var specialInfo = ""
            
            if let magician = hero as? Magican{
                specialInfo = "\(bold)Manapunkte:\(reset) \(magician.mana)"
            }
            else if let tank = hero as? Tank{
                specialInfo = "\(bold)Staminapunkte:\(reset) \(tank.stamina)"
            }
            
            print("\(bold)Name:\(reset) \(hero.name), \(bold)Lebenspunkte:\(reset) \(hero.hp) | \(bold)Verteidigungspunkte:\(reset) \(hero.defensePoints) \(specialInfo.isEmpty ? "" : "| \(specialInfo)")")
        }
    }
    
    func enemyHeader(){
        print ("""
\(cyan)
                                                                                                                                                                                                          
                                                                                                                                                                                                          
DDDDDDDDDDDDD          iiii                              SSSSSSSSSSSSSSS                    hhhhhhh                                                 kkkkkkkk                                              
D::::::::::::DDD      i::::i                           SS:::::::::::::::S                   h:::::h                                                 k::::::k                                              
D:::::::::::::::DD     iiii                           S:::::SSSSSS::::::S                   h:::::h                                                 k::::::k                                              
DDD:::::DDDDD:::::D                                   S:::::S     SSSSSSS                   h:::::h                                                 k::::::k                                              
  D:::::D    D:::::D iiiiiii     eeeeeeeeeeee         S:::::S                cccccccccccccccch::::h hhhhh       uuuuuu    uuuuuu rrrrr   rrrrrrrrr   k:::::k    kkkkkkk eeeeeeeeeeee    nnnn  nnnnnnnn    
  D:::::D     D:::::Di:::::i   ee::::::::::::ee       S:::::S              cc:::::::::::::::ch::::hh:::::hhh    u::::u    u::::u r::::rrr:::::::::r  k:::::k   k:::::kee::::::::::::ee  n:::nn::::::::nn  
  D:::::D     D:::::D i::::i  e::::::eeeee:::::ee      S::::SSSS          c:::::::::::::::::ch::::::::::::::hh  u::::u    u::::u r:::::::::::::::::r k:::::k  k:::::ke::::::eeeee:::::een::::::::::::::nn 
  D:::::D     D:::::D i::::i e::::::e     e:::::e       SS::::::SSSSS    c:::::::cccccc:::::ch:::::::hhh::::::h u::::u    u::::u rr::::::rrrrr::::::rk:::::k k:::::ke::::::e     e:::::enn:::::::::::::::n
  D:::::D     D:::::D i::::i e:::::::eeeee::::::e         SSS::::::::SS  c::::::c     ccccccch::::::h   h::::::hu::::u    u::::u  r:::::r     r:::::rk::::::k:::::k e:::::::eeeee::::::e  n:::::nnnn:::::n
  D:::::D     D:::::D i::::i e:::::::::::::::::e             SSSSSS::::S c:::::c             h:::::h     h:::::hu::::u    u::::u  r:::::r     rrrrrrrk:::::::::::k  e:::::::::::::::::e   n::::n    n::::n
  D:::::D     D:::::D i::::i e::::::eeeeeeeeeee                   S:::::Sc:::::c             h:::::h     h:::::hu::::u    u::::u  r:::::r            k:::::::::::k  e::::::eeeeeeeeeee    n::::n    n::::n
  D:::::D    D:::::D  i::::i e:::::::e                            S:::::Sc::::::c     ccccccch:::::h     h:::::hu:::::uuuu:::::u  r:::::r            k::::::k:::::k e:::::::e             n::::n    n::::n
DDD:::::DDDDD:::::D  i::::::ie::::::::e               SSSSSSS     S:::::Sc:::::::cccccc:::::ch:::::h     h:::::hu:::::::::::::::uur:::::r           k::::::k k:::::ke::::::::e            n::::n    n::::n
D:::::::::::::::DD   i::::::i e::::::::eeeeeeee       S::::::SSSSSS:::::S c:::::::::::::::::ch:::::h     h:::::h u:::::::::::::::ur:::::r           k::::::k  k:::::ke::::::::eeeeeeee    n::::n    n::::n
D::::::::::::DDD     i::::::i  ee:::::::::::::e       S:::::::::::::::SS   cc:::::::::::::::ch:::::h     h:::::h  uu::::::::uu:::ur:::::r           k::::::k   k:::::kee:::::::::::::e    n::::n    n::::n
DDDDDDDDDDDDD        iiiiiiii    eeeeeeeeeeeeee        SSSSSSSSSSSSSSS       cccccccccccccccchhhhhhh     hhhhhhh    uuuuuuuu  uuuurrrrrrr           kkkkkkkk    kkkkkkk eeeeeeeeeeeeee    nnnnnn    nnnnnn
                                                                                                                                                                                                          
                                                                                                                                                                                                          
                                                                                                                                                                                                          
                                                                                                                                                                                                          
                                                                                                                                                                                                          
                                                                                                                                                                                                          
                                                                                                                                                                                                          

\(reset)
""")
    }
    func theEnemies(){
        for enemy in enemies{
            print("\(bold)Name:\(reset) \(enemy.name), \(bold)Lebenspunkte:\(reset) \(enemy.hp) | \(bold)Verteidigungspunkte:\(reset) \(enemy.blockPoints)")
        }
        print("============================================================\n\n\n")
    }
    
    func win(){
        print("""
    \(green)
     ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░  
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒▒▓███▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
     ░▒▓██████▓▒░░▒▓████████▓▒░░▒▓█████████████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 
    
    
    ░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░      ░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░        ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░  
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████▓▒░        ░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒▒▓███▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
    ░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░       ░▒▓██████▓▒░░▒▓████████▓▒░░▒▓█████████████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 
                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                         

                                                                                                                     
                                                                                                                     
                                                           
                                                       
    \(reset)
    """)
    }
    
    func lose(){
        print("""
\(red)

░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░  
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓█▓▒▒▓█▓▒░░▒▓██████▓▒░ ░▒▓███████▓▒░░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
  ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
   ░▒▓██▓▒░  ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 



 ░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░      ░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░       ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░      ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░  
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████▓▒░        ░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒▒▓█▓▒░░▒▓██████▓▒░ ░▒▓███████▓▒░░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░        ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░         ░▒▓██▓▒░  ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 
                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                              
                     
                                                                                                                        

                                                                                                         
                                                                                                         
\(reset)
""")
    }
}





// TODO: Funktionen überarbeiten,
