class grub2 {

	$grub_default = $grub_default ? {
		""      => 0,
		default => $grub_default
	}

	$grub_timeout = $grub_timeout ? {
		""      => 5,
		default => $grub_timeout
	}

	$grub_distributor = $grub_distributor ? {
		""      => "`lsb_release -i -s 2> /dev/null || echo Debian`",
		default => $grub_distributor
	}

	$grub_cmdline_linux_default = $grub_cmdline_linux_default ? {
		""      => "quiet",
		default => $grub_cmdline_linux_default
	}

	$grub_cmdline_linux = $grub_cmdline_linux ? {
		""      => "",
		default => $grub_cmdline_linux
	}

	$grub_badram = $grub_badram ? {
		""      => false,
		default => $grub_badram
	}

	$grub_terminal = $grub_terminal ? {
		""      => false,
		default => $grub_terminal
	}
	
	$grub_serial_command = $grub_serial_command ? {
		""      => false,
		default => $grub_serial_command
	}

	$grub_gfxmode = $grub_gfxmode ? {
		""      => false,
		default => $grub_gfxmode
	}

	# In this case, false is the default value, not unset
	$grub_disable_linux_uuid = $grub_disable_linux_uuid ? {
		""      => false,
		default => $grub_disable_linux_uuid
	}

	# In this case, false is the default value, not unset
	$grub_disable_linux_recovery = $grub_disable_linux_recovery ? {
		""      => false,
		default => $grub_disable_linux_recovery
	}

	$grub_init_tune = $grub_init_tune ? {
		""      => false,
		default => $grub_init_tune
	}

	package { "grub-pc":
		ensure => installed
	}

	file {
		"/etc/default/grub":
			content  => template("grub2/grub.erb"),
			owner   => root,
			group   => root,
			require => Package["grub-pc"],
			mode    => 0644,
			notify  => Exec["update_grub"];
	}

	exec { "update_grub":
		command => "update-grub",
		refreshonly => true
	}
}
