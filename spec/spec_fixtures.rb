require 'dm-sweatshop'

Rook::Opportunity.fixture(:random) {{
  :title => %w(This is title)[rand(3)],
  :skills => %w(Ruby)[rand(1)],
  :description => %w(This is a description)[rand(4)]
}}

Rook::User.fixture {{
  :username => 'DecoyDrone',
  :email => 'faker@me.com',
  :password => 'doobar',
  :password_confirmation => 'doobar'
}}

