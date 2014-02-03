# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pulseaudio/pulseaudio-9999.ebuild,v 1.38 2013/08/09 19:19:40 ssuominen Exp $

EAPI="5"

inherit autotools eutils flag-o-matic multilib-minimal user versionator udev

DESCRIPTION="A networked sound server with an advanced plugin system"
HOMEPAGE="http://www.pulseaudio.org/"
SRC_URI="http://freedesktop.org/software/${PN}/releases/${P}.tar.xz"

# libpulse-simple and libpulse link to libpulse-core; this is daemon's
# library and can link to gdbm and other GPL-only libraries. In this
# cases, we have a fully GPL-2 package. Leaving the rest of the
# GPL-forcing USE flags for those who use them.
LICENSE="!gdbm? ( LGPL-2.1 ) gdbm? ( GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa +asyncns avahi bluetooth +caps dbus doc equalizer +gdbm +glib gnome
gtk ipv6 jack libsamplerate lirc neon +orc oss qt4 realtime ssl systemd
system-wide tcpd test +udev +webrtc-aec +X xen"

RDEPEND=">=media-libs/libsndfile-1.0.20[${MULTILIB_USEDEP}]
	X? (
		>=x11-libs/libX11-1.4.0[${MULTILIB_USEDEP}]
		>=x11-libs/libxcb-1.6[${MULTILIB_USEDEP}]
		>=x11-libs/xcb-util-0.3.1
		x11-libs/libSM[${MULTILIB_USEDEP}]
		x11-libs/libICE[${MULTILIB_USEDEP}]
		x11-libs/libXtst[${MULTILIB_USEDEP}]
	)
	caps? ( sys-libs/libcap[${MULTILIB_USEDEP}] )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.1-r1 )
	alsa? ( >=media-libs/alsa-lib-1.0.19 )
	glib? ( >=dev-libs/glib-2.4.0[${MULTILIB_USEDEP}] )
	avahi? ( >=net-dns/avahi-0.6.12[dbus] )
	jack? ( >=media-sound/jack-audio-connection-kit-0.117 )
	tcpd? ( sys-apps/tcp-wrappers[${MULTILIB_USEDEP}] )
	lirc? ( app-misc/lirc )
	dbus? ( >=sys-apps/dbus-1.0.0[${MULTILIB_USEDEP}] )
	gtk? ( x11-libs/gtk+:3 )
	gnome? ( >=gnome-base/gconf-2.4.0 )
	bluetooth? (
		>=net-wireless/bluez-4.99
		>=sys-apps/dbus-1.0.0
		media-libs/sbc
	)
	asyncns? ( net-libs/libasyncns[${MULTILIB_USEDEP}] )
	udev? ( >=virtual/udev-143[hwdb(+)] )
	realtime? ( sys-auth/rtkit )
	equalizer? ( sci-libs/fftw:3.0 )
	orc? ( >=dev-lang/orc-0.4.9 )
	ssl? ( dev-libs/openssl )
	>=media-libs/speex-1.2_rc1
	gdbm? ( sys-libs/gdbm )
	webrtc-aec? ( media-libs/webrtc-audio-processing )
	xen? ( app-emulation/xen )
	systemd? ( >=sys-apps/systemd-39 )
	dev-libs/json-c[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20131008-r1
		!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )
	>=sys-devel/libtool-2.2.4" # it's a valid RDEPEND, libltdl.so is used

DEPEND="${RDEPEND}
	sys-devel/m4
	doc? ( app-doc/doxygen )
	test? ( dev-libs/check )
	X? (
		x11-proto/xproto[${MULTILIB_USEDEP}]
		>=x11-libs/libXtst-1.0.99.2[${MULTILIB_USEDEP}]
	)
	dev-libs/libatomic_ops
	virtual/pkgconfig
	system-wide? ( || ( dev-util/unifdef sys-freebsd/freebsd-ubin ) )
	dev-util/intltool"
# This is a PDEPEND to avoid a circular dep
PDEPEND="alsa? ( >=media-plugins/alsa-plugins-1.0.27-r1[pulseaudio] )"

# alsa-utils dep is for the alsasound init.d script (see bug #155707)
# bluez dep is for the bluetooth init.d script
# PyQt4 dep is for the qpaeq script
RDEPEND="${RDEPEND}
	equalizer? ( qt4? ( dev-python/PyQt4[dbus] ) )
	X? ( gnome-extra/gnome-audio )
	system-wide? (
		sys-apps/openrc
		alsa? ( media-sound/alsa-utils )
		bluetooth? ( >=net-wireless/bluez-4 )
	)"

# See "*** BLUEZ support not found (requires D-Bus)" in configure.ac
REQUIRED_USE="bluetooth? ( dbus )"

pkg_setup() {
	enewgroup audio 18 # Just make sure it exists

	enewgroup pulse-access
	enewgroup pulse
	enewuser pulse -1 -1 /var/run/pulse pulse,audio
}

EGIT_BOOTSTRAP="NOCONFIGURE=1 ./bootstrap.sh"

src_prepare() {
	epatch_user
}

multilib_src_configure() {
	local myconf=()

	if use gdbm; then
		myconf+=( --with-database=gdbm )
	#elif use tdb; then
	#	myconf+=( --with-database=tdb )
	else
		myconf+=( --with-database=simple )
	fi

	myconf+=(
		--enable-largefile
		$(use_enable glib glib2)
		--disable-solaris
		$(use_enable asyncns)
		$(use_enable oss oss-output)
		$(use_enable alsa)
		$(use_enable lirc)
		$(use_enable neon neon-opt)
		$(use_enable tcpd tcpwrap)
		$(use_enable jack)
		$(use_enable avahi)
		$(use_enable dbus)
		$(use_enable gnome gconf)
		$(use_enable gtk gtk3)
		$(use_enable libsamplerate samplerate)
		$(use_enable bluetooth bluez)
		$(use_enable X x11)
		$(use_enable test default-build-tests)
		$(use_enable udev)
		$(use_enable systemd)
		$(use_enable ipv6)
		$(use_enable ssl openssl)
		$(use_enable webrtc-aec)
		$(use_enable xen)
		$(use_with caps)
		$(use_with equalizer fftw)
		--disable-adrian-aec
		--disable-esound
		--localstatedir="${EPREFIX}"/var
		--with-udev-rules-dir="${EPREFIX}/$(udev_get_udevdir)"/rules.d
	)

	if ! multilib_build_binaries; then
		# disable all the modules and stuff
		myconf+=(
			--disable-oss-output
			--disable-alsa
			--disable-lirc
			--disable-jack
			--disable-avahi
			--disable-gconf
			--disable-gtk3
			--disable-samplerate
			--disable-bluez
			--disable-udev
			--disable-systemd
			--disable-openssl
			--disable-webrtc-aec
			--disable-xen
			--without-fftw

			# tests involve random modules, so just do them for the native
			--disable-default-build-tests

			# hack around unnecessary checks
			# (results don't matter, we're not building anything using it)
			ac_cv_lib_ltdl_lt_dladvise_init=yes
			--with-database=simple
		)
	fi

	ECONF_SOURCE=${S} \
	econf "${myconf[@]}"
}

multilib_src_compile() {
	if multilib_build_binaries; then
		emake
	else
		emake -C src libpulse{,-simple,-mainloop-glib}.la
	fi
}

src_compile() {
	multilib-minimal_src_compile

	if use doc; then
		pushd doxygen
		doxygen doxygen.conf
		popd
	fi
}

multilib_src_test() {
	# We avoid running the toplevel check target because that will run
	# po/'s tests too, and they are broken. Officially, it should work
	# with intltool 0.41, but that doesn't look like a stable release.
	if multilib_build_binaries; then
		emake -C src check
	fi
}

multilib_src_install() {
	if multilib_build_binaries; then
		emake -j1 DESTDIR="${D}" install
	else
		emake DESTDIR="${D}" install-pkgconfigDATA
		emake DESTDIR="${D}" -C src \
			install-libLTLIBRARIES \
			lib_LTLIBRARIES="libpulse.la libpulse-simple.la libpulse-mainloop-glib.la" \
			install-pulseincludeHEADERS
	fi
}

multilib_src_install_all() {
	# Drop the script entirely if X is disabled
	use X || rm "${ED}"/usr/bin/start-pulseaudio-x11

	if use system-wide; then
		newconfd "${FILESDIR}/pulseaudio.conf.d" pulseaudio

		use_define() {
			local define=${2:-$(echo $1 | tr '[:lower:]' '[:upper:]')}

			use "$1" && echo "-D$define" || echo "-U$define"
		}

		unifdef $(use_define avahi) \
			$(use_define alsa) \
			$(use_define bluetooth) \
			$(use_define udev) \
			"${FILESDIR}/pulseaudio.init.d-5" \
			> "${T}/pulseaudio"

		doinitd "${T}/pulseaudio"
	fi

	use avahi && sed -i -e '/module-zeroconf-publish/s:^#::' "${ED}/etc/pulse/default.pa"

	dodoc README todo

	if use doc; then
		pushd doxygen/html
		dohtml *
		popd
	fi

	# Create the state directory
	use prefix || diropts -o pulse -g pulse -m0755

	prune_libtool_files --all
}

pkg_postinst() {
	if use system-wide; then
		elog "PulseAudio in Gentoo can use a system-wide pulseaudio daemon."
		elog "This support is enabled by starting the pulseaudio init.d ."
		elog "To be able to access that you need to be in the group pulse-access."
		elog "If you choose to use this feature, please make sure that you"
		elog "really want to run PulseAudio this way:"
		elog "   http://pulseaudio.org/wiki/WhatIsWrongWithSystemMode"
		elog "For more information about system-wide support, please refer to:"
		elog "	 http://pulseaudio.org/wiki/SystemWideInstance"
		if use gnome ; then
			elog
			elog "By enabling gnome USE flag, you enabled gconf support. Please note"
			elog "that you might need to remove the gnome USE flag or disable the"
			elog "gconf module on /etc/pulse/system.pa to be able to use PulseAudio"
			elog "with a system-wide instance."
		fi
	fi
	if use bluetooth; then
		elog
		elog "The Bluetooth proximity module is not enabled in the default"
		elog "configuration file. If you do enable it, you'll have to have"
		elog "your Bluetooth controller enabled and inserted at bootup or"
		elog "PulseAudio will refuse to start."
	fi
	if use equalizer && ! use qt4; then
		elog "You've enabled the 'equalizer' USE-flag but not the 'qt4' USE-flag."
		elog "This will build the equalizer module, but the 'qpaeq' tool"
		elog "which is required to set equalizer levels will not work."
	fi
}
