# encoding: UTF-8

require File.expand_path('../../test_helper', __FILE__)

class RelatorioOsControllerTest < ActionController::TestCase
	fixtures :projects, :issue_statuses
	
=begin
	projeto => tarefas
	1 => 1,2,3,7,8,11,12
	2 => 4
	3 => 5,13,14
	5 => 6,9,10
=end	
	setup do
		@p = Project.find_by_id(1)
		@params = {:project_id => @p.id}
	end
	
	test "00 - Deve ter o index" do
		get(:index, @params)
		
		assert_response(:success)
		assert_equal(@p, assigns(:project))
	end
	
	test "02 - carrega o projeto" do
		assert(@p, "o projeto tem que existir")
		post(:show, {:project_id => @p.id})
		assert_not_nil(assigns(:project), 'nao acho o projeto')
		assert_equal(@p, assigns(:project), 'acho o projeto errado')
	end
	
	test "03 - carrega a tarefa" do
		post(:show, @params.merge({:issue => {:id => 1}}))
		
		assert_response(:success)
		assert_equal(Issue.find(1), assigns(:issue), "tarefa 1")
	end
	
	test "04 - só do projeto escolhido" do
		post(:show, @params.merge({:issue => {:id => 13}}))
		error()
	end
	
	test "05 - tarefa nao existe" do
		post(:show, @params.merge({:issue => {:id => 800}}))
		error()
	end
	
	private
	
	def error
		assert_redirected_to(:action => :index, :project_id => @p.id)
		assert_not_nil(flash[:error])
	end
end