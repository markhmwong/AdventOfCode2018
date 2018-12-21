//
//  Day2.swift
//  AdventOfCode2018
//
//  Created by Mark Wong on 21/12/18.
//  Copyright © 2018 Mark Wong. All rights reserved.
//

import Foundation

//  Counting the occurrence of a character per line/string
//  Do a product of the frequency of each character


struct Day2 {
    
    func part2() -> Void {
        //Notes:
        //Pair of strings can only differ by 1 character
        //4 characters must be the same - minimum
        //find the letters that are common between the two strings
        //perhaps sort the string first
        //then compare
        //
    }
    
    func part1() -> Void {
        var doubles: Int = 0
        var triples: Int = 0
        let data = self.prepareArrForReadability(data: self.rawData)
        
        for index in stride(from: 0, to: data.count, by: 1) {
            let string = data[index]
            let (d, t) = self.sweep(string: String(string))
            if (d) {
                doubles += 1
            }
            
            if (t) {
                triples += 1
            }
        }
        
        let checksum = doubles * triples
        print(checksum)
    }
    
    func sweep(string: String) -> (double: Bool, triple: Bool) {
        var charDict: [Character: Int] = [:]
        
        for c in string {
            if (charDict[c] != nil) {
                if let cd = charDict[c] {
                    charDict[c] = cd + 1
                }
            } else {
                charDict[c] = 1
            }
        }
        print(charDict)
        
        return (double: charDict.values.contains(2), triple: charDict.values.contains(3))
    }
    
    func prepareArrForReadability(data: String) -> [String.SubSequence] {
        return data.split(separator: "\n")
    }
    
    let siteData: String = """
        abcdef
        bababc
        abbcde
        abcccd
        aabcdd
        abcdee
        ababab
        """
    
    let sampleData: String = """
        icxjubroqtunzeyzpomfksahgw
        ibxjvbroqtunleyzjdmfksahow
        icxjvbroqtinleyzpdmflsahnw
        icxjvbnoqtunleyvpgmfksahgw
        wcxjvbroqrunleyzpdmfksahge
        icxjtbroqtjzleyzpdmfksahgw
        icxjvbrohtunleyzpdmfkbahsw
        xcxjvbroqcunleyzpdmfksaxgw
        ycxjvbroqtunleyzpowfksahgw
        icxfvbroqtunleyzpdmfksncgw
        ixxjvbuoqtunleyzpdvfksahgw
        icfjvbroqtunleyzpdmfksadgt
        icxjvbroqdunleyzpdafksqhgw
        icxjvbrobtunlelzpdmfkuahgs
        ujxjvbroqtunleyzpdmqksahgw
        icqjvsroqtunleyzpdmfksahuw
        icxjvbroptpnleyzpdmfksangw
        """
    
    var rawData: String = """
        icxjubroqtunzeyzpomfksahgw
        ibxjvbroqtunleyzjdmfksahow
        icxjvbroqtinleyzpdmflsahnw
        icxjvbnoqtunleyvpgmfksahgw
        wcxjvbroqrunleyzpdmfksahge
        icxjtbroqtjzleyzpdmfksahgw
        icxjvbrohtunleyzpdmfkbahsw
        xcxjvbroqcunleyzpdmfksaxgw
        ycxjvbroqtunleyzpowfksahgw
        icxfvbroqtunleyzpdmfksncgw
        ixxjvbuoqtunleyzpdvfksahgw
        icfjvbroqtunleyzpdmfksadgt
        icxjvbroqdunleyzpdafksqhgw
        icxjvbrobtunlelzpdmfkuahgs
        ujxjvbroqtunleyzpdmqksahgw
        icqjvsroqtunleyzpdmfksahuw
        icxjvbroptpnleyzpdmfksangw
        ipxjvbroqtunleyzpdmfesahgi
        icajvbroqtunltyzpdqfksahgw
        ickjvbroqtuzleyzpdmfgsahgw
        icxjvbroqtunledzpdmwksahgz
        icxjvlroqtsnleyzpdmfksvhgw
        icxjvbroqtunleyzpdsfysahvw
        icxjvbroqtunwnyzydmfksahgw
        ionjvbroqtunleyzpdmfksahgj
        icxjvwriqtunleyzpdmfksahgi
        ocxjvbroztunleyzpdmfksapgw
        icxjvbroqtmnlewzpumfksahgw
        ucxjvbroqtunleyzpdmzktahgw
        icxgvbroqtunleyztdmfktahgw
        icxhvbroqttnleybpdmfksahgw
        icxjvbroqtugleyzpdxfkeahgw
        acxjvbroqvunlexzpdmfksahgw
        icxjvbroqglnleyzpbmfksahgw
        icxjvbriqtnvleyzpdmfksahgw
        icxjvbreqtunlakzpdmfksahgw
        gcxjvbuoqtunleyzpdmfksawgw
        icxjvbroqtunleyzpddfkyzhgw
        icxjvbjoqtunleyzpdmfqsahhw
        icxjvjroqtunleyzpnmfksajgw
        ycxjvbroqtunmeyzcdmfksahgw
        irxkvbryqtunleyzpdmfksahgw
        isxjvbrlqtunleyzpdmsksahgw
        icxjvbcoqtunleyzpdfkksahgw
        ixnjvbroqtunleyzpdmfkqahgw
        wcxjvbroqhunleyzqdmfksahgw
        icljvurmqtunleyzpdmfksahgw
        ibxjvbroqtayleyzpdmfksahgw
        arxjvbroqiunleyzpdmfksahgw
        iuxjvbroqtunluyzpdmoksahgw
        icxjvbrmqtunleyzpdmfosahew
        isxjvbroqtunleyrpdmfksrhgw
        icxjvxrpqtunleyzpdmfkdahgw
        ichjvbrogtunllyzpdmfksahgw
        icxjvbeoqtunlryzpdmfksakgw
        icxjvbroqtcnemyzpdmfksahgw
        icxjvbroqtybledzpdmfksahgw
        icxjvbrqqtunleyzpdmfksgngw
        icgjvbroqtunleyzmdmfksabgw
        icxjtbroqtunleyzkdmfksahww
        icxjvbfoqtunleyzpamfqsahgw
        icxjvbroknuyleyzpdmfksahgw
        icxjvbroqtujleyzpdmaksaigw
        icxjvbroqtnnlmyzpdmflsahgw
        icxjvbroqtunlefzpdmfsfahgw
        icxjvdroqtusleyzpdzfksahgw
        icxjvbioqtunlsyzpdmfkshhgw
        icxbvbrodtunleyzpdmoksahgw
        icxjvbroqtuvleyzpdmfkbahmw
        iyxjvbroqtunljvzpdmfksahgw
        icxjvbroqtudleynddmfksahgw
        icxjvwroqtnnleyzpdmfksahgz
        ichjvbroqtunleyzjdmeksahgw
        icxjvbrostunluyrpdmfksahgw
        icfjvbroqtunleyxpdgfksahgw
        nhxjvbroqtunlerzpdmfksahgw
        icxjvbrothunlexzpdmfksahgw
        icxjvbrzltqnleyzpdmfksahgw
        icxjvbrhqtunleyzpdmfksajgy
        vcxjvjroqiunleyzpdmfksahgw
        icxjfbroltunleyzpdmqksahgw
        icxbvbroqtunleyzpdofasahgw
        icxjvbkoqtunveyzpdmfksaqgw
        icxsebroqtunleyzpdmuksahgw
        icxjvbroquunlpyrpdmfksahgw
        icxhvbroqtunjeyzpdmrksahgw
        icdjvbroqtunlzyzpdmfksangw
        jcxqvbroqtvnleyzpdmfksahgw
        icxjvxroqtunleyrpdmfxsahgw
        icxjvnroqtunleyzpdmfssyhgw
        icxjvbraptunleyzpdofksahgw
        icxjvbroatunleyjpdmfbsahgw
        icxjvbroytlnlryzpdmfksahgw
        iaxjvbroqkunleyzpdmfcsahgw
        ucxjvbroqtuileyzzdmfksahgw
        icxjqbroqtcnleyzpgmfksahgw
        icxjvbloqtunleyzadmfksaqgw
        icxjvbroqtunleyzkdmnksakgw
        icxjvbroqtunleyjpdxfksahvw
        iqxjvbroqtujleyzpdmfklahgw
        icgjvbroqtunleyzpdmfksbhgb
        icxjzbroqtunleyzpdmfkdahgg
        icxjvbrobtunloywpdmfksahgw
        icxavbroqtunleyfpdmfksahgd
        icxjvbroqtunleyophmfksahkw
        icxjndroqtunlyyzpdmfksahgw
        icxjvbroqtjnleyppdmvksahgw
        icxjvbroonfnleyzpdmfksahgw
        icxjvbrqqtlnljyzpdmfksahgw
        icxjvbrzqtunlelspdmfksahgw
        icxjvbooqtunleyztdmfkfahgw
        icajvbroltunlnyzpdmfksahgw
        icxjvbroqtunleyzidmdkschgw
        icxjvbroktupleyzpdmfksahyw
        icxjcbroyeunleyzpdmfksahgw
        icxjvbroqtunlezkpdmfksahsw
        icxjvbroqtunlejzpcmfksrhgw
        icxjvvroqtunlsyzkdmfksahgw
        icxjnbroqtunbeyzpdmfpsahgw
        itxjbbroqtunleyzpemfksahgw
        icxjvbroqtunlrkzpdmfksshgw
        rcxjvbroqtujlbyzpdmfksahgw
        icxjvmroqtugleazpdmfksahgw
        icxjvbfoqtunleylpdmfkeahgw
        icnjvoroktunleyzpdmfksahgw
        icxjvbroqtunlvyzpdmfkfahgr
        icxjvbroqtgnseyzpdmfxsahgw
        scxjvbroqtunleycpdmfksdhgw
        icxhvbxoqtunleuzpdmfksahgw
        icxjvbruqtunleyzpnmfksfhgw
        icdjvbroqtunleyzpdmfksahup
        ihxjvbroqtunleovpdmfksahgw
        icxjvbroqtunleyzxdmfksahzv
        ocxjvbioqtunleyzpdmfzsahgw
        idxjvbroqtunlyyzpdofksahgw
        izdjvbroqtunleyzpdtfksahgw
        icxjvbrnqtunleyzpdmfksbhgb
        icxjvbrjqtunleyhpdmrksahgw
        icxjvbroqtunleyzpdbflsahgg
        icxjvbmfqtunleyzpdmfkaahgw
        idxjvbroqtunlsyzpdffksahgw
        bcxjvbroqtunleyzpkmfkswhgw
        ivxjvbroqtdnleyzpdmbksahgw
        icxpvbboqtunleyzpdmfksahtw
        ibxjvbroqtunlehzpdmfkmahgw
        icxjvbboqtunleyzpdmfkaahgv
        icxjlaroqtuileyzpdmfksahgw
        icxjvbroftunleyzpdmfqsahew
        ichjvbroqtunleyzpdmiwsahgw
        icxrvbvoqtunleyzpdmiksahgw
        icxjvbroqtunldydpdmfksahgl
        icogvbroqtunleyzpdmfnsahgw
        icxjvbroqtunleszodmfkswhgw
        icxjvbrontunleyztemfksahgw
        icxjvbrovtunleyzpdvkksahgw
        icxjvbroqqucteyzpdmfksahgw
        icmovbroptunleyzpdmfksahgw
        icxjvbqoftunleyzvdmfksahgw
        icxjvbdoqtunleyzpdmfkadhgw
        icxjvbroqtunlgnzpdmfksaqgw
        icxjvbroqtunieygpdyfksahgw
        acdjvbroqtunleyzpdmfkwahgw
        icxjvbroqtunleyzpdmfkfahlj
        icxjvbgoqtunleyepdmvksahgw
        icxjvbpobbunleyzpdmfksahgw
        icxjvbroqtunleurpdmfktahgw
        ipxjvbzoqtunleyzpdmffsahgw
        icxjtbroqtunllyzpdmuksahgw
        icxjvbroqtunbsyzadmfksahgw
        ihxjvoroqtuqleyzpdmfksahgw
        idxjmbroqqunleyzpdmfksahgw
        wcxjvbdoqtunleyzpdmfksahgr
        icxjvbroqtunleygptmfksahgj
        ipxjvbrsqtunleyzpdmfksghgw
        ycxjvbroqtunluyzkdmfksahgw
        icxjvbroxtuulejzpdmfksahgw
        icqjvbroqtunlwyypdmfksahgw
        ioxjhbroqtunleyzphmfksahgw
        icxjvbgoqnunleyzpdmfksahaw
        mcxjvbroqtunleyzpdmfksihgh
        icxjsbroqtunlqyzpdmfksawgw
        icxjvbroqtuoleycpdmftsahgw
        icxjvbroqtunleyzgdifksahlw
        icxjvbmoqtunleyzjfmfksahgw
        icxjvbroqtunlezopdmfksahge
        icxjvbroqtbnlefzpdmfosahgw
        tcxjvbromtunlevzpdmfksahgw
        irxjgbroqtunleyzpdmfksthgw
        icxjvbrojtunleyxpdmoksahgw
        icxrvbroytpnleyzpdmfksahgw
        icxjvbroqtunfeyupdmfksasgw
        ihqjvbroqtunleyzpdmftsahgw
        icxjobroqkunleozpdmfksahgw
        icjjjbroqtualeyzpdmfksahgw
        icxjvbroqtunaeytpdmfksahvw
        icxjvbroqtunzeyzpdmfkshhxw
        icxqvbroqtucleyzxdmfksahgw
        icxjvbrogturleyzxdmfksahgw
        icxjvoqoqtunleyzpdcfksahgw
        iuxjvbroqtunleyzpdmfksopgw
        icxjveroqtunleyzptmfksalgw
        icxjvbroqtunleyzpdmfwcahhw
        iwxjvbroqtlnleyzpdmfksyhgw
        ectjvbroqtanleyzpdmfksahgw
        icxjvnroqtyhleyzpdmfksahgw
        icvjvhboqtunleyzpdmfksahgw
        icxjtbroqtuzleyupdmfksahgw
        icjjvproqtunleyzpsmfksahgw
        icdjvbroqtutleyzpdmiksahgw
        icxjvwroqtujleyzpdmfksahgc
        icxjxbroqtunleyzpdwhksahgw
        icxjvbqoqtunleyzpdmvfsahgw
        icajvbroqtusleyzpdmfksaagw
        icxjvbroqtunbtyzpdmfksmhgw
        kcxjvbroqtxnleyzpdmfkskhgw
        icxjvbqogfunleyzpdmfksahgw
        icxjvbroqtubleyzpdmfdswhgw
        icxjvprlqtunleyzpdmffsahgw
        icxjxbroqtucleyzpdmfksakgw
        dcxrvbroqtunleycpdmfksahgw
        icxjvbrobtunleyzpomfksahgu
        ocxrvbroqtunleyzpdmfssahgw
        icxjvbroktunlejzpdmfksahzw
        icxjvbrovtunleyzmdmfkhahgw
        icxjvbroqtudleygpdmfksfhgw
        bcxjvbroqtubllyzpdmfksahgw
        icxwvbrontunzeyzpdmfksahgw
        icxjvbroqtunleysjbmfksahgw
        icxjvvroztunleyzpdmfksjhgw
        ivxjxbroqtunleyzpdmfksahew
        icxjvbroqtunleyupqufksahgw
        icxjvmrcqtunleyzpdmxksahgw
        icxjvgroqtunleyzpdgfkuahgw
        icxjvbroqthnqeyfpdmfksahgw
        icxjsbuodtunleyzpdmfksahgw
        iuxjzbroqtunleyzpdrfksahgw
        icxjvbrobtunlelzpdmfksahgs
        icxjvbroqtzhljyzpdmfksahgw
        inxtvbroqtunleyzpdmeksahgw
        icgjvbroqtunleyztdmfksahgq
        icxjvagoqtugleyzpdmfksahgw
        icxuvbroqtunleyzpimfkyahgw
        icxzvbroqtfhleyzpdmfksahgw
        icxjjbroqtqnleyzpdmnksahgw
        icjrvbroqtunleszpdmfksahgw
        iexjvbroqtunlgyzpdmfksacgw
        rcxjvbkoqtuoleyzpdmfksahgw
        icxjvbroqgunlwyzpdmfksqhgw
        icxjvbroqtunleqzpsmfksqhgw
        icxjvbroqtubaeyzpdmfksaugw
        """
}
