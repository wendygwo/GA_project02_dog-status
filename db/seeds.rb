# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Relationship.destroy_all
Owner.destroy_all
Dog.destroy_all

admin = Owner.create(username: 'admin',first_name: 'admin', last_name:'admin', password: 'password', is_site_admin: true)

owner1 = Owner.create(username: 'fredflintstone',first_name: 'Wilma', last_name:'Flintstone', password: 'password', is_site_admin: false)
owner12 = Owner.create(username: 'wilmaflintstone',first_name: 'Wilma', last_name:'Flintstone', password: 'password', is_site_admin: true)
dog1 =  Dog.create(dog_name: 'Dino', breed:'dinosaur', birthday:'2010-01-01',food_low_flag:false,treats_low_flag:false)
owner1.relationships.create(dog: dog1, is_dog_admin:true)
owner12.relationships.create(dog: dog1, is_dog_admin:false)
admin.relationships.create(dog: dog1, is_dog_admin:true)

owner2 = Owner.create(username: 'georgejetson',first_name: 'George', last_name:'Jetson', password: 'password', is_site_admin: false)
owner22 = Owner.create(username: 'janejetson',first_name: 'Jane', last_name:'Jetson', password: 'password', is_site_admin: true)
dog2 =  Dog.create(dog_name: 'Astro', breed:'space dog', birthday:'2000-01-01',food_low_flag:false,treats_low_flag:false)
owner2.relationships.create(dog: dog2, is_dog_admin:true)
owner22.relationships.create(dog: dog2, is_dog_admin:false)
admin.relationships.create(dog: dog2, is_dog_admin:true)

owner3 = Owner.create(username: 'cliffordsowner',first_name: 'Clifford', last_name:'Owner', password: 'password', is_site_admin: false)
owner32 = Owner.create(username: 'cliffordsowner2',first_name: 'Clifford', last_name:'Owner2', password: 'password', is_site_admin: true)
dog3 =  Dog.create(dog_name: 'Clifford', breed:'big red dog', birthday:'1900-01-01',food_low_flag:false,treats_low_flag:false)
owner3.relationships.create(dog: dog3, is_dog_admin:true)
owner32.relationships.create(dog: dog3, is_dog_admin:false)
admin.relationships.create(dog: dog3, is_dog_admin:true)