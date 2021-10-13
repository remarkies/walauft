export type TagType = 'style' | 'act' | 'location'
export interface Tag {
    type: TagType;
    text: String;
}
export interface Location {
    name: String;
    street: String;
    streetNo: Number;
    zipCode: Number;
    city: String;
    longitude: Number;
    latitude: Number;
}
export interface EventItem {
    id: String;
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
    region: Number;
    events: EventItem[];
}