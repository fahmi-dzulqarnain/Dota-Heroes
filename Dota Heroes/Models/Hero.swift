//
//  Hero.swift
//  Dota Heroes
//
//  Created by Fahmi Dzulqarnain on 06/08/22.
//

import Foundation
import Alamofire

public struct Hero: Decodable {
    let id: Int?
    let name: String?
    let localizedName: String?
    let primaryAttr: String?
    let attackType: String?
    let roles: [String]?
    let img: String?
    let icon: String?
    let baseHealth: Int?
    let baseHealthRegen: Double?
    let baseMana: Int?
    let baseManaRegen: Double?
    let baseArmor: Double?
    let baseMr: Int?
    let baseAttackMin: Int?
    let baseAttackMax: Int?
    let baseStr: Int?
    let baseAgi: Int?
    let baseInt: Int?
    let strGain: Double?
    let agiGain: Double?
    let intGain: Double?
    let attackRange: Int?
    let projectileSpeed: Int?
    let attackRate: Double?
    let moveSpeed: Int?
    let turnRate: Double?
    let cmEnabled: Bool?
    let legs: Int?
    let heroId: Int?
    let turboPicks: Int?
    let turboWins: Int?
    let proBan: Int?
    let proWin: Int?
    let proPick: Int?
    let onePick: Int?
    let oneWin: Int?
    let twoPick: Int?
    let twoWin: Int?
    let threePick: Int?
    let threeWin: Int?
    let fourPick: Int?
    let fourWin: Int?
    let fivePick: Int?
    let fiveWin: Int?
    let sixPick: Int?
    let sixWin: Int?
    let sevenPick: Int?
    let sevenWin: Int?
    let eightPick: Int?
    let eightWin: Int?
    let nullPick: Int?
    let nullWin: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, roles, img, icon, legs
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
        case cmEnabled = "cm_enabled"
        case heroId = "hero_id"
        case turboPicks = "turbo_picks"
        case turboWins = "turbo_wins"
        case proBan = "pro_ban"
        case proWin = "pro_win"
        case proPick = "pro_pick"
        case onePick = "1_pick"
        case oneWin = "1_win"
        case twoPick = "2_pick"
        case twoWin = "2_win"
        case threePick = "3_pick"
        case threeWin = "3_win"
        case fourPick = "4_pick"
        case fourWin = "4_win"
        case fivePick = "5_pick"
        case fiveWin = "5_win"
        case sixPick = "6_pick"
        case sixWin = "6_win"
        case sevenPick = "7_pick"
        case sevenWin = "7_win"
        case eightPick = "8_pick"
        case eightWin = "8_win"
        case nullPick = "null_pick"
        case nullWin = "null_win"
    }
}
