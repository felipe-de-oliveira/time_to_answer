DEFAULT_PASSWORD = 123456
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

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
    
    puts "Cadastrando Assuntos Padrões..."
    %x(rails dev:add_subjects)

    puts "Cadastrando Perguntas e Respostas..."
    %x(rails dev:add_answers_and_questions)
  end      
    
  desc "Adiciona administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administrador padrão"
  task add_extras_admins: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona usario padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
 
  desc "Adiciona assuntos padrão"
  task add_subjects: :environment do
   file_name = 'subjects.txt'
   file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
     Subject.create!(description: line.strip)
    end
  end
  
  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|     
        params = { 
          question: {
            description:"#{ Faker::Lorem.paragraph } #{ Faker::Lorem.question }",
            subject:subject,
            answers_attributes: []
          } 
        }

        rand(2..5).times do |j|
          params[:question][:answers_attributes].push(
            { description: Faker::Lorem.sentence, correct: false } 
          )  
        end
        
        index = rand(params[:question][:answers_attributes].size)
        params[:question][:answers_attributes][index] = { description: Faker::Lorem.sentence, correct: true } 

        Question.create!(params[:question])
      end
    end  
  end
end
