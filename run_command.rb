require 'open3'

def run cmd
  result , error = ''
  Open3.popen3(cmd) do |i, o, e, t|
    result = o.read
    error = e.read
    raise StandardError, error unless (t.value.success? or error.empty?)
  end
  result
end
