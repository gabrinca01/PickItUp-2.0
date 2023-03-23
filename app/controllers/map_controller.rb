class MapController < ApplicationController
  def index
    @query =Challenge.select(:luogo,:raggio)
    @other_challenges = Array.new
    @query.each do |t|
      @lat = t.luogo.split(',')[0]
      @long = t.luogo.split(',')[1]
      @rad  =t.raggio.to_s
      @other_challenges.push (@lat+':'+@long+':'+@rad)
    end
    @other_challenges = @other_challenges.to_json.html_safe

    
    @query=JoinChallenge.select(:challenge_id).where.not(user_id:current_user.id).distinct
    @to_join = Challenge.where('id in (?)',@query)
      @join_challenge = JoinChallenge.new

    
  end
end
