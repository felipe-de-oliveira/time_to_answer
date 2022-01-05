class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only:[:edit, :update, :destroy]

  def index
    @subjects = Subject.all.page(params[:page])
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params_subject)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Assuntos/Aréas Cadastrado com Sucesso!!!"
    else 
      render :new
    end
  end

  def update
    if @subject.update(params_subject)
      redirect_to admins_backoffice_subjects_path, notice:"Assuntos/Aréas atualizado com sucesso!"
    else 
      render :edit
    end
  end
  
  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_sebjects_path, notice:"Assuntos/Aréas apagado com sucesso!"
    else 
      render :index
    end
  end

  private
  
  def set_subject
    @subject = Subject.find(params[:id])
  end

  def params_admin
    params.require(:subject).permit(:description)
  end
end
