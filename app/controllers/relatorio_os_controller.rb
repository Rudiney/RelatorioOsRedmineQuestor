# encoding: UTF-8

class RelatorioOsController < ApplicationController
	unloadable

	helper IssuesHelper
	helper JournalsHelper
	helper CustomFieldsHelper
	helper SortHelper
	
	def index
		find_project
	end
	
	def show
		find_project
		
		show_error("Projeto não encontrado!") and return unless @project
		
		params[:issue] ||= {}
		@issue = @project.issues.find_by_id(params[:issue][:id])
		show_error("Tarefa não encontrada!") and return unless @issue
		
		params[:history] ||= {}
		
		@start_date = params[:history][:start_date].blank? ? Date.today.to_s    : params[:history][:start_date]
		@end_date   = params[:history][:end_date].blank?   ? Date.tomorrow.to_s : params[:history][:end_date]
		
		@start_date = Date.parse(@start_date)
		@end_date   = Date.parse(@end_date)
		
		render :layout => false
	end
	
	private
	
	def find_project
		@project = Project.find(params[:project_id]) rescue nil
	end
	
	def show_error(msg)
		flash[:error] = msg 
		redirect_to(:action => 'index', :project_id => @project.id)
	end
end
