require 'json'

require 'scbi_fasta'

# MyWorkerManager class is used to implement the methods
# to send and receive the data to or from workers
class ScbiDblastManager < ScbiMapreduce::WorkManager

  # init_work_manager is executed at the start, prior to any processing.
  # You can use init_work_manager to initialize global variables, open files, etc...
  # Note that an instance of MyWorkerManager will be created for each
  # worker connection, and thus, all global variables here should be
  # class variables (starting with @@)
  def self.init_work_manager(input_file, blast_cmd, output_file)
    # save blast_cmd
    @@blast_cmd=blast_cmd
    
    # define output file
    if output_file.nil?
      @@output_file=STDOUT
    else
      @@output_file=File.open(output_file,'w')
    end

    # open input file in fasta
    @@fqr = FastaQualFile.new(input_file)
    
  end

  # end_work_manager is executed at the end, when all the process is done.
  # You can use it to close files opened in init_work_manager
  def self.end_work_manager
    # close opened files
    @@fqr.close
    @@output_file.close if @@output_file!=STDOUT
  end

  # worker_initial_config is used to send initial parameters to workers.
  # The method is executed once per each worker
  def worker_initial_config
    # send blast_cmd to workers
    {:blast_cmd=>@@blast_cmd}
  end

  # next_work method is called every time a worker needs a new work
  # Here you can read data from disk
  # This method must return the work data or nil if no more data is available
  def next_work
    
    # read next sequence from inputfile
    n,f = @@fqr.next_seq

    if n.nil?
      return nil
    else
      return [n,f]
    end

  end


  # work_received is executed each time a worker has finished a job.
  # Here you can write results down to disk, perform some aggregated statistics, etc...
  def work_received(results)
    # write results to disk
    @@output_file.puts results
  end

end
