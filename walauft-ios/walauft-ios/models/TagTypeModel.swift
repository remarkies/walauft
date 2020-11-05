enum TagTypeModel : Codable {
    case style(String)
    case act(String)
    case location(String)
    case date(String)
    
    init(from decoder: Decoder) throws {
        print("before")
        let container = try decoder.container(keyedBy: CodingKey.self)
        print("after")
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0:
            let style = try container.decode(String.self, forKey: .associatedValue)
            self = .style(style)
        case 1:
            let act = try container.decode(String.self, forKey: .associatedValue)
            self = .act(act)
        case 2:
            let location = try container.decode(String.self, forKey: .associatedValue)
            self = .location(location)
        case 3:
            let date = try container.decode(String.self, forKey: .associatedValue)
            self = .date(date)
        }
    }
}
