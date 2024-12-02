include = String.public_instance_method(:include?)
start_with = String.public_instance_method(:start_with?)
eql = String.public_instance_method(:==)
load = Kernel.singleton_method(:load).unbind
pwd = Dir.pwd.freeze
home = File.join(Dir.home, File.dirname(pwd)).freeze
allowed_script_dir = ARGV.pop.freeze
dotdot = '..'.freeze
unix = '~'.freeze
root1 = '/'.freeze
root2 = ':'.freeze
null = File::NULL.freeze
raise = Kernel.singleton_method(:raise).unbind
se = SecurityError

Kernel.define_singleton_method(: ) do |f|
  raise.bind_call(Kernel, se) if include.bind_call(f, dotdot) || include.bind_call(f, unix)
  if start_with.bind_call(f, root1) || include.bind_call(f, root2)
    unless start_with.bind_call(f, pwd) || start_with.bind_call(f, home) || start_with.bind_call(f, allowed_script_dir)
      puts("Attempted to access: #{f}")
      raise.bind_call(Kernel, se)
    end
  end
end
  = Kernel.singleton_method(: ).unbind
# TODO undef this method

chdir = Dir.singleton_method(:chdir).unbind
aref = Dir.singleton_method(:[]).unbind
dexist = Dir.singleton_method(:exist?).unbind
mkdir = Dir.singleton_method(:mkdir).unbind
class Dir
  class << self
    undef []
    undef chdir
    undef children
    undef chroot
    undef delete
    undef each_child
    undef empty?
    undef entries
    undef exist?
    undef fchdir
    undef for_fd
    undef foreach
    undef getwd
    undef glob
    # undef home
    undef mkdir
    undef new
    undef open
    undef pwd
    undef rmdir
    undef unlink
  end
  undef chdir
  undef children
  undef close
  undef each
  undef each_child
  undef fileno
  undef inspect
  undef path
  undef pos
  undef pos=
  undef read
  undef rewind
  undef seek
  undef tell
  undef to_path
end
Dir.define_singleton_method(:chdir) do |f, &block|
   .bind_call(Kernel, f)
  chdir.bind_call(Dir, f, &block)
end
Dir.define_singleton_method(:[]) do |f|
   .bind_call(Kernel, f)
  aref.bind_call(Dir, f)
end
Dir.define_singleton_method(:exist?) do |f|
   .bind_call(Kernel, f)
  dexist.bind_call(Dir, f)
end
Dir.define_singleton_method(:mkdir) do |f|
   .bind_call(Kernel, f)
  mkdir.bind_call(Dir, f)
end

new = File.instance_method(:initialize)
exist = File.singleton_method(:exist?).unbind
mtime = File.singleton_method(:mtime).unbind
write = IO.singleton_method(:write).unbind
binwrite = IO.singleton_method(:binwrite).unbind
binread = IO.singleton_method(:binread).unbind
read = IO.singleton_method(:read).unbind
readlines = IO.singleton_method(:readlines).unbind
rename = File.singleton_method(:rename).unbind
size = File.singleton_method(:size).unbind
class File
  class << self
    undef absolute_path
    undef absolute_path?
    undef atime
    # undef basename
    undef birthtime
    undef blockdev?
    undef chardev?
    undef chmod
    undef chown
    undef ctime
    undef delete
    # undef directory?
    # undef dirname
    undef empty?
    undef executable?
    undef executable_real?
    undef exist?
    # undef expand_path
    # undef extname
    undef file?
    undef fnmatch
    undef fnmatch?
    undef ftype
    undef grpowned?
    undef identical?
    # undef join
    undef lchmod
    undef lchown
    undef link
    undef lstat
    undef lutime
    undef mkfifo
    undef mtime
    undef new
    undef open
    # undef owned?
    undef path
    # undef pipe?
    # undef readable?
    # undef readable_real?
    undef readlink
    undef realdirpath
    undef realpath
    undef rename
    undef setgid?
    undef setuid?
    # undef size
    undef size?
    undef socket?
    undef split
    undef stat
    # undef sticky?
    undef symlink
    # undef symlink?
    undef truncate
    undef umask
    undef unlink
    undef utime
    # undef world_readable?
    # undef world_writable?
    # undef writable?
    undef writable_real?
    undef zero?
  end
  undef atime
  undef birthtime
  undef chmod
  undef chown
  undef ctime
  undef flock
  undef lstat
  undef mtime
  # undef size
  undef truncate
end

File.define_singleton_method(:new) do |f, *args, &block|
   .bind_call(Kernel, f)
  new.bind_call(File.allocate, f, *args, &block)
end
File.define_singleton_method(:exist?) do |f|
   .bind_call(Kernel, f)
  exist.bind_call(File, f)
end
File.define_singleton_method(:mtime) do |f|
   .bind_call(Kernel, f)
  mtime.bind_call(File, f)
end
File.define_singleton_method(:write) do |f, *args|
   .bind_call(Kernel, f)
  write.bind_call(IO, f, *args)
end
File.define_singleton_method(:binwrite) do |f, *args|
   .bind_call(Kernel, f)
  binwrite.bind_call(IO, f, *args)
end
File.define_singleton_method(:binread) do |f, *args|
   .bind_call(Kernel, f)
  binread.bind_call(IO, f, *args)
end
File.define_singleton_method(:read) do |f, *args|
   .bind_call(Kernel, f)
  read.bind_call(IO, f, *args)
end
File.define_singleton_method(:readlines) do |f, *args|
   .bind_call(Kernel, f)
  readlines.bind_call(IO, f, *args)
end
File.define_singleton_method(:rename) do |f, args|
   .bind_call(Kernel, f)
   .bind_call(Kernel, args)
  rename.bind_call(File, args)
end
File.define_singleton_method(:size) do |f|
   .bind_call(Kernel, f)
  size.bind_call(File, f)
end

reopen = IO.public_instance_method(:reopen)
class IO
  class << self
    undef binread
    undef binwrite
    undef copy_stream
    undef for_fd
    undef foreach
    undef new
    undef open
    undef pipe
    undef popen
    undef read
    undef readlines
    # undef select
    undef sysopen
    undef try_convert
    undef write
  end
  undef <<
  undef advise
  # undef autoclose=
  # undef autoclose?
  # undef binmode
  # undef binmode?
  # undef close
  undef close_on_exec=
  undef close_on_exec?
  # undef close_read
  # undef close_write
  # undef closed?
  # undef each
  # undef each_byte
  # undef each_char
  # undef each_codepoint
  # undef each_line
  # undef eof
  # undef eof?
  # undef external_encoding
  undef fcntl
  undef fdatasync
  undef fileno
  # undef flush
  # undef fsync
  # undef getbyte
  # undef getc
  # undef gets
  # undef inspect
  # undef internal_encoding
  undef ioctl
  # undef isatty
  undef lineno
  undef lineno=
  undef path
  undef pid
  # undef pos
  # undef pos=
  # undef pread
  # undef print
  # undef printf
  # undef putc
  # undef puts
  undef pwrite
  # undef read
  # undef read_nonblock
  # undef readbyte
  # undef readchar
  # undef readline
  # undef readlines
  # undef readpartial
  reopen = public_instance_method(:reopen)
  undef reopen
  # undef rewind
  # undef seek
  # undef set_encoding
  # undef set_encoding_by_bom
  # undef stat
  # undef sync
  # undef sync=
  undef sysread
  undef sysseek
  undef syswrite
  undef tell
  undef timeout
  undef timeout=
  undef to_i
  undef to_io
  undef to_path
  # undef tty?
  undef ungetbyte
  undef ungetc
  # undef wait
  # undef wait_priority
  # undef wait_readable
  # undef wait_writable
  # undef write
  # undef write_nonblock
end

IO.define_method(:reopen) do |f|
  raise.bind_call(Kernel, se) unless eql.bind_call(null, f)
  reopen.bind_call(self, f)
end
Object.send(:remove_const, :TracePoint)

module Process
  class << self
    undef _fork
    undef abort
    undef argv0
    undef clock_getres
    undef clock_gettime
    undef daemon
    undef detach
    undef egid
    undef egid=
    undef euid
    undef euid=
    undef exec
    # undef exit
    # undef exit!
    undef fork
    undef getpgid
    undef getpgrp
    undef getpriority
    undef getrlimit
    undef getsid
    undef gid
    undef gid=
    undef groups
    undef groups=
    undef initgroups
    undef kill
    undef last_status
    undef maxgroups
    undef maxgroups=
    undef pid
    undef ppid
    undef setpgid
    undef setpgrp
    undef setpriority
    undef setproctitle
    undef setrlimit
    undef setsid
    undef spawn
    undef times
    undef uid
    undef uid=
    undef wait
    undef wait2
    undef waitall
    undef waitpid
    undef waitpid2
    undef warmup
  end
end

module ObjectSpace
  class << self
    undef count_objects
    undef define_finalizer
    undef each_object
    undef garbage_collect
    undef undefine_finalizer
  end
end

module Kernel
  remove_method(:`)
  class << self
    # undef Array
    # undef Complex
    # undef Float
    # undef Hash
    # undef Integer
    # undef Rational
    # undef String
    undef __callee__
    undef __dir__
    undef __method__
    undef abort
    undef at_exit
    undef autoload
    undef autoload?
    # undef binding
    # undef block_given?
    # undef callcc
    # undef caller
    # undef caller_locations
    undef catch
    # undef chomp
    # undef chop
    # undef class
    # undef clone
    # undef eval
    undef exec
    # undef exit
    # undef exit!
    # undef fail
    undef fork
    # undef format
    # undef frozen?
    # undef gets
    undef global_variables
    # undef gsub
    undef iterator?
    undef lambda
    undef load
    # undef local_variables
    # undef loop
    undef open
    # undef p
    undef pp
    # undef print
    # undef printf
    # undef proc
    # undef putc
    # undef puts
    # undef raise
    # undef rand
    undef readline
    undef readlines
    undef require
    undef require_relative
    # undef select
    undef set_trace_func
    # undef sleep
    undef spawn
    # undef sprintf
    # undef srand
    # undef sub
    undef syscall
    undef system
    # undef tap
    # undef test
    # undef then
    # undef throw
    undef trace_var
    undef trap
    undef untrace_var
    # undef warn
    # undef yield_self
  end
  # undef Array
  # undef Complex
  # undef Float
  # undef Hash
  # undef Integer
  # undef Rational
  # undef String
  undef __callee__
  undef __dir__
  # undef __method__
  undef abort
  undef at_exit
  undef autoload
  undef autoload?
  # undef binding
  # undef block_given?
  # undef callcc
  # undef caller
  # undef caller_locations
  undef catch
  # undef chomp
  # undef chop
  # undef class
  # undef clone
  # undef eval
  undef exec
  # undef exit
  # undef exit!
  # undef fail
  undef fork
  # undef format
  # undef frozen?
  # undef gets
  undef global_variables
  # undef gsub
  undef iterator?
  undef lambda
  undef load
  # undef local_variables
  # undef loop
  undef open
  # undef p
  undef pp
  # undef print
  # undef printf
  # undef proc
  # undef putc
  # undef puts
  # undef raise
  # undef rand
  undef readline
  undef readlines
  undef require
  undef require_relative
  # undef select
  undef set_trace_func
  # undef sleep
  undef spawn
  # undef sprintf
  # undef srand
  # undef sub
  undef syscall
  undef system
  # undef tap
  # undef test
  # undef then
  # undef throw
  undef trace_var
  undef trap
  undef untrace_var
  # undef warn
  # undef yield_self
end

rb = '.rb'.freeze
Kernel.define_method(:require) do |f|
   .bind_call(Kernel, f)
  load.bind_call(Kernel, f.end_with?(rb) ? f : f + rb)
end

Object.send(:remove_const, :FileTest)
File.send(:remove_const, :Stat)
