# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.6.2.ebuild,v 1.10 2013/07/06 22:30:23 xmw Exp $

EAPI=5
VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND=vapigen

inherit flag-o-matic vala autotools-utils

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="http://launchpad.net/dbusmenu"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/libdbusmenu_12.10.3%2B14.04.20140612.orig.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~x86"
IUSE="debug gtk gtk2 +introspection"

RDEPEND=">=dev-libs/glib-2.35.4
	gtk? ( x11-libs/gtk+:3[introspection?] dev-util/gtk-doc )
	gtk2? ( x11-libs/gtk+:2[introspection?] dev-util/gtk-doc )
	introspection? ( >=dev-libs/gobject-introspection-1 )
	!<${CATEGORY}/${PN}-0.5.1-r200"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/intltool
	virtual/pkgconfig
	introspection? ( $(vala_depend) )"

REQUIRED_USE="gtk2? ( gtk )"

S="${WORKDIR}/libdbusmenu-12.10.3+14.04.20140612"
AUTOTOOLS_AUTORECONF=1

pkg_setup() {
	GTKS="`use gtk2 && echo -n 2` `use gtk && echo -n 3`"
}

src_prepare() {
	if use introspection; then
		vala_src_prepare
		export VALA_API_GEN="${VAPIGEN}"
	fi

	autotools-utils_src_prepare
}

src_configure() {
	append-flags -Wno-error #414323

	# dumper extra tool is only for GTK+-2.x, tests use valgrind which is stupid
	local myeconfargs=(
		--docdir=/usr/share/doc/${PF}
		--disable-static
		--disable-silent-rules
		--disable-scrollkeeper
		$(use_enable gtk)
		--disable-dumper
		--disable-tests
		$(use_enable introspection)
		$(use_enable introspection vala)
		$(use_enable debug massivedebugging)
		--with-html-dir=/usr/share/doc/${PF}/html
		HAVE_VALGRIND_TRUE='#'
		HAVE_VALGRIND_FALSE=
	)

	for gtk in ${GTKS}; do
		BUILD_DIR=${WORKDIR}/${P}_build${gtk} autotools-utils_src_configure --with-gtk=${gtk}
	done
}

src_compile() {
	for gtk in ${GTKS}; do
		BUILD_DIR=${WORKDIR}/${P}_build${gtk} autotools-utils_src_compile
	done
}

src_test() { :; } #440192

src_install() {
	for gtk in ${GTKS}; do
		BUILD_DIR=${WORKDIR}/${P}_build${gtk} autotools-utils_src_install -j1
	done

	local a b
	for a in ${PN}-{glib,gtk}; do
		b=/usr/share/doc/${PF}/html/${a}
		[[ -d ${ED}/${b} ]] && dosym ${b} /usr/share/gtk-doc/html/${a}
	done
}
