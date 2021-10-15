export type TagType = 'style' | 'act' | 'location'
export interface Tag {
    type: TagType;
    text: String;
}
export interface Location {
    name: String;
    street: String;
    streetNo: number;
    zipCode: number;
    city: String;
    longitude: number;
    latitude: number;
}
export interface EventItem {
    _id: String;
    name: String;
    date: String;
    time: String;
    tags: [Tag];
    minage: String;
    price: String;
    description: String;
    location: Location;
}
export interface EventDay {
    _id: String;
    date: String;
    region: number;
    events: EventItem[];
}
export type CityName = 'Lozärn' | 'Bärn' | 'Baasel' | 'St.Galle' | 'Züri' ;
export interface City {
    id: number;
    name: CityName,
    color: [number, number, number] //HSL
}