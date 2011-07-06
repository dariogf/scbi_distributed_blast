# MyWorker defines the behaviour of workers.
# Here is where the real processing takes place

require 'scbi_blast'

class ScbiDblastWorker < ScbiMapreduce::Worker

  # starting_worker method is called one time at initialization
  # and allows you to initialize your variables
  def starting_worker

    # You can use worker logs at any time in this way:
    # $WORKER_LOG.info "Starting a worker"

  end


  # receive_initial_config is called only once just after
  # the first connection, when initial parameters are
  # received from manager
  def receive_initial_config(parameters)

    # Reads the parameters

    # You can use worker logs at any time in this way:
    # $WORKER_LOG.info "Params received"

    # save received parameters, if any
    @params = parameters
    
  end


  # process_object method is called for each received object.
  # Be aware that objs is always an array, and you must iterate
  # over it if you need to process it independently
  #
  # The value returned here will be received by the work_received
  # method at your worker_manager subclass.
  def process_object(objs)
    chunk=[]
    # iterate over all objects received
    objs.each do |n,f|
      chunk<< ">"+n
      chunk<< f
      
      # convert to uppercase
      # f.downcase!
    end
    
    
    
    # puts "Doing blast to #{@params[:blast_cmd]}"
    blast=BatchBlast.do_blast_cmd(chunk.join("\n"),@params[:blast_cmd])
    
    # return objs back to manager
    return blast
  end

  # called once, when the worker is about to be closed
  def closing_worker

  end
end
