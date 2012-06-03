# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate/libindicate-0.6.1-r300.ebuild,v 1.4 2012/05/04 13:12:52 johu Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A library to raise flags on DBus for other components of the desktop to pick up and visualize"
HOMEPAGE="http://launchpad.net/libindicate"
SRC_URI="http://launchpad.net/${PN}/0.7/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.18:2
	>=dev-libs/libdbusmenu-0.3.97:3[introspection?]
	dev-libs/libxml2:2
	x11-libs/gtk+:3
	introspection? ( dev-libs/gobject-introspection )
	!<${CATEGORY}/${PN}-0.6.1-r201"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	app-text/gnome-doc-utils
	dev-util/gtk-doc-am
	dev-lang/vala:0.16[vapigen]
	virtual/pkgconfig"

RESTRICT="test" # for -no-mono.patch

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6.1-no-mono.patch

	sed -i -e 's:-Werror::' {examples,libindicate,libindicate-gtk}/Makefile.{am,in} || die

	sed -i -e 's:#include "glib/gmessages.h"::' libindicate/indicator.c

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		VALA_API_GEN="$(command -v vapigen-0.16)"
		--docdir=/usr/share/doc/${PF}
		$(use_enable introspection)
		--disable-python
		--with-gtk=3
		--with-html-dir=/usr/share/doc/${PF}
	)

	autotools-utils_src_configure
}

#src_install() {
#	default
#	find "${ED}"usr -name '*.la' -exec rm -f {} +
#}
