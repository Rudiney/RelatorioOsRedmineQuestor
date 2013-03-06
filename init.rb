# encoding: UTF-8

Redmine::Plugin.register :questor_relatorio_os do
	name 'Relatório de OS da Questor Sistemas'
	author 'Rudiney Altair Franceschi'
	description 'Plugin para impressão do relatório de OS utilizado na Questor Sistemas.'
	version '0.0.1'
	url 'http://www.questor.com.br'
	author_url 'mailto:rudiney@oren.net.br'

	permission :relatorio_os, { :relatorio_os => [:index, :show] }, :public => true
	menu :project_menu, :relatorio_os, { :controller => 'relatorio_os', :action => 'index' }, :caption => 'Relatório de OS', :after => :activity, :param => :project_id
end
