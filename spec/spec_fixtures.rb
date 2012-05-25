require 'dm-sweatshop'

Rook::Opportunity.fixture(:random) {{
  :title => %w(This is title)[rand(3)],
  :skills => %w(Ruby)[rand(1)],
  :description => %w(This is a description)[rand(4)]
}}
