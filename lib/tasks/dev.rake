DEFAULT_PASSWORD = 123456

namespace :dev do
  desc "TODO"
  task setup: :environment do
    
    puts "Apagando o Banco de Dados..."
    %x(rails db:drop)

    puts "Criando Banco de Dados..."
    %x(rails db:create)

    puts "Migrando o Banco de Dados..."
    %x(rails db:migrate)

    puts "Criando um Administador padrão..."
    %x(rails dev:add_default_admin)

    puts "Criando Administadores extras..."
    %x(rails dev:add_extras_admins)

    puts "Criando um Usuário padrão..."
    %x(rails dev:add_default_user)
  end      
    
  desc "Adicionar administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adicionar administrador padrão"
  task add_extras_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adicionar usario padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
end
