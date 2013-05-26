class grub2(
        $grub_default = 0,
        $grub_timeout = 5,
        $grub_distributor = "`lsb_release -i -s 2> /dev/null || echo Debian`",
        $grub_cmdline_linux_default = "quiet",
        $grub_cmdline_linux = "",
        $grub_badram = false,
        $grub_terminal = false,
        $grub_serial_command = false,
        $grub_gfxmode = false,
        $grub_disable_linux_uuid = false,
        $grub_disable_linux_recovery = false,
        $grub_init_tune = false,
) {
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
