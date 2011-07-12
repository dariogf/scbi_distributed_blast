$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'scbi_mapreduce'
require 'scbi_distributed_blast/scbi_dblast_manager.rb'

ROOT_PATH=File.join(File.dirname(__FILE__),'scbi_distributed_blast')

module ScbiDistributedBlast
   VERSION = '0.0.4'
end
