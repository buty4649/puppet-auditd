define auditd::audisp::plugin (
  Boolean $active                      = true,
  Pattern[/^(out|in)$/] $direction     = 'out',
  Optional[String] $path               = undef,
  Pattern[/^(builtin|always)$/] $type  = 'always',
  Optional[String] $args               = undef,
  Pattern[/^(binary|string)$/] $format = 'string',

) {

  if $active == true {
    $real_active = 'yes'
  }
  elsif $active == false {
    $real_active = 'no'
  }

  file { "/etc/audisp/plugins.d/${name}.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/audisp.plugin.erb"),
    notify  => Service['auditd'],
  }

}
