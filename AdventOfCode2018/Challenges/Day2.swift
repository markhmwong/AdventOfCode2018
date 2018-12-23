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
//https://github.com/virumax/Levenshtein-swift4/blob/master/Tools.swift
class Tools {
    
    private class func min(numbers: Int...) -> Int {
        return numbers.reduce(numbers[0]) {$0 < $1 ? $0 : $1}
    }
    
    class Array2D {
        var cols:Int, rows:Int
        var matrix: [Int]
        
        
        init(cols:Int, rows:Int) {
            self.cols = cols
            self.rows = rows
            matrix = Array(repeating:0, count:cols*rows)
        }
        
        subscript(col:Int, row:Int) -> Int {
            get {
                return matrix[cols * row + col]
            }
            set {
                matrix[cols*row+col] = newValue
            }
        }
        
        func colCount() -> Int {
            return self.cols
        }
        
        func rowCount() -> Int {
            return self.rows
        }
    }
    
    class func levenshtein(aStr: String, bStr: String) -> Int {
        let a = Array(aStr.utf16)
        let b = Array(bStr.utf16)
        
        let dist = Array2D(cols: a.count + 1, rows: b.count + 1)
        
        for i in 1...a.count {
            dist[i, 0] = i
        }
        
        for j in 1...b.count {
            dist[0, j] = j
        }
        
        for i in 1...a.count {
            for j in 1...b.count {
                if a[i-1] == b[j-1] {
                    dist[i, j] = dist[i-1, j-1]  // noop
                } else {
                    dist[i, j] = min(
                        numbers: dist[i-1, j] + 1,  // deletion
                        dist[i, j-1] + 1,  // insertion
                        dist[i-1, j-1] + 1  // substitution
                    )
                }
            }
        }
        return dist[a.count, b.count]
    }
}


//https://gist.github.com/RuiCarneiro/82bf91214e3e09222233b1fc04139c86
extension String {
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

extension String {
    public func levenshtein(_ other: String) -> Int {
        let sCount = self.count
        let oCount = other.count
        
        guard sCount != 0 else {
            return oCount
        }
        
        guard oCount != 0 else {
            return sCount
        }
        
        let line : [Int]  = Array(repeating: 0, count: oCount + 1)
        var mat : [[Int]] = Array(repeating: line, count: sCount + 1)
        
        for i in 0...sCount {
            mat[i][0] = i
        }
        
        for j in 0...oCount {
            mat[0][j] = j
        }
        
        for j in 1...oCount {
            for i in 1...sCount {
                if self[i - 1] == other[j - 1] {
                    mat[i][j] = mat[i - 1][j - 1]       // no operation
                }
                else {
                    let del = mat[i - 1][j] + 1         // deletion
                    let ins = mat[i][j - 1] + 1         // insertion
                    let sub = mat[i - 1][j - 1] + 1     // substitution
                    mat[i][j] = min(min(del, ins), sub)
                }
            }
        }
        
        return mat[sCount][oCount]
    }
}

struct Day2 {
    
    func part2() -> Void {
        //Notes:
        //Pair of strings can only differ by 1 character
        //4 characters must be the same - minimum
        //find the letters that are common between the two strings
        //perhaps sort the string first
        //then compare
        
        let data = self.prepareArrForReadability(data: self.rawData)
        
        let result = Tools.levenshtein(aStr: "abcde", bStr: "axcyea")
        print("result \(result)")
        
        for (indexi, stringA) in data.enumerated() {
            for indexj in stride(from: indexi, to: data.count, by: 1) {
                let levDist = Tools.levenshtein(aStr: String(data[indexi]), bStr: String(data[indexj]))
                if levDist == 1 {
                    print(data[indexi])
                    print(data[indexj])
                }
//                print("----")
            }
        }
        print("complete")
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
    
    func prepareArrForReadability<T: StringProtocol>(data: T) -> [String.SubSequence] {
        return data.split(separator: "\n") as! [String.SubSequence]
    }
    
    let siteDataPart2: String = """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
    """
    
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
