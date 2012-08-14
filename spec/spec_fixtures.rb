require 'dm-sweatshop'

User.fixture {{
  :username => 'DecoyDrone',
  :email => 'faker@me.com',
  :password => 'doobar',
  :password_confirmation => 'doobar',
}}

User.fixture(:unique) {{
  :username => (username = /\w+/.gen),
  :email => "#{username}@example.com",
  :password => (password = /\w+/.gen),
  :password_confirmation => password,
}}

User.fixture(:one) {{
  :username => 'DecoyDrone',
  :email => 'faker@me.com',
  :password => 'doobar',
  :password_confirmation => 'doobar',
  :opportunities => 1.of {Opportunity.make(:set)}
}}

User.fixture(:opp) {{
  :username => (username = /\w+/.gen),
  :email => "#{username}@example.com",
  :password => (password = /\w+/.gen),
  :password_confirmation => password,
  :opportunities => 5.of {Opportunity.make} 
}}

Skill.fixture {{
  :name => (/\w+/.gen) 
}}

Opportunity.fixture {{
  :title => %w(This is title)[rand(3)],
  :description => %w(This is a description)[rand(4)],
  :skills => 1.of {Skill.make}
}}

Opportunity.fixture(:set) {{
  :title => 'This is title',
  :skills => 'Ruby',
  :description => 'This is a description'
}}
