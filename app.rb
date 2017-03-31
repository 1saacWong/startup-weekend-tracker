require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/member')
require('./lib/team')
require('pry')


  # get('/') do
  #   erb(:index)
  # end

  get('/teams/new') do
     erb(:teams_form)
  end

  get('/') do
    @teams = Team.all()
    # binding.pry
    erb(:index)
  end

  post('/') do
    name = params.fetch('name')
    Team.new(name).save()
    @teams = Team.all()
    erb(:success)
  end

  get('/members/:id') do
    @member = Member.find(params.fetch('id').to_i())
    erb(:member)
  end

  get('/teams/:id') do
    @team = Team.find(params.fetch('id').to_i())
    erb(:team)
  end

  get('/teams/:id/members/new') do
      @team = Team.find(params.fetch('id').to_i())
      erb(:team_members_form)
  end

  post('/members') do
    member_name = params.fetch('member_name')
    role = params.fetch('role')
    gender = params.fetch('gender')
    @member = Member.new(member_name, role, gender)
    @member.save()
    @team = Team.find(params.fetch('team_id').to_i())
    @team.add_member(@member)
    erb(:success)
  end
