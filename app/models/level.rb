class Level < ActiveHash::Base
  self.data = [
    {id: 1, name: '--'},
    {id: 2, name: '1部'},
    {id: 3, name: '2部'},
    {id: 4, name: '3部'},
    {id: 5, name: '4部'}
  ]

  include ActiveHash::Associations
  has_many :recruitments
end