class Dir
  class << self
    undef chdir
    undef children
    undef chroot
    undef delete
    undef each_child
    # undef []
    undef empty?
    undef entries
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

  exist = method(:exist?)
  define_singleton_method(:exist?) do |path|
    raise SecurityError if path.include?('..')
    exist.call(path)
  end

  def initialize()
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

class File
  class << self
    undef chmod
    undef chown
    undef delete
    undef lchmod
    undef lchown
    undef link
    # undef new
    undef open
    undef rename
    undef symlink
    undef truncate
    undef unlink
  end

  # def initialize
  # end

  undef chmod
  undef chown
  undef flock
  undef mtime
  undef truncate
end
