$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'scbi_distributed_blast/scbi_dblast_manager.rb'

module ScbiDistributedBlast
  VERSION = '0.0.1'
end