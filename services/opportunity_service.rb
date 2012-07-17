class OpportunityService
  def self.create(user, data)
    data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    Opportunity.create(data.update(:user_id => user.id))
##To make this work with mocha expectations you would need to add id = nil into what is expected
=begin
    opportunity = Opportunity.new data.update(:user_id => user.id)
    binding.pry
      if opportunity.save
        #saved
      else
        opportunity.errors.each do |e|
          puts e
        end
      end
=end
  end
end
