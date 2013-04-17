module Kernel
  def fire_and_forget(&block)
    pid = fork do
      begin
        yield
      ensure
        Process.exit!
      end
    end
    Process.detach pid
  end
end